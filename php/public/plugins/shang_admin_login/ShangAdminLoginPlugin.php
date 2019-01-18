<?php

namespace plugins\shang_admin_login;

use cmf\lib\Plugin;
use think\Db;

class ShangAdminLoginPlugin extends Plugin
{

    public $info = [
        'name'        => 'ShangAdminLogin',
        'title'       => '大气后台登录页面',
        'description' => '新版蓝色大气后台登录页面',
        'status'      => 1,
        'author'      => '推尚网络',
        'version'     => '1.0'
    ];

    public $hasAdmin = 0;//插件是否有后台管理界面

    // 插件安装
    public function install()
    {
        return true;//安装成功返回true，失败false
    }

    // 插件卸载
    public function uninstall()
    {
        return true;//卸载成功返回true，失败false
    }

    public function adminLogin()
    {
    	$config = $this->getConfig();
		$this->assign("config", $config);
        return $this->fetch('widget');
    }

}