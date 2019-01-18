<?php

namespace api\user\validate;

use think\Validate;
use api\user\model\UserModel;
use api\user\model\SchoolModel;

class UserValidate extends Validate
{
    protected $rule = [
        'username'       => 'require|is_nu',
        'password'       => 'require|min:6|max:32|no_nu',
        'password2'      => 'require|confirm:password',
        'old_password'   => 'require',
        //'useremail'      => 'require|email|unique:user,user_email',
        'useremail'      => 'require',
        'schoolname'     => 'require',
        'code'           => 'require',
        'saddress'       => 'require',
        'nickname'       => 'require',
        'mobile'         => 'require',
        'idcard'         => 'require|idcard',
        'license'        => 'require',
        'logo'           => 'require',
    ];

    protected $message = [
        'username.require'     => '请输入学号!',
        'password.require'     => '请输入您的密码!',
        'password.max'         => '密码不能超过32个字符',
        'password.min'         => '密码不能小于6个字符',
        'password2.require'    => '请输入确认密码!',
        'password2.confirm'    => '两次输入的密码不一致!',
        'useremail.require'    => '请输入邮箱!',
        'old_password.require' => '请输入您的旧密码!',
        //'useremail.email'      => '请输入正确的邮箱格式!',
        //'useremail.unique'     => '此邮箱已被注册!',
        'schoolname.require'   => '请选择学校!',
        'code.require'         => '请输入数字验证码!',
        'saddress.require'     => '请输入学校地址!',
        'nickname.require'     => '请输入学校联系人!',
        'mobile.require'       => '请输入联系人电话!',
        'idcard.require'       => '请输入身份证号码!',
        'license.require'      => '请添加学校营业执照!',
        'logo.require'         => '请添加学校logo!',
    ];

    protected $scene = [
        'add'            => ['user_login', 'user_pass', 'user_email'],
        'edit'           => ['user_login', 'user_email'],
        'login'          => ['user_login', 'user_pass', 'schoolname'],  // 验证登录表单数据
        'register'       => ['username', 'nickname', 'password', 'password2', 'schoolname',
                            'useremail'],  // 验证注册表单数据
        'reset'          => ['useremail', 'password', 'code'], // 用户重置密码
        'addschool'      => ['schoolname', 'saddress', 'nickname', 'mobile', 'useremail'
                            , 'idcard', 'password', 'password2', 'license', 'logo'], // 学校管理员
        'changepassword' => ['old_password', 'password', 'password2'], // 修改密码
    ];

    /**
     * 检查密码是否为纯数字
     * @param  string  $password 密码
     * @return boolean           返回true或错误提示信息
     */
    protected function no_nu($password)
    {
        if (is_numeric($password)) {
            return '密码不能为纯数字!';
        }
        return true;
    }

    /**
     * 检查用户名是否为纯数字学号
     * @param  string  $username 学号
     * @return boolean           返回true或错误提示信息
     */
    protected function is_nu($username)
    {
        if (is_numeric($username)) {
            return true;
        }
        return '请填写正确的学号!';
    }

    //调用身份证验证函数
    protected function idcard($idcard)
    {
        $idc = $this->is_idcard($idcard); 
        if ($idc) {
            return true;
        } else {
            return '请填写有效的身份证号码!';
        }
    }

    // 身份证号码验证
    protected function is_idcard($id) 
    { 
        $id = strtoupper($id); 
        $regx = "/(^\d{15}$)|(^\d{17}([0-9]|X)$)/"; 
        $arr_split = array(); 
        if(!preg_match($regx, $id)) 
        { 
            return FALSE; 
        } 
        if(15==strlen($id)) //检查15位 
        { 
            $regx = "/^(\d{6})+(\d{2})+(\d{2})+(\d{2})+(\d{3})$/"; 
      
            @preg_match($regx, $id, $arr_split); 
            //检查生日日期是否正确 
            $dtm_birth = "19".$arr_split[2] . '/' . $arr_split[3]. '/' .$arr_split[4]; 
            if(!strtotime($dtm_birth)) 
            { 
                return FALSE; 
            } else { 
                return TRUE; 
            } 
        } 
        else      //检查18位 
        { 
            $regx = "/^(\d{6})+(\d{4})+(\d{2})+(\d{2})+(\d{3})([0-9]|X)$/"; 
            @preg_match($regx, $id, $arr_split); 
            $dtm_birth = $arr_split[2] . '/' . $arr_split[3]. '/' .$arr_split[4]; 
            if(!strtotime($dtm_birth)) //检查生日日期是否正确 
            { 
                return FALSE; 
            } 
            else
            { 
                //检验18位身份证的校验码是否正确。 
                //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
                $arr_int = array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
                $arr_ch = array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
                $sign = 0; 
                for ( $i = 0; $i < 17; $i++ ) 
                { 
                    $b = (int) $id{$i}; 
                    $w = $arr_int[$i]; 
                    $sign += $b * $w; 
                } 
                $n = $sign % 11; 
                $val_num = $arr_ch[$n]; 
                if ($val_num != substr($id,17, 1)) 
                { 
                    return FALSE; 
                } //phpfensi.com 
                else
                { 
                    return TRUE; 
                } 
            } 
        } 
      
    }

}