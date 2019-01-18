<?php
//
// 个人文件管理控制器
//
namespace api\file\controller;

use api\file\controller\UserBaseController;
use think\validate;
use think\Db;

use DateTime;
use OSS\OssClient;
use OSS\Core\OssException;

class FilesController extends UserBaseController
{

    /**
     * 上传文件
     * @param  string $filename   带路径文件名
     * @param  string $file_size  文件大小
     * @param  string $status     公私有文件, 0:公有, 1:私有
     * @param  array  $tags       文件标签
     * @param  string $isdir      1:文件夹, 0:文件
     * @param  string $file_md5   文件的md5值
     * @param  int    $dir_id     文件夹id, 根目录传0
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function upload()
    {
        $data = $this->request->param();
        $result = $this->validate($data, 'File.upload');
        if ($result !== true) {
            $this->error($result);
        }

        $userId = $this->getUserId();
        $file = [];
        $file['user_id']       = $userId;
        $file['file_size']     = $data['file_size'];
        $file['status']        = $data['status'];  // 1:私有 2:公有,待审核
        $file['private_file']  = $data['status'];
        $file['create_time']   = time();
        $file['filename']      = trim(strrchr($data['filename'], '/'), '/');
        $file['suffix']        = pathinfo($data['filename'], PATHINFO_EXTENSION);
        if ($data['isdir'] == 1) {
            $file['type']      = '/';
        } else {
            $file['oss_host']  = "http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com";
            // 根据文件后缀返回分类
            $file['type']      = $this->classify($file['suffix']);
            $file['file_md5']  = $data['file_md5'];

            // 查看上传的文件在oss中是否已存在
            $findFile = Db::name("asset")
                ->where('file_md5', $data['file_md5'])
                ->select();

            // 如果已存在则将路径oss_file设置成与已有的已有, 并将file_number加一
            if (count($findFile) >= 1) {
                $file_number = $findFile[0]['file_number'];
                
                $file['oss_file']    = $findFile[0]['oss_file'];
                $file['file_number'] = $file_number + 1;

                $result = Db::name('asset')
                    ->where('file_md5', $data['file_md5'])
                    ->update(['file_number' => $file_number+1]);
                
            } else {
                $file['oss_file']    = $data['filename'];
                $file['file_number'] = 1;
            }
        }

        $file_id = Db::name("asset")->insertGetId($file);

        // 将文件夹和文件关联起来
        $dir_file = [
            'dir_id'  => $data['dir_id'],
            'file_id' => $file_id,
        ];
        Db::name('dir_file')->insert($dir_file);

        if ($data['tags']) {
            // 格式化获取到的标签, 返回标签数组
            $tags = $this->format_files($data['tags'], '', 1);
            $this->add_tag($tags, $file_id);
        }

        $this->success('上传成功');

    }

    /**
     * 我的所有文件, 包含文件夹, 可添加查询和排序条件
     * @param  int    $dir_id  文件夹id  0代表根目录
     * @param  string $order   排序 filename:文件名 time:时间 size:大小, 可选
     * @param  string $tagFind 标签查询符合的文件, 可选
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表(list)
     */
    public function my_files()
    {
        $dir_id = $this->request->param('dir_id');
        $files = $this->read_dir($dir_id, 1);
        $this->success('查询成功', $files);
    }

    /**
     * 按输入的分类返回用户的文件列表
     * @param  string $type 文件分类: 图片 音乐 视频 文档 其他
     * @param  string $keyword 关键字查询文件名符合的文件, 可选
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表(list)
     */
    public function class_files()
    {
        $data = $this->request->param();
        $userId = $this->getUserId();

        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        if ($keyword) {
            $where['filename'] = ['like', "%$keyword%"];
        }

        $types = array('图片', '音乐', '视频', '文档', '其他');
        if (!empty($data['type'])) {
            if (in_array($data['type'], $types)) {
                $type = $data['type'];
            } else {
                $this->error('请输入有效的文件类型');
            }
        } else {
            $this->error('请输入文件类型');
        }

        $files = Db::name("asset")
            ->field('id, user_id, file_size, create_time, download_times, filename, oss_host, oss_file, suffix, type')
            ->where('user_id', $userId)
            ->where('status', 1)
            ->where('type', $type)
            ->where('private_file', 1)
            ->where($where)
            ->order('id DESC')
            ->select();

        $this->success('请求成功', $files);
    }

    /**
     * 删除文件和文件夹
     * @param  string  files  文件和文件夹id, 多个id用英文逗号隔开
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function delete_file()
    {
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择要删除的文件');

        // 获取跟传入的文件相关联的所有文件id
        $files = $this->traversal_folder($files);

        // $objects 长度不等于 0 表示获取到需要删除的文件列表
        if (count($files) !== 0) {
            $objects = $this->get_objects($files);
            // 去除数组中的空值
            $objects = array_filter($objects);
            if (count($objects) >= 1) {
                $result = $this->delete_oss_files($objects);
                if (!$result) {
                    $this->error('oss删除失败, 请重试');
                }
            }
        }
        
        $result = $this->delete_db_files($files);
        if (!$result) {
            $this->error('db删除失败, 请重试');
        }
        $this->success('文件删除成功');
    }

    // 获取文件在oss上的真实路径, 用于删除文件
    // 参数是文件id列表
    protected function get_objects($files)
    {
        $objects = [];
        foreach ($files as $key => $value) {
            $file = Db::name('asset')->where('id', $value)->find();

            // 查看上传的文件在oss中是否存在多个
            // 如果只有一个就将oss上的文件一起删除
            // 如果有多个则将所有符合条件的文件的file_number减一
            if ($file['file_number'] == 1) {
                $objects[] = $file['oss_file'];
            } else {
                $result = Db::name('asset')
                    ->where('file_md5', $file['file_md5'])
                    ->update(['file_number' => $file['file_number']-1]);
            }
        }

        return $objects;
    }

    // 批量删除用户上传到oss上的文件
    protected function delete_oss_files($files)
    {
        $accessKeyId = "LTAIHAtWDB5fIIht";
        $accessKeySecret = "MsTWeU3SpQBOLmPISb7YuHO45pZrg0";
        $endpoint = "http://oss-cn-beijing.aliyuncs.com";
        $bucket= "gdqy-bucket-2";

        try{
            $ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
            
            $ossClient->deleteObjects($bucket, $files);
        } catch(OssException $e) {
            return false;
        }
        return true;
    }

    // 批量删除记录到数据库中的文件和文件夹
    protected function delete_db_files($files)
    {
        try {
            $result = Db::name('asset')->where('id', 'in', $files)->delete();
            $result = Db::name('dir_file')->where('file_id', 'in', $files)->delete();
        } catch (Exception $e) {
            return false;
        }
        return true;
    }

    // 递归获取文件夹下面所有的文件, 包括文件夹, 存入objects列表中
    protected function traversal_folder($dirs, $objects=[])
    {
        foreach ($dirs as $key => $value) {
            $file = Db::name('asset')->where('id', $value)->find();
            // 将文件名添加到oss待删除列表中
            $objects[] = $value;

            // 判断是文件还是文件夹
            if ($file['type'] == '/') {
                // 如果是文件夹则获取该文件夹下所有文件, 包括文件夹
                $file_ids = Db::name('dir_file')->where('dir_id', $value)->column('file_id');
                // 将获取到的文件id传入递归函数继续获取文件
                $objects = $this->traversal_folder($file_ids, $objects);
            }
        }
        return $objects;
    }

    /**
     * 将文件放入回收站
     * @param  string files 文件或文件夹id
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function recycle_bin()
    {
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择要放入回收站的文件');
        
        $result = $this->to_recycle_bin($files);
        if (!$result) {
            $this->error('操作失败, 请重试');
        }
        $this->success('操作成功');
    }

    // 将文件状态改为 2, 在文件回收站表格中插入一条记录
    protected function to_recycle_bin($files)
    {
        $file_ids = $this->traversal_folder($files);
        try {
            Db::name('asset')->where('id', 'in', $file_ids)->update(['status' => 2]);
            $create_time = time();
            $end_time    = $create_time + (60*60*24*7);  // 自动删除时间为7天
            $data = [];
            // 只将选择的文件和文件夹插入到回收站表中, 文件夹内的文件不插入
            foreach ($files as $key => $value) {
                $file = [];
                $file['file_id']      = $value;
                $file['recycle_time'] = $create_time;
                $file['end_time']     = $end_time;
                $data[] = $file;
            }
            $result = Db::name('file_recycle')->insertAll($data);

        } catch (Exception $e) {
            return false;
        }
        return true;
    }

    /**
     * 还原回收站的文件
     * @param  string files 文件或文件夹id
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function restore_file()
    {
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择要还原的文件');
        
        $result = $this->to_restore_file($files);
        if (!$result) {
            $this->error('操作失败, 请重试');
        }
        $this->success('操作成功');
        
    }

    // 将文件状态改为 1, 将文件回收站表格中对应的文件记录删除
    protected function to_restore_file($files)
    {
        $file_ids = $this->traversal_folder($files);
        try {
            // 如果文件放入回收站前所在的文件夹被删则将文件移至根目录
            Db::name('dir_file')
                ->alias('df')
                ->join('asset s', 's.id = df.dir_id')
                ->where('df.file_id', 'in', $file_ids)
                ->where('s.status', 'in', array(0, 2))
                ->setField('df.dir_id', 0);

            // 将文件还原, 移出回收站
            Db::name('asset')->where('id', 'in', $file_ids)->update(['status' => 1]);

            // 将文件回收站表格中对应的文件记录删除
            Db::name('file_recycle')->where('file_id', 'in', $files)->delete();

        } catch (Exception $e) {
            return false;
        }
        return true;
    }

    /**
     * 查询回收站
     * @param  string $keyword 关键字查询文件名符合的文件, 可选
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表
     */
    public function read_recycle_bin()
    {
        $userId = $this->getUserId();

        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        if ($keyword) {
            $where['filename'] = ['like', "%$keyword%"];
        }

        $file = Db::name('asset')
            ->alias('a')
            ->field('a.id, a.user_id, a.file_size, a.filename, a.oss_host, a.oss_file, a.suffix, a.type, b.recycle_time, b.end_time')
            ->join('file_recycle b', 'a.id = b.file_id')
            ->where('status', 2)
            ->where('user_id', $userId)
            ->where($where)
            ->order('a.id DESC')
            ->select();

        $this->success('查询成功', $file);
    }

    /**
     * 复制文件, 不能复制到自己或子文件夹中, 保存公共的和分享的文件也用这个接口
     * @param  string  files       需要复制的文件和文件夹id
     * @param  string  new_dir_id  要复制到的目的文件夹id
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function copy_file()
    {
        $new_dir_id = $this->request->param('new_dir_id');
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择要复制的文件');

        $children_id = $this->traversal_folder($files);
        if (in_array($new_dir_id, $children_id)) {
            $this->error('操作失败, 不能复制到自己或子文件夹中');
        }

        $user_id = $this->getUserId();

        $dir_file = $this->clone_file($files, $new_dir_id, $user_id);

        $count = Db::name('dir_file')->insertAll($dir_file);

        if (!$count) {
            $this->error('操作失败, 请重试');
        }
        $this->success('成功复制'.$count.'个文件');
    }

    // 递归复制传入的文件列表, 如果有文件夹则连同文件夹下面的文件也进行复制
    // 每复制一个文件或文件夹会将新id与新文件夹id关联添加到$dir_file数组中
    // 最后返回$dir_file数组
    protected function clone_file($files, $new_dir_id, $user_id, $dir_file=[])
    {
        $result = Db::name('asset')->where('id', 'in', $files)->select();
        foreach ($result as $key => $value) {
            $file = [];
            $file['user_id'] = $user_id;
            $file['file_size'] = $value['file_size'];
            $file['private_file'] = 1;
            $file['status'] = 1;
            $file['filename'] = $value['filename'];
            $file['suffix'] = $value['suffix'];
            $file['type'] = $value['type'];

            // 如果是文件夹则继续复制文件夹下面的文件
            if ($value['type'] == '/') {
                $children = Db::name('dir_file')->where('dir_id', $value['id'])->column('file_id');
                $dir_id = Db::name('asset')->insertGetId($file);
                $dir_file[] = [
                    'dir_id'  => $new_dir_id,
                    'file_id' => $dir_id,
                ];
                $dir_file = $this->clone_file($children, $dir_id, $user_id, $dir_file);
            } else {
                $file['oss_host'] = $value['oss_host'];
                $file['oss_file'] = $value['oss_file'];
                $file['file_md5'] = $value['file_md5'];

                $file_id = Db::name('asset')->insertGetId($file);
                $dir_file[] = [
                    'dir_id'  => $new_dir_id,
                    'file_id' => $file_id,
                ];

                // 因为复制所以引用oss上同一文件的记录+1
                Db::name('asset')
                    ->where('file_md5', $value['file_md5'])
                    ->update(['file_number' => $value['file_number']+1]);
            }
        }
        return $dir_file;
    }

    /**
     * 移动文件, 不能移动到自己或子文件夹中
     * @param  string  files       需要移动的文件和文件夹
     * @param  string  new_dir_id  要移动到的目的文件夹id
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function move_file()
    {
        $new_dir_id = $this->request->param('new_dir_id');
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择要移动的文件');

        $children_id = $this->traversal_folder($files);
        if (in_array($new_dir_id, $children_id)) {
            $this->error('操作失败, 不能移动到自己或子文件夹中');
        }

        $result = Db::name('dir_file')
            ->where('file_id', 'in', $files)
            ->setField('dir_id', $new_dir_id);

        if (!$result) {
            $this->error('操作失败, 请重试');
        }
        $this->success('操作成功');
    }

    /**
     * 重命名文件和文件夹
     * @param  int    file_id      原文件名或文件夹id
     * @param  string new_filename 新文件名, filename
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function rename_file()
    {
        $file_id = $this->request->param('file_id');
        $new_filename = $this->request->param('new_filename');

        if ($new_filename == '') {
            $this->error('文件名不能为空');
        }

        try{

            $file = Db::name('asset')->where('id', $file_id)->find();
            if (empty($file)) {
                $this->error('操作失败, 请重试');
            }

            // 如果重命名的是文件夹还需要将文件夹下的所有文件改路径
            if ($file['type'] == '/') {
                // 更新文件filename的值, 文件夹没有后缀名
                $file = Db::name('asset')->where('id', $file_id)->update(['filename' => $new_filename]);
            } else {
                // 更新文件filename的值, 文件保留后缀名
                $file = Db::name('asset')->where('id', $file_id)->update(['filename' => $new_filename.'.'.$file['suffix']]);
            }

        } catch (Exception $e) {
            $this->error('操作失败, 请重试');
        }
        $this->success('操作成功');
    }

    /**
     * 面包屑导航
     * @param  int dir_id 文件夹id, 0为根目录
     * @return code: 1成功 0失败 msg: 提示信息 data:面包屑导航列表
     */
    public function get_nav()
    {
        $userId  = $this->getUserId();
        $dir_id  = $this->request->param('dir_id');
        // 用户根目录下的第一层目录id集合
        $root_id = Db::name('dir_file')
            ->alias('d')
            ->join('asset a', 'a.id = d.file_id')
            ->where('d.dir_id', 0)
            ->where('a.user_id', $userId)
            ->column('d.file_id');
        // 递归获取传入的文件夹所在的路径并返回
        $nav = $this->get_prev_nav($dir_id, $root_id);
        $this->success('面包屑导航', $nav);
    }

    /**
     * 用于获取从根目录开始的嵌套文件夹列表, 用于选择移动和复制文件的路径
     * @return code: 1成功 0失败 msg: 提示信息 data:所有文件夹的嵌套列表
     */
    public function get_folder()
    {
        $userId   = $this->getUserId();
        $folder   = [];
        $folder[] = [
            'value' => 0,
            'label' => '主文件夹',
            'children' => $this->get_all_folder(0, $userId),
        ];
        $this->success('选择文件夹', $folder);
    }

    // 递归获取传入的文件夹下面的所有文件夹
    protected function get_all_folder($dir_id, $userId, $folder=[])
    {
        $files = Db::name('dir_file')
            ->alias('b')
            ->join('asset a', 'a.id = b.file_id')
            ->where('b.dir_id', $dir_id)
            ->where('status', 1)
            ->where('a.user_id', $userId)
            ->where('type', '/')
            ->order('a.id DESC')
            ->select();
            
        if (count($files) >= 1) {
            foreach ($files as $key => $file) {
                $data = [
                    'value'       => $file['id'],
                    'label' => $file['filename'],
                ];
                // 如果返回为空列表则不需要children属性
                $children = $this->get_all_folder($file['id'], $userId);
                if (count($children) >= 1) {
                    $data['children'] = $children;
                }
                $folder[] = $data;
            }
        }
        return $folder;
    }

    /**
     * 返回oss验证信息
     * @param  string  files  文件id, 可多选
     * @return code: 1成功 0失败 msg: 提示信息 data:oss验证信息
     */
    public function download()
    {
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择文件');

        $result = Db::name('asset')
            ->where('id', 'in', $files)
            ->setInc('download_times');
        $data = $this->get_client();
        $this->success('操作成功', $data);
    }


}