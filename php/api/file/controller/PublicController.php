<?php
//
// 公共文件接口控制器
//
namespace api\file\controller;

use api\file\controller\UserBaseController;
use think\validate;
use think\Db;

class PublicController extends UserBaseController
{
    
    /**
     * 获取用户所在学校所有的公共文件, 不包含文件夹, 可添加查询和排序条件
     * @param  string $keyword 关键字查询文件名符合的文件, 可选
     * @param  string $order   排序 filename:文件名 time:时间 size:大小, 可选
     * @param  string $tagFind 标签查询符合的文件, 可选
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表(list)
     */
    public function index()
    {
        $userId = $this->getUserId();

        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $order   = $this->request->param('order');
        $tagFind = $this->request->param('tagFind');

        if ($keyword) {
            $where['filename'] = ['like', "%$keyword%"];
        }
        
        if ($order == 'time') {
            $defaultOrder = 'create_time DESC';  // 按时间降序
        } elseif ($order == 'size') {
            $defaultOrder = 'file_size DESC';  // 按文件大小升序
        } else {
            $defaultOrder = 'filename ASC';  // 默认按文件名升序
        }

        // 返回所在学校所有的公共文件, 如果是超级管理员则返回所有的公共文件
        $users = [];
        if ($userId !== 1) {
            // 获取该用户所在学校所有人的 id
            $user = Db::name('RoleUser')
                ->alias('a')
                ->join('role_user b', 'a.school_id = b.school_id')
                ->where('a.user_id', $userId)
                ->column('b.user_id');
            $users['user_id'] = ['in', $user];
        } else {
            // 因为1是系统管理员, 不属于任何学校, 所以使用not in 0表示查看所有的文件
            $users['user_id'] = ['not in', array(0)];
        }

        if ($tagFind) {
            $where['t.tag_name'] = ['like', "%$tagFind%"];
            $files = Db::name('asset')
                ->alias('a')
                ->field('a.id, a.user_id, a.file_size, a.create_time, a.download_times, a.filename, a.oss_host, a.oss_file, a.suffix, a.type')
                ->join('file_tag ft', 'ft.file_id = a.id')
                ->join('tag t', 'ft.tag_id = t.id')
                ->where('private_file', 0)
                ->where('status', 1)
                ->where('type', 'not in', array('/'))
                ->where($users)
                ->where($where)
                ->order($defaultOrder)
                ->select();
        } else {
            $files = Db::name("asset")
                ->field('id, user_id, file_size, create_time, download_times, filename, oss_host, oss_file, suffix, type')
                ->where('private_file', 0)
                ->where('status', 1)
                ->where('type', 'not in', array('/'))
                ->where($users)
                ->where($where)
                ->order($defaultOrder)
                ->select();
        }

        $this->success("学校公共文件列表", $files);
    }

    /**
     * 获取用户所有已通过审核的公共文件
     * @param  string $keyword 关键字查询文件名符合的文件, 可选
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表(list)
     */
    public function me()
    {
        $userId = $this->getUserId();
        $files  = $this->get_all_file($userId, 1);

        $this->success("用户通过审核的公共文件列表", $files);
    }
    
    /**
     * 获取用户所有待审核的公共文件
     * @param  string $keyword 关键字查询文件名符合的文件, 可选
     * @return code: 1成功 0失败 msg: 提示信息 data: 文件列表(list)
     */
    public function wait()
    {
        $userId = $this->getUserId();
        $files  = $this->get_all_file($userId, 0);

        $this->success("用户待审核的公共文件列表", $files);
    }
    
    // 按传入的参数获取公共文件
    // 1: 学校  2:已通过  3:待审核
    protected function get_all_file($userId, $status)
    {
        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        if ($keyword) {
            $where['filename'] = ['like', "%$keyword%"];
        }

        $result = Db::name('asset')
            ->field('id, user_id, file_size, create_time, download_times, filename, oss_host, oss_file, suffix, type')
            ->where('user_id', $userId)
            ->where('status', $status)
            ->where('private_file', 0)
            ->where('type', 'not in', array('/'))
            ->where($where)
            ->order('id DESC')
            ->select();
        return $result;
    }

    /**
     * 将用户的公共文件变为私有
     * @param  string  files       公共文件id, 可多选
     * @param  int     new_dir_id  私有文件存放的文件夹id
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function to_private()
    {
        $new_dir_id = $this->request->param('new_dir_id');
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择文件');

        $result = Db::name('dir_file')
            ->where('file_id', 'in', $files)
            ->setField('dir_id', $new_dir_id);
        
        $result = Db::name('asset')
            ->where('id', 'in', $files)
            ->where('user_id', $userId)
            ->setField('private_file', 1);
        if (!$result) {
            $this->error('操作失败, 请重试');
        }

        $this->success('操作成功');
    }

    /**
     * 将用户的公共文件变为公有, 加入后台文件待审核
     * @param  string  files  私有文件id, 可多选
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function to_public()
    {
        $files = $this->request->param('files');
        // 格式化获取到的文件id, 返回文件id数组
        $files = $this->format_files($files, '请选择文件');

        $userId = $this->getUserId();

        Db::name('asset')
            ->where('id', 'in', $files)
            ->where('user_id', $userId)
            ->update(['private_file' => 0, 'status' => 0]);
            
        $this->success('操作成功');
    }

}