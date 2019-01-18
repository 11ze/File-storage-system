<?php
// 
// 为Base控制器添加身份验证
// 
namespace api\file\controller;

use api\file\controller\BaseController;

class UserBaseController extends BaseController
{

    public function _initialize()
    {

        if (empty($this->user)) {
            $this->error(['code' => 10001, 'msg' => '登录已失效!']);
        }

    }


}