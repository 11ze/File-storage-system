<?php

namespace api\user\controller;

use think\Db;
use think\Validate;
use cmf\controller\RestBaseController;

class PublicController extends RestBaseController
{

    /**
     * 学校管理员注册
     * @param  string $nickname   联系人名字
     * @param  string $password   密码1
     * @param  string $password2  密码2
     * @param  string $useremail  邮箱 
     * @param  string $mobile     联系人手机号
     * @param  string $schoolname 学校名
     * @param  string $saddress   学校地址
     * @param  string $idcard     联系人身份证号
     * @param  file   $license    学校营业执照
     * @param  file   $logo       学校logo
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function addSchool()
    {
        $data            = $this->request->param();
        $data['license'] = $this->request->file('license');
        $data['logo']    = $this->request->file('logo');

        $result = $this->validate($data, 'User.addschool');
        if ($result !== true) {
            $this->error($result);
        }

        // 将学校执照和logo上传到服务器
        $license = $this->school_file_save($data['license'], '营业执照');
        $logo = $this->school_file_save($data['logo'], '学校logo');

        $user = [];

        $findUserWhere = [];

        if (Validate::is($data['useremail'], 'email')) {
            $user['user_email']          = $data['useremail'];
            $findUserWhere['user_email'] = $data['useremail'];
        } else {
            $this->error("请输入正确的邮箱格式!");
        }

        if (cmf_check_mobile($data['mobile'])) {
            $user['mobile']          = $data['mobile'];
            $findUserWhere['mobile'] = $data['mobile'];
        } else {
            $this->error('请输入正确的手机号!');
        }

        /*$errMsg = cmf_check_verification_code($data['useremail'], $data['code']);
        if (!empty($errMsg)) {
            $this->error($errMsg);
        }*/

        $school = Db::name("school")->where('school_name', $data['schoolname'])->count();
        if ($school > 0){
            $this->error("此学校已注册!");
        }

        $findUserCount = Db::name("user")->where($findUserWhere)->count();

        if ($findUserCount > 0) {
            $this->error("此邮箱已被注册!");
        }

        $findUserCount = Db::name("user")->where('mobile', $data['mobile'])->count();
        if ($findUserCount > 0) {
            $this->error("此手机号已被使用!");
        }

        $school = [];
        $school['school_name']       = $data['schoolname'];
        $school['address']          = $data['saddress'];
        $school['status']           = 2;
        $school['register_time']    = time();
        $school['business_license'] = $license;
        $school['school_logo']      = $logo;

        $school_id = Db::name('school')->insertGetId($school);

        $user['id_card']       = $data['idcard'];
        $user['create_time']   = time();
        $user['user_status']   = 2;
        $user['user_type']     = 1;
        $user['user_nickname'] = $data['nickname'];
        $user['user_login']    = $data['useremail'];  // 用户名为邮箱
        $user['user_pass']     = cmf_password($data['password']);

        $user_id = Db::name("user")->insertGetId($user);
        
        $result = Db::name("RoleUser")->insert(["role_id" => 2, "user_id" => $user_id, "school_id" => $school_id]);

        if (empty($result)) {
            $this->error("注册失败,请重试!");
        }

        $this->success("注册成功, 请等待邮件通知结果!");

    }

    /**
     * 用户注册
     * @param  string $username   学号
     * @param  string $nickname   姓名
     * @param  string $password   密码1
     * @param  string $password2  密码2
     * @param  string $useremail  邮箱 
     * @param  string $schoolname 学校名
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function register()
    {
        $data = $this->request->param();
        $result = $this->validate($data, 'User.register');
        if ($result !== true) {
            $this->error($result);
        }

        $user = [];

        $findUserWhere = [];

        if (Validate::is($data['useremail'], 'email')) {
            $user['user_email']          = $data['useremail'];
            $findUserWhere['user_email'] = $data['useremail'];
        } else if (cmf_check_mobile($data['username'])) {
            $user['mobile']          = $data['username'];
            $findUserWhere['mobile'] = $data['username'];
        } else {
            $this->error("请输入正确的邮箱格式!");
        }

        /*$errMsg = cmf_check_verification_code($data['useremail'], $data['code']);
        if (!empty($errMsg)) {
            $this->error($errMsg);
        }*/

        $school = Db::name("school")->where('school_name', $data['schoolname'])->find();
        if (empty($school)){
            $this->error("学校不存在!");
        }

        $findUserCount = Db::name('user')
            ->alias('u')
            ->field('u.*')
            ->join('role_user r', 'u.id = r.user_id')
            ->join('school s', 'r.school_id = s.id')
            ->where('u.user_login', $data['username'])
            ->where('s.school_name', $data['schoolname'])
            ->count();
        if ($findUserCount > 0) {
            $this->error("此学号已被注册!");
        }

        $findUserCount = Db::name("user")->where($findUserWhere)->count();

        if ($findUserCount > 0) {
            $this->error("此邮箱已被注册!");
        }

        $user['create_time']   = time();
        $user['user_status']   = 2;
        $user['user_type']     = 2;
        $user['user_nickname'] = $data['nickname'];
        $user['user_login']    = $data['username'];
        $user['user_pass']     = cmf_password($data['password']);

        $user_id = Db::name("user")->insertGetId($user);
        
        $result = Db::name("RoleUser")->insert(["role_id" => 4, "user_id" => $user_id, "school_id" => $school['id']]);

        if (empty($result)) {
            $this->error("注册失败,请重试!");
        }

        $this->success("注册成功, 请等待邮件通知结果!");

    }

    /**
     * 用户登录 TODO 增加最后登录信息记录,如 ip
     * @param  string $username    学号或邮箱
     * @param  string $password    密码
     * @param  string $schoolname  学校名字
     * @return code: 1成功 0失败 msg: 提示信息
     *         data: token: 登录成功token user: 用户信息
     */
    public function login()
    {
        $validate = new Validate([
            'username'   => 'require',
            'password'   => 'require|min:6|max:32',
            'schoolname' => 'require',
        ]);
        $validate->message([
            'username.require'   => '请输入学号或邮箱!',
            'password.require'   => '请输入您的密码!',
            'password.max'       => '密码不能超过32个字符',
            'password.min'       => '密码不能小于6个字符',
            'schoolname.require' => '请选择学校',
        ]);

        $data = $this->request->param();
        if (!$validate->check($data)) {
            $this->error($validate->getError());
        }

        $findUserWhere = [];

        if (Validate::is($data['username'], 'email')) {
            $findUserWhere['u.user_email'] = $data['username'];
        } else if (cmf_check_mobile($data['username'])) {
            $findUserWhere['u.mobile'] = $data['username'];
        } else {
            $findUserWhere['u.user_login'] = $data['username'];
        }
        $findUserWhere['s.school_name'] = $data['schoolname'];

        $findUser = Db::name('user')
            ->alias('u')
            ->field('u.id, user_type, sex, birthday, last_login_time, u.create_time, user_login, user_nickname, u.user_email, u.signature, last_login_ip, u.mobile, u.user_status, u.user_pass, s.school_name')
            ->join('role_user r', 'u.id = r.user_id')
            ->join('school s', 'r.school_id = s.id')
            ->where($findUserWhere)
            ->find();

        if (empty($findUser)) {
            $this->error("用户不存在!");
        } else {

            switch ($findUser['user_status']) {
                case 0:
                    $this->error('您已被拉黑!');
                case 2:
                    $this->error('账户还没有验证成功!');
            }

            if (!cmf_compare_password($data['password'], $findUser['user_pass'])) {
                $this->error("密码不正确!");
            }
        }

        // 更改用户最后的登录时间和ip
        $result = Db::name("user")->where('id', $findUser['id'])
            ->update([
                'last_login_time' => time(),
                'last_login_ip'   => get_client_ip(0, true),
            ]);
        if (empty($result)) {
            $this->error("登录失败!");
        }

        unset($findUser['user_pass']);
        unset($findUser['user_status']);

        $userTokenQuery = Db::name("user_token")
            ->where('user_id', $findUser['id']);
        $findUserToken  = $userTokenQuery->find();
        $currentTime    = time();
        $expireTime     = $currentTime + 24 * 3600 * 180;
        $token          = md5(uniqid()) . md5(uniqid());
        if (empty($findUserToken)) {
            $result = $userTokenQuery->insert([
                'token'       => $token,
                'user_id'     => $findUser['id'],
                'expire_time' => $expireTime,
                'create_time' => $currentTime,
                'device_type' => 'web',
            ]);
        } else {
            $result = $userTokenQuery
                ->where('user_id', $findUser['id'])
                ->where('device_type', 'web')
                ->update([
                    'token'       => $token,
                    'expire_time' => $expireTime,
                    'create_time' => $currentTime
                ]);
        }

        if (empty($result)) {
            $this->error("登录失败!");
        }

        $this->success("登录成功!", ['token' => $token, 'user' => $findUser]);
    }

    /**
     * 退出登录
     * @param  header['XX-Token']  token
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function logout()
    {
        $userId = $this->getUserId();
        Db::name('user_token')->where([
            'token'       => $this->token,
            'user_id'     => $userId,
            'device_type' => $this->deviceType
        ])->update(['token' => '']);

        $this->success("退出成功!");
    }

    /**
     * 用户密码重置, 先获取到数字验证码填写后提交
     * @param  string useremail 邮箱
     * @param  string password  新密码
     * @param  int    code      数字(邮箱)验证码
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function passwordReset()
    {
        $data = $this->request->param();

        $result = $this->validate($data, 'User.reset');
        if ($result !== true) {
            $this->error($result);
        }

        $userWhere = [];
        if (Validate::is($data['useremail'], 'email')) {
            $userWhere['user_email'] = $data['useremail'];
        } else {
            $this->error("请输入正确的邮箱!");
        }

        $errMsg = cmf_check_verification_code($data['useremail'], $data['code']);
        if (!empty($errMsg)) {
            $this->error($errMsg);
        }

        $userPass = cmf_password($data['password']);
        Db::name("user")->where($userWhere)->update(['user_pass' => $userPass]);

        $this->success("密码重置成功,请使用新密码登录!");

    }

    /**
     * 读取学校列表
     * @return array 包含学校名称的数组
     */
    public function schools()
    {
        $result = Db::name('school')
            ->where('status', 1)
            ->order('school_name DESC')
            ->column('school_name');
        $this->success('查询学校列表成功', $result);
    }

    // 保存上传的学校营业执照和logo
    protected function school_file_save($file, $msg)
    {
        $info = $file->validate(['ext'=>'jpg,png,jpeg'])
            ->rule('uniqid')->move(ROOT_PATH .'public' . DS . 'upload' . DS . 'school');
        if ($info) {
            $filename = 'school'. DS .$info->getSaveName();
            return $filename;
        } else {
            $this->error($msg.': '.$file->getError());
        }
    }

}
