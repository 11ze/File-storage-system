<?php
//
// 分享文件接口控制器
//
namespace api\file\controller;

use api\file\controller\BaseController;
use think\validate;
use think\Db;

class ShareController extends BaseController
{

    /**
     * 生成分享链接
     * @param  string files      要分享的文件id, 可多个
     * @param  string dead_time  有效时间 1:一天, 7:七天, 0:永久
     * @param  string iscode     是否加密 1:加密 2:不加密
     * @return code: 1:已存在 0:不存在 msg: 提示信息 data:link:分享链接 code:提取码 qr_code:图片二维码
     */
    public function share_file()
    {
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files      = $this->format_files($files, '请选择要分享的文件');
        $dead_time  = $this->request->param('dead_time');
        $iscode     = $this->request->param('iscode');
        $userId     = $this->getUserId();

        $link_param = md5(uniqid(microtime(true),true));    // 分享链接的加密参数
        // 拼接生成分享链接
        $host       = $this->request->domain() . '/#/share?id=';
        $link       = $host . $link_param;

        $file = [
            'user_id'    => $userId,
            'share_time' => time(),
            'link'       => $link,        // 分享的链接
            'uniqid'     => $link_param,  // 链接里面的加密参数
        ];

        // 获取分享中其中一个文件的名字
        $name   = Db::name('asset')->where('id', $files[0])->value('filename');
        if (count($files) == 1) {
            $file['name'] = $name;
        } else {
            $file['name'] = $name . '等';
        }

        // 设置分享链接的有效时间, 默认为0永久有效
        if ($dead_time == '1') {
            $file['dead_time'] = time() + 1*60*60*24;
        } else if ($dead_time == '7') {
            $file['dead_time'] = time() + 7*60*60*24;
        }

        // 如果需要加密则生成一个4位的随机字符串
        if ($iscode == '1') {
            $file['code'] = $this->get_random_str(4);
        } else {
            $file['code'] = '';
        }

        $qrcode = $this->generate_qr_code($link, $link_param);
        $file['qr_path'] = $qrcode['qr_path'];

        $share_id = Db::name('share')->insertGetId($file);
        if (!$share_id) {
            $this->error('操作失败, 请重试');
        }

        // 将分享链接id跟分享的文件关联并记录
        $data = [];
        foreach ($files as $key => $value) {
            $data[] = ['share_id' => $share_id, 'file_id' => $value];
        }
        Db::name('share_file')->insertAll($data);

        $data = [
            'link'    => $link,
            'code'    => $file['code'],
            'qr_code' => $qrcode['qr_code'],
        ];

        $share_id = Db::name('share_file')->insertAll($data);

        $this->success('成功生成分享链接', $data);
    }

    /**
     * 获取分享链接对应的信息和文件列表
     * @param  int  id   分享链接中的加密id
     * @return code: 1:已存在 0:不存在 msg: 提示信息 data:分享链接的信息和文件, 分享人的信息
     */
    public function get_share_file()
    {
        $link_param = $this->request->param('id');

        $result = Db::name('share')
            ->field('id, user_id, share_time, dead_time, code, name, view_count, download_count')
            ->where('uniqid', $link_param)
            ->find();

        if (!$result) {
            $this->error('链接不存在');
        }

        if (time() > $result['dead_time'] && $result['dead_time'] != 0) {
            $this->error('链接已失效');
        }

        Db::name('share')->where('id', $result['id'])->update(['view_count' => $result['view_count']+1]);

        $result['files'] = Db::name('share_file')
                            ->alias('s')
                            ->field('a.id, a.user_id, a.file_size, a.create_time, a.download_times, a.filename, a.oss_host, a.oss_file, a.suffix, a.type')
                            ->join('asset a', 's.file_id = a.id')
                            ->where('share_id', $result['id'])
                            ->order('a.id DESC')
                            ->select();
        $result['user_info'] = Db::name('user')->field('id, user_nickname')->where('id', $result['user_id'])->find();
        $result['user_info']['avatar'] = $this->request->domain().'/php/public/user/public/avatar/'.$result['user_id'];

        $this->success('获取分享链接文件', $result);
    }

    /**
     * 获取我的所有分享文件
     * @return code: 1:已存在 0:不存在 msg: 提示信息 data:我的所有分享文件
     */
    public function index()
    {
        $userId = $this->getUserId();
        $share  = Db::name('share')
            ->field('id, share_time, dead_time, code, link, name, view_count, download_count')
            ->where('user_id', $userId)
            ->order('id DESC')
            ->select();
        $this->success('我的分享', $share);
    }

    /**
     * 取消分享
     * @param  string  share_id   分享链接的id, 可多选
     * @return code: 1:已存在 0:不存在 msg: 提示信息
     */
    public function cancel_share()
    {
        $userId   = $this->getUserId();

        $share_id = $this->request->param('share_id');
        // 格式化获取到的文件id, 返回文件id数组
        $share_id = $this->format_files($share_id, '请选择要取消分享的文件');

        $qr_codes = Db::name('share')->where('id', 'in', $share_id)->where('user_id', $userId)->column('qr_path');
        // 删除分享链接对应的二维码图片
        $this->del_file($qr_codes);

        Db::name('share_file')->where('share_id', 'in', $share_id)->delete();
        Db::name('share')->where('id', 'in', $share_id)->where('user_id', $userId)->delete();

        $this->success('取消分享成功');

    }

    // 传入文件列表, 批量删除public下的文件
    protected function del_file($files)
    {
        foreach ($files as $key => $value) {
            $file = ROOT_PATH . 'public' . DS . $value;
            unlink($file);
        }
    }

    /**
     * 分享链接的面包屑导航
     * @param  int share_id 分享链接的id
     * @param  int dir_id   分享链接里的文件夹id
     * @return code: 1成功 0失败 msg: 提示信息 data:分享链接的面包屑导航列表
     */
    public function get_share_nav()
    {
        $share_id = $this->request->param('share_id');
        $dir_id   = $this->request->param('dir_id');

        // 分享链接下面最外层的文件夹id
        $root_id = Db::name('share_file')->where('share_id', $share_id)->column('file_id');
        if (count($root_id) == 0) {
            $this->error('链接不存在');
        }
        // 递归获取传入的文件夹所在的路径并返回
        $nav = $this->get_prev_nav($dir_id, $root_id);
        $this->success('分享链接的面包屑导航', $nav);
    }

    /**
     * 查看分享链接里面的文件夹, 列出文件夹下的文件
     * @param  int    $dir_id  文件夹id
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表(list)
     */
    public function read()
    {
        $dir_id = $this->request->param('dir_id');
        $files = $this->read_dir($dir_id);
        $this->success('操作成功', $files);
    }

    /**
     * 返回oss验证信息
     * @param  string  files  文件id, 可多选
     * @param  int     sid    分享的链接的id
     * @return code: 1成功 0失败 msg: 提示信息 data:oss验证信息
     */
    public function download()
    {
        $files = $this->request->param('files');
        $sid   = $this->request->param('sid');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择文件');

        $result = Db::name('share')
            ->where('id', $sid)
            ->setInc('download_count');
        $result = Db::name('asset')
            ->where('id', 'in', $files)
            ->setInc('download_times');
        $data = $this->get_client();
        $this->success('操作成功', $data);
    }

}