<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\user\controller;

use cmf\controller\RestUserBaseController;
use think\Db;
use think\Validate;

class ProfileController extends RestUserBaseController
{
    /**
     * 用户密码修改
     * @param  string $old_password  用户旧密码
     * @param  string $password      新密码
     * @param  string $password2     确认新密码
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function change_password()
    {
        $data = $this->request->param();

        $result = $this->validate($data, 'User.changepassword');
        if ($result !== true) {
            $this->error($result);
        }

        $userId       = $this->getUserId();
        $userPassword = Db::name("user")->where('id', $userId)->value('user_pass');

        if (!cmf_compare_password($data['old_password'], $userPassword)) {
            $this->error('旧密码不正确!');
        }

        Db::name("user")->where('id', $userId)->update(['user_pass' => cmf_password($data['password'])]);

        $this->success("密码修改成功!");

    }

    /**
     * 用户基本信息修改
     * @param  string  $user_nickname   用户昵称
     * @param  int     $sex             性别, 0:保密 1:男 2:女
     * @param  int     $birthday        用户生日, 时间戳
     * @param  string  $signature       个性签名
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function change_info()
    {
        $userId   = $this->getUserId();
        $fieldStr = 'user_nickname, signature, sex, birthday';
        $data     = $this->request->param();
        if (empty($data)) {
            $this->error('修改失败，提交表单为空！');
        }
        $data['birthday'] = strtotime($data['birthday']);

        $upData = Db::name("user")->where('id', $userId)->field($fieldStr)->update($data);
        if ($upData !== false) {
            $this->success('修改成功！', $data);
        } else {
            $this->error('修改失败！');
        }
    }

    /**
     * 用户头像修改
     * @param  file  $avatar  用户头像
     * @return code: 1成功 0失败 msg: 提示信息
     */
    public function change_avatar()
    {
        $file   = $this->request->file('file');
        $result = $file->validate([
            'ext'  => 'jpg,jpeg,png',
            'size' => 1024 * 1024
        ])->rule('uniqid')->move(ROOT_PATH .'public' . DS . 'upload' . DS . 'avatar' . DS);

        if ($result) {
            $userId = $this->getUserId();
            $avatarSaveName = str_replace('//', '/', str_replace('\\', '/', $result->getSaveName()));
            $avatar         = 'avatar/' . $avatarSaveName;
            Db::name('user')->where('id', $userId)->update(['avatar' => $avatar]);

            $this->success('修改成功');
        } else {
            $this->error($file->getError());
        }
    }

}
