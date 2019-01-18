<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | 官网 http://www.thinkcmf.com
// +----------------------------------------------------------------------
// | 玩转ThinkCMF，欢迎关注ThinkCMF学院！
// +----------------------------------------------------------------------
// | Author: J&C
// +----------------------------------------------------------------------
// | 感谢：ThinkCMF平台 && 老猫
// +----------------------------------------------------------------------
namespace plugins\diy_admin_login;

use cmf\lib\Plugin;
use think\Db;

class DiyAdminLoginPlugin extends Plugin
{

    public $info = [
        'name'        => 'DiyAdminLogin',
        'title'       => 'DIY后台登录页面',
        'description' => 'DIY后台登录页面，可修改标题文字和颜色、版权文字，可设置网页背景为图片或纯色',
        'status'      => 1,
        'author'      => 'J&C',
        'version'     => '1.1'
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
        $this->assign($config);
        return $this->fetch('widget');
    }

}