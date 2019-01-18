<?php

namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;

use OSS\OssClient;
use OSS\Core\OssException;

class FileController extends AdminBaseController
{
    
    // 待审核的本学校的公共文件页面
    public function audit()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $where = [];
        /**搜索条件**/
        $fileName = $this->request->param('file_name');
        $fileType = trim($this->request->param('file_type'));

        if ($fileName) {
            $where['filename'] = ['like', "%$fileName%"];
        }

        if ($fileType) {
            $where['type'] = ['like', "%$fileType%"];;
        }

        $username = session('name');    // 当前登录用户名
        $user_id = Db::name("user")->where('user_login',$username)->find();
        $userId = $user_id['id'];

        // 返回所在学校所有的用户ID
        $users = [];
        if ($userId !== 1) {
            // 获取该用户所在学校所有人的 id
            $user = Db::name('RoleUser')
                ->alias('a')
                ->join('role_user b', 'a.school_id = b.school_id')
                ->where('a.user_id',$userId)
                ->column('b.user_id');
            $users['user_id'] = ['in', $user];
        } else {
            // 因为不存在 id 为 0 的用户, 所以 not in 0表示所有的用户
            $users['user_id'] = ['not in', array(0)];
        }

        // 用于判断是哪个公共文件页面: 0:待审核文件页面 1:已通过文件页面
        // 在点击页面的时候会传递 status 参数, 如果是刷新则不会
        // 所以需要用到以下代码记录并在没有传的时候赋值避免页面出错
        // 目的: 两个函数共用一个页面
        $status = $this->request->param('status');
        if ($status === '0' || $status === '1') {
            session('status', $status);
        } else {
            $status = session('status');
        }

        $files = Db::name("asset")
            ->alias('a')
            ->field('a.*, u.user_login')
            ->join('user u', 'a.user_id = u.id')
            ->where('a.private_file', 0)
            ->where('a.status', $status)
            ->where('a.type', 'not in', array('/'))
            ->where($users)
            ->where($where)  // 关键字搜索文件
            ->order("a.create_time DESC")
            ->paginate(10);

        // 获取分页显示
        $page = $files->render();
        $this->assign("page", $page);
        $this->assign("files", $files);
        return $this->fetch('index');
    }

    // 已通过审核的本学校的公共文件页面
    public function through()
    {
        return $this->audit();
    }

    // 公共文件通过审核, 修改文件状态
    public function file_pass()
    {
        $id = $this->request->param('id');

        if ($id) {
            Db::name("asset")
                ->where('id', $id)
                ->update(['status' => 1]);

            $this->success("操作成功！", 'file/audit');
        } else {
            $this->error('操作失败, 请重试！');
        }
    }

    // 拒绝公共文件通过审核并删除文件和记录
    public function file_no()
    {
        $id = $this->request->param('id');

        if ($id) {
            $file = Db::name("asset")->where('id', $id)->find();
            // 获取文件在oss的路径
            $objects =[];
            if ($file['file_number'] <= 1) {
                $objects[] = $file['oss_file'];
                // 删除oss上的文件
                $result = $this->delete_oss_files($objects);
                if (!$result) {
                $this->error('oss删除失败, 请重试!');
                }
            } else {
                $file_number = $file['file_number'] - 1;
                Db::name('asset')->where('id', $id)->update(['file_number' => $file_number]);
            }
            // 删除数据库中的记录
            $result = Db::name('asset')->where('id', $id)->delete();
            $result = Db::name('dir_file')->where('file_id', $id)->delete();
            if (!$result) {
                $this->error('db删除失败, 请重试!');
            }

            $this->success("操作成功！", 'file/audit');
        } else {
            $this->error('操作失败, 请重试！');
        }
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

    // 文件详细信息
    public function file_info()
    {
        $id = $this->request->param('id');
        
        $file = Db::name("asset")->where('id', $id)->find();

        $this->assign('file', $file);
        return $this->fetch();
    }

}