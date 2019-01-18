<?php
// 
// 文件API公共控制器, 公共方法都这在这
// 
namespace api\file\controller;

use cmf\controller\RestBaseController;
use think\Db;

use QRcode;
use OSS\OssClient;
use OSS\Core\OssException;

class BaseController extends RestBaseController
{

    // 格式化获取到的文件id, 返回文件id数组
    protected function format_files($files, $msg, $istag=0)
    {
        // 获取到的是一个用逗号分隔的文件字符串, 将字符串按逗号分隔并存入数组中
        $files = explode(',', $files);
        // 去除数组中的空值
        $files = array_filter($files);

        if (!$istag) {
            $count = count($files);
            if ($count == 0) {
                $this->error($msg);
            }
        }
        return $files;
    }

    // 生成一个随机字符串
    protected function get_random_str($len)
    {
        $strs = '1234567890qwertyuiopasdfghjklzxcvbnm';
        $str  = substr(str_shuffle($strs), mt_rand(0, strlen($strs)-11), $len);
        return $str;
    }

    // 生成链接二维码
    protected function generate_qr_code($link, $image_name)
    {
        // 导入生成二维码类库
        vendor('phpqrcode.phpqrcode');
        $value = $link; //二维码内容
        $errorCorrectionLevel = 'L'; //容错级别
        $matrixPointSize = 6; //生成图片大小

        //生成二维码图片
        $qr_path = 'upload/QRshare/' . $image_name . '.png';
        $qr_pic = ROOT_PATH . 'public' . DS . $qr_path;
        $qr_code = new QRcode();
        $qr_code->png($value, $qr_pic, $errorCorrectionLevel, $matrixPointSize, 2);
        $logo = ROOT_PATH . 'public' . DS . "static/images/headicon.png"; //准备好的logo图片
        $QR = $qr_pic;//已经生成的原始二维码图

        if ($logo !== FALSE) {
            $QR = imagecreatefromstring(file_get_contents($QR));
            $logo = imagecreatefromstring(file_get_contents($logo));
            $QR_width = imagesx($QR); //二维码图片宽度
            $QR_height = imagesy($QR); //二维码图片高度
            $logo_width = imagesx($logo); //logo图片宽度
            $logo_height = imagesy($logo); //logo图片高度
            $logo_qr_width = $QR_width / 5;
            $scale = $logo_width/$logo_qr_width;
            $logo_qr_height = $logo_height/$scale;
            $from_width = ($QR_width - $logo_qr_width) / 2;
            //重新组合图片并调整大小
            imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width,
            $logo_qr_height, $logo_width, $logo_height);
        } 

        //输出图片
        imagepng($QR, $qr_pic);
        $qr_code = $this->request->domain(). '/php/public/' . $qr_path;

        return [
            'qr_code' => $qr_code,
            'qr_path' => $qr_path,
        ];
    }

    // 递归获取传入的文件夹所在的路径
    // dir_id是要进入的目录id, root_id为根目录下的第一层目录id集合
    protected function get_prev_nav($dir_id, $root_id, $nav=[])
    {
        // 如果dir_id存在root_id中则为根目录并返回结果
        if (in_array($dir_id, $root_id)) {
            $file = Db::name('asset')->where('id', $dir_id)->find();
            $folder = array(
                'id'       => $file['id'],
                'filename' => $file['filename'],
            );
            array_unshift($nav, $folder);  // 将文件夹插入到面包屑数组最前面
        } elseif ($dir_id == 0) {
            $a = 1;
        } else {
            $file = Db::name('asset')
                ->alias('a')
                ->field('a.id, a.filename, b.dir_id')
                ->where('a.id', $dir_id)
                ->join('dir_file b', 'a.id = b.file_id')
                ->find();

            $dir_id = $file['dir_id'];

            $folder = array(
                'id'       => $file['id'],
                'filename' => $file['filename'],
            );
            array_unshift($nav, $folder);  // 将文件夹插入到面包屑数组最前面

            $nav = $this->get_prev_nav($dir_id, $root_id, $nav);
            
        }
        return $nav;
    }

    // 读取传入的文件夹下第一层的文件列表并返回
    protected function read_dir($dir_id, $owner=0)
    {

        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $order   = $this->request->param('order');
        $tagFind = $this->request->param('tagFind');

        if ($keyword) {
            $where['filename'] = ['like', "%$keyword%"];
        } else {
            // 如果不按关键字搜索则直接搜索文件夹下的文件
            $where['df.dir_id']   = $dir_id;
        }
        if ($order == 'time') {
            $defaultOrder = 'create_time DESC';  // 按时间降序
        } elseif ($order == 'size') {
            $defaultOrder = 'file_size DESC';  // 按文件大小升序
        } else {
            $defaultOrder = 'filename ASC';  // 默认按文件名升序
        }

        // 如果为0则表示进入用户根目录, 只显示自己的文件
        if ($dir_id == 0) {
            $where['user_id'] = $this->getUserId();
        }

        // 根据$owner的值决定显示公私有还是只显示私有文件
        // 传1表示是my_files接口调用, 只显示私有文件
        if ($owner) {
            $where['private_file'] = 1;
        }

        // 如果按标签查找, 执行另一个查询语句
        if ($tagFind) {
            $where['t.tag_name'] = ['like', "%$tagFind%"];
            if ($where['df.dir_id'] !== '') {
                unset($where['df.dir_id']);
                unset($where['user_id']);
            }
            $where['t.user_id'] = $this->getUserId();
            $files = Db::name('asset')
                ->alias('a')
                ->field('a.id, a.user_id, a.file_size, a.create_time, a.download_times, a.filename, a.oss_host, a.oss_file, a.suffix, a.type')
                ->join('file_tag ft', 'ft.file_id = a.id')
                ->join('tag t', 'ft.tag_id = t.id')
                ->where('status', 1)
                ->where($where)
                ->order($defaultOrder)
                ->select();
        } else {
            $files = Db::name("asset")
                ->alias('a')
                ->field('a.id, a.user_id, a.file_size, a.create_time, a.download_times, a.filename, a.oss_host, a.oss_file, a.suffix, a.type')
                ->join('dir_file df', 'a.id = df.file_id')
                ->where('a.status', 1)
                ->where($where)
                ->order($defaultOrder)
                ->select();
        }

        return $files;
    }

    // 根据文件后缀名判断文件类型
    protected function classify($suffix)
    {
        $suffix = strtolower($suffix);  // 将传入的后缀转换为小写

        $images     = array('bmp', 'jpeg', 'jpg', 'png', 'gif', 'tiff', 'psd');
        $videos     = array('avi', 'rmvb', 'mp4', 'wmv', 'mpg', 'rm', 'rmvb',
            'mov', 'dat', 'vob', 'flv', '3gp');
        $music      = array('mp3', 'ra', 'rma', 'vma', 'asf', 'mid', 'midi',
            'rmi', 'xmi', 'ogg', 'vqf', 'tvq', 'mod', 'ape', 'aiff', 'au');
        $documents  = array('xlsx', 'doc', 'docx', 'txt', 'pptx', 'ppt', 'pdf',
            'csv', 'key', );

        if (in_array($suffix, $images)) {
            return '图片';
        } else if (in_array($suffix, $videos)) {
            return '视频';
        } else if (in_array($suffix, $music)) {
            return '音乐';
        } else if (in_array($suffix, $documents)) {
            return '文档';
        } else {
            return '其他';
        }
    }

    // 获取oss验证信息
    protected function get_client()
    {
        $client = [
            'region'          => 'oss-cn-beijing.aliyuncs.com/',
            'accessKeyId'     => '',    // 请填写您的AccessKeyId。
            'accessKeySecret' => '',     // 请填写您的AccessKeySecret。
            'bucket'          => 'gdqy-bucket-2',
        ];
        return $client;
    }

    // 为文件添加标签, $tags:要添加的标签  $fid:文件id
    protected function add_tag($tags, $fid)
    {
        $userId = $this->getUserId();
        $data = [];
        foreach ($tags as $key => $value) {
            // 判断用户是否已有同名标签
            $tid = $this->exist_tag($value);
            if (!$tid) {
                $tag = [
                    'tag_name' => $value,
                    'user_id'  => $userId,
                ];
                $tid = Db::name('tag')->insertGetId($tag);
                $data[] = [
                'file_id' => $fid,
                'tag_id'  => $tid,
                ];
            }
        }
        if (count($data) > 0) {
            Db::name('file_tag')->insertAll($data);
        }
    }

    // 判断用户是否已有标签, 没有返回0, 存在返回标签id
    protected function exist_tag($tag)
    {
        $userId = $this->getUserId();
        $result = Db::name('tag')->where('tag_name', $tag)->where('user_id', $userId)->select();
        if (count($result) > 0) {
            return $result[0]['id'];
        } else {
            return 0;
        }
    }


}