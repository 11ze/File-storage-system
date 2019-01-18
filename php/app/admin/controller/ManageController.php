<?php

namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use app\admin\model\SchoolModel;

class ManageController extends AdminBaseController
{
    
    // 学校管理员待审核页面
    public function audit()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $where = [];
        /**搜索条件**/
        $schoolName = $this->request->param('school_name');
        $userEmail = trim($this->request->param('user_email'));

        if ($schoolName) {
            $where['school_name'] = ['like', "%$schoolName%"];
        }

        if ($userEmail) {
            $where['user_email'] = ['like', "%$userEmail%"];;
        }

        $username = session('name');    // 当前登录用户名
        $user_id = Db::name("user")->where('user_login',$username)->find();
        $user_id = $user_id['id'];

        /**查看用户角色搜索**/
        if ($user_id == 1) {
            $low_id = 2;
        } else {
            $role_id = Db::name('RoleUser')->where('user_id',$user_id)->find();
            $low_id  = $role_id['role_id'] + 1;
        }
        /**搜索所有低一级的用户**/
        $low_user = Db::name('RoleUser')->where('role_id',$low_id)->column('user_id');

        // 用于判断是哪个学校管理员页面: 2:待审核页面 1:已通过页面
        // 在点击页面的时候会传递 status 参数, 如果是刷新则不会
        // 所以需要用到以下代码记录并在没有传的时候赋值避免页面出错
        // 目的: 两个函数共用一个页面
        $status = $this->request->param('status');
        if (!empty($status)) {
            session('status', $status);
        }
        if (empty($status)) {
            $status = session('status');
        }
        $users = Db::name('user')
            ->alias('u')
            ->field('u.id, u.user_status, r.school_id, s.school_name, u.mobile, u.user_email, s.register_time, s.school_logo, u.user_nickname')
            ->join('role_user r', 'u.id = r.user_id')
            ->join('school s', 'r.school_id = s.id')
            ->where('u.id', 'in', $low_user)
            ->where($where)
            ->where('u.user_status', $status)
            ->order("u.id DESC")
            ->paginate(10);
        
        $users->appends(['school_name' => $schoolName, 'user_email' => $userEmail]);
        // 获取分页显示
        $page = $users->render();

        $this->assign("page", $page);
        $this->assign("users", $users);
        return $this->fetch('audit');
    }

    // 已通过审核的学校管理员
    public function through()
    {
        return $this->audit();
    }

    // 学校信息, 包括学校和联系人
    public function school_info()
    {
        $id = $this->request->param('id', 0, 'intval');
        $users = Db::name('user')
            ->alias('u')
            //->field('u.id, u.user_status, s.school_name, u.mobile, u.user_email, s.register_time')
            ->join('role_user r', 'u.id = r.user_id')
            ->join('school s', 'r.school_id = s.id')
            ->where('u.id', $id)
            ->select();
        $user = $users[0];
        $this->assign('user', $user);
        return $this->fetch();
    }

    // 学校通过审核
    public function school_pass()
    {
        $id = $this->request->param('id');
        $sid = $this->request->param('sid');
        $result = Db::name('user')->where('id', $id)->update(['user_status' => 1]);
        if ($result !== false) {
            Db::name('school')->where('id', $sid)->update(['status' => 1]);
        } else {
            $this->error('操作失败, 请重试!');
        }
        $this->success('操作成功!', 'manage/audit');
    }

    // 拒绝学校通过审核
    public function school_no()
    {
        $id = $this->request->param('id');
        $sid = $this->request->param('sid');
        Db::name('user')->delete($id);
        Db::name('school')->delete($sid);
        Db::name('role_user')->where('user_id', $id)->delete();
        $this->success('操作成功!', 'manage/audit');
    }

    // 列出学校管理员所在学校的普通管理员
    public function general_admin()
    {
        $content = hook_one('user_admin_index_view');

        if (!empty($content)) {
            return $content;
        }

        // 用于判断是哪个页面: 1:普通管理员 2:普通用户待审核 3:普通用户已通过页面
        // 在点击页面的时候会传递 id 参数, 如果是刷新则不会
        // 所以需要用到以下代码记录并在没有传的时候赋值避免页面出错
        // 目的: 三个函数共用一个页面
        $page_id = $this->request->param('id');
        if (!empty($page_id)) {
            session('page_id', $page_id);
        }
        if (empty($page_id)) {
            $page_id = session('page_id');
        }

        $where   = [];
        $request = input('request.');

        if (!empty($request['uid'])) {
            $where['u.id'] = intval($request['uid']);
        }
        $keywordComplex = [];
        if (!empty($request['keyword'])) {
            $keyword = $request['keyword'];

            $keywordComplex['user_login|user_nickname|user_email']    = ['like', "%$keyword%"];
        }


        $username = session('name');    // 当前登录用户名
        $user_id = Db::name("user")->where('user_login',$username)->find();
        $user_id = $user_id['id'];      // 当前用户ID

        $role_id = 2;
        $school = [];
        /**查询管理员所在学校ID**/
        if ($user_id !== 1) {
            $school_id = Db::name('RoleUser')->where('user_id',$user_id)->find();
            if ($school_id['role_id'] == 3) {
                $role_id = 3;
            }
            $school['school_id'] = $school_id['school_id'];
        } else {
            $role_id = 1;
        }
        /**判断是哪个页面, page_id 1:普通管理员 2:待审核用户 3:已通过用户**/
        if ($page_id == 1) {
            $school['role_id'] = 3;
        } elseif ($page_id == 2) {
            $school['role_id'] = 4;
            $school['user_status'] = 2;
        } else {
            $school['role_id'] = 4;
            $school['user_status'] = 1;
        }

        $list = Db::name('user')
            ->alias('u')
            ->field('u.*, s.school_name')
            ->join('role_user r', 'u.id = r.user_id')
            ->join('school s', 'r.school_id = s.id')
            ->where($where)
            ->where($keywordComplex)
            ->where($school)
            ->order("create_time DESC")
            ->paginate(10);

        // 获取分页显示
        $page = $list->render();
        $this->assign('role_id', $role_id);
        $this->assign('page_id', $page_id);
        $this->assign('list', $list);
        $this->assign('page', $page);
        // 渲染模板输出
        return $this->fetch('general');
    }

    // 待审核的普通用户页面
    public function audit_user()
    {
        return $this->general_admin();
    }

    // 已通过审核的普通用户页面
    public function through_user()
    {
        return $this->general_admin();
    }

    // 普通用户通过审核
    public function user_pass()
    {
        $id = input('param.id', 0, 'intval');
        $result = Db::name('user')->where('id', $id)->update(['user_status' => 1]);
        if ($result !== false) {
            $this->success("操作成功！", 'manage/general_admin');
        } else {
            $this->error('操作失败, 请重试！');
        }
    }

    // 拒绝普通用户通过审核
    public function user_no()
    {
        $id = input('param.id', 0, 'intval');
        if ($id) {
            Db::name("user")->delete($id);
            Db::name('role_user')->where('user_id', $id)->delete();
            $this->success("操作成功！", 'manage/general_admin');
        } else {
            $this->error('操作失败, 请重试！');
        }
    }

    // 用户详细信息页面
    public function user_info()
    {
        $id = $this->request->param('id');
        
        //$user = Db::name('user')->where('id', $id)->find();

        $user = Db::name('user')
            ->alias('u')
            ->field('u.*, r.*, s.school_name')
            ->join('role_user r', 'u.id = r.user_id')
            ->join('school s', 'r.school_id = s.id')
            ->where('u.id', $id)
            ->find();

        $this->assign('user', $user);

        return $this->fetch();
    }

    // 取消普通管理员身份
    public function user_down()
    {
        $id = $this->request->param('id');
        $result = Db::name('role_user')->where('user_id', $id)->update(['role_id' => 4]);
        if ($result !== false) {
            Db::name('user')->where('id', $id)->update(['user_type' => 2]);
            $this->success("操作成功！", 'manage/general_admin');
        } else {
            $this->error('操作失败, 请重试！');
        }
    }

    // 设置普通用户为普通管理员
    public function user_up()
    {
        $id = $this->request->param('id');
        $result = Db::name('role_user')->where('user_id', $id)->update(['role_id' => 3]);
        if ($result !== false) {
            Db::name('user')->where('id', $id)->update(['user_type' => 1]);
            $this->success("操作成功！", 'manage/general_admin');
        } else {
            $this->error('操作失败, 请重试！');
        }
    }

    // 根据传入的image参数获取学校的营业执照或logo
    public function school_image()
    {
        $id   = $this->request->param("id", 0, "intval");
        $file = $this->request->param('image');
        $school = SchoolModel::get($id);

        // 根据image的值返回对应的图片
        $image = '';
        if (!empty($school)) {
            $image = cmf_get_image_url($school[$file]);
            if (strpos($image, "/") === 0) {
                $image = $this->request->domain() . $image;
            }
        }

        // 如果营业执照或logo不存在则返回默认的图片
        if (empty($image)) {
            $cdnSettings = cmf_get_option('cdn_settings');
            if (empty($cdnSettings['cdn_static_root'])) {
                $image = $this->request->domain() . "/php/public/static/images/headicon.png";
            } else {
                $cdnStaticRoot = rtrim($cdnSettings['cdn_static_root'], '/');
                $image        = $cdnStaticRoot . "/static/images/headicon.png";
            }

        }

        return redirect($image);
    }

}