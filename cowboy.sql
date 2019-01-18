-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2019-01-17 18:18:54
-- 服务器版本： 5.7.12
-- PHP Version: 7.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cowboy`
--

-- --------------------------------------------------------

--
-- 表的结构 `cmf_admin_menu`
--

CREATE TABLE `cmf_admin_menu` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父菜单id',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '菜单类型;1:有界面可访问菜单,2:无界面可访问菜单,0:只作为菜单',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '状态;1:显示,0:不显示',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `app` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '应用名',
  `controller` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '控制器名',
  `action` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '操作名称',
  `param` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '额外参数',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单表';

--
-- 转存表中的数据 `cmf_admin_menu`
--

INSERT INTO `cmf_admin_menu` (`id`, `parent_id`, `type`, `status`, `list_order`, `app`, `controller`, `action`, `param`, `name`, `icon`, `remark`) VALUES
(1, 0, 0, 1, 20, 'admin', 'Plugin', 'default', '', '插件中心', 'cloud', '插件中心'),
(2, 1, 1, 1, 10000, 'admin', 'Hook', 'index', '', '钩子管理', '', '钩子管理'),
(3, 2, 1, 0, 10000, 'admin', 'Hook', 'plugins', '', '钩子插件管理', '', '钩子插件管理'),
(4, 2, 2, 0, 10000, 'admin', 'Hook', 'pluginListOrder', '', '钩子插件排序', '', '钩子插件排序'),
(5, 2, 1, 0, 10000, 'admin', 'Hook', 'sync', '', '同步钩子', '', '同步钩子'),
(6, 0, 0, 1, 0, 'admin', 'Setting', 'default', '', '设置', 'cogs', '系统设置入口'),
(7, 6, 1, 1, 50, 'admin', 'Link', 'index', '', '友情链接', '', '友情链接管理'),
(8, 7, 1, 0, 10000, 'admin', 'Link', 'add', '', '添加友情链接', '', '添加友情链接'),
(9, 7, 2, 0, 10000, 'admin', 'Link', 'addPost', '', '添加友情链接提交保存', '', '添加友情链接提交保存'),
(10, 7, 1, 0, 10000, 'admin', 'Link', 'edit', '', '编辑友情链接', '', '编辑友情链接'),
(11, 7, 2, 0, 10000, 'admin', 'Link', 'editPost', '', '编辑友情链接提交保存', '', '编辑友情链接提交保存'),
(12, 7, 2, 0, 10000, 'admin', 'Link', 'delete', '', '删除友情链接', '', '删除友情链接'),
(13, 7, 2, 0, 10000, 'admin', 'Link', 'listOrder', '', '友情链接排序', '', '友情链接排序'),
(14, 7, 2, 0, 10000, 'admin', 'Link', 'toggle', '', '友情链接显示隐藏', '', '友情链接显示隐藏'),
(15, 6, 1, 1, 10, 'admin', 'Mailer', 'index', '', '邮箱配置', '', '邮箱配置'),
(16, 15, 2, 0, 10000, 'admin', 'Mailer', 'indexPost', '', '邮箱配置提交保存', '', '邮箱配置提交保存'),
(17, 15, 1, 0, 10000, 'admin', 'Mailer', 'template', '', '邮件模板', '', '邮件模板'),
(18, 15, 2, 0, 10000, 'admin', 'Mailer', 'templatePost', '', '邮件模板提交', '', '邮件模板提交'),
(19, 15, 1, 0, 10000, 'admin', 'Mailer', 'test', '', '邮件发送测试', '', '邮件发送测试'),
(20, 6, 1, 0, 10000, 'admin', 'Menu', 'index', '', '后台菜单', '', '后台菜单管理'),
(21, 20, 1, 0, 10000, 'admin', 'Menu', 'lists', '', '所有菜单', '', '后台所有菜单列表'),
(22, 20, 1, 0, 10000, 'admin', 'Menu', 'add', '', '后台菜单添加', '', '后台菜单添加'),
(23, 20, 2, 0, 10000, 'admin', 'Menu', 'addPost', '', '后台菜单添加提交保存', '', '后台菜单添加提交保存'),
(24, 20, 1, 0, 10000, 'admin', 'Menu', 'edit', '', '后台菜单编辑', '', '后台菜单编辑'),
(25, 20, 2, 0, 10000, 'admin', 'Menu', 'editPost', '', '后台菜单编辑提交保存', '', '后台菜单编辑提交保存'),
(26, 20, 2, 0, 10000, 'admin', 'Menu', 'delete', '', '后台菜单删除', '', '后台菜单删除'),
(27, 20, 2, 0, 10000, 'admin', 'Menu', 'listOrder', '', '后台菜单排序', '', '后台菜单排序'),
(28, 20, 1, 0, 10000, 'admin', 'Menu', 'getActions', '', '导入新后台菜单', '', '导入新后台菜单'),
(29, 6, 1, 1, 30, 'admin', 'Nav', 'index', '', '导航管理', '', '导航管理'),
(30, 29, 1, 0, 10000, 'admin', 'Nav', 'add', '', '添加导航', '', '添加导航'),
(31, 29, 2, 0, 10000, 'admin', 'Nav', 'addPost', '', '添加导航提交保存', '', '添加导航提交保存'),
(32, 29, 1, 0, 10000, 'admin', 'Nav', 'edit', '', '编辑导航', '', '编辑导航'),
(33, 29, 2, 0, 10000, 'admin', 'Nav', 'editPost', '', '编辑导航提交保存', '', '编辑导航提交保存'),
(34, 29, 2, 0, 10000, 'admin', 'Nav', 'delete', '', '删除导航', '', '删除导航'),
(35, 29, 1, 0, 10000, 'admin', 'NavMenu', 'index', '', '导航菜单', '', '导航菜单'),
(36, 35, 1, 0, 10000, 'admin', 'NavMenu', 'add', '', '添加导航菜单', '', '添加导航菜单'),
(37, 35, 2, 0, 10000, 'admin', 'NavMenu', 'addPost', '', '添加导航菜单提交保存', '', '添加导航菜单提交保存'),
(38, 35, 1, 0, 10000, 'admin', 'NavMenu', 'edit', '', '编辑导航菜单', '', '编辑导航菜单'),
(39, 35, 2, 0, 10000, 'admin', 'NavMenu', 'editPost', '', '编辑导航菜单提交保存', '', '编辑导航菜单提交保存'),
(40, 35, 2, 0, 10000, 'admin', 'NavMenu', 'delete', '', '删除导航菜单', '', '删除导航菜单'),
(41, 35, 2, 0, 10000, 'admin', 'NavMenu', 'listOrder', '', '导航菜单排序', '', '导航菜单排序'),
(42, 1, 1, 1, 10000, 'admin', 'Plugin', 'index', '', '插件列表', '', '插件列表'),
(43, 42, 2, 0, 10000, 'admin', 'Plugin', 'toggle', '', '插件启用禁用', '', '插件启用禁用'),
(44, 42, 1, 0, 10000, 'admin', 'Plugin', 'setting', '', '插件设置', '', '插件设置'),
(45, 42, 2, 0, 10000, 'admin', 'Plugin', 'settingPost', '', '插件设置提交', '', '插件设置提交'),
(46, 42, 2, 0, 10000, 'admin', 'Plugin', 'install', '', '插件安装', '', '插件安装'),
(47, 42, 2, 0, 10000, 'admin', 'Plugin', 'update', '', '插件更新', '', '插件更新'),
(48, 42, 2, 0, 10000, 'admin', 'Plugin', 'uninstall', '', '卸载插件', '', '卸载插件'),
(49, 110, 0, 1, 10000, 'admin', 'User', 'default', '', '管理组', '', '管理组'),
(50, 49, 1, 1, 10000, 'admin', 'Rbac', 'index', '', '角色管理', '', '角色管理'),
(51, 50, 1, 0, 10000, 'admin', 'Rbac', 'roleAdd', '', '添加角色', '', '添加角色'),
(52, 50, 2, 0, 10000, 'admin', 'Rbac', 'roleAddPost', '', '添加角色提交', '', '添加角色提交'),
(53, 50, 1, 0, 10000, 'admin', 'Rbac', 'roleEdit', '', '编辑角色', '', '编辑角色'),
(54, 50, 2, 0, 10000, 'admin', 'Rbac', 'roleEditPost', '', '编辑角色提交', '', '编辑角色提交'),
(55, 50, 2, 0, 10000, 'admin', 'Rbac', 'roleDelete', '', '删除角色', '', '删除角色'),
(56, 50, 1, 0, 10000, 'admin', 'Rbac', 'authorize', '', '设置角色权限', '', '设置角色权限'),
(57, 50, 2, 0, 10000, 'admin', 'Rbac', 'authorizePost', '', '角色授权提交', '', '角色授权提交'),
(58, 0, 1, 0, 10000, 'admin', 'RecycleBin', 'index', '', '回收站', '', '回收站'),
(59, 58, 2, 0, 10000, 'admin', 'RecycleBin', 'restore', '', '回收站还原', '', '回收站还原'),
(60, 58, 2, 0, 10000, 'admin', 'RecycleBin', 'delete', '', '回收站彻底删除', '', '回收站彻底删除'),
(61, 6, 1, 1, 10000, 'admin', 'Route', 'index', '', 'URL美化', '', 'URL规则管理'),
(62, 61, 1, 0, 10000, 'admin', 'Route', 'add', '', '添加路由规则', '', '添加路由规则'),
(63, 61, 2, 0, 10000, 'admin', 'Route', 'addPost', '', '添加路由规则提交', '', '添加路由规则提交'),
(64, 61, 1, 0, 10000, 'admin', 'Route', 'edit', '', '路由规则编辑', '', '路由规则编辑'),
(65, 61, 2, 0, 10000, 'admin', 'Route', 'editPost', '', '路由规则编辑提交', '', '路由规则编辑提交'),
(66, 61, 2, 0, 10000, 'admin', 'Route', 'delete', '', '路由规则删除', '', '路由规则删除'),
(67, 61, 2, 0, 10000, 'admin', 'Route', 'ban', '', '路由规则禁用', '', '路由规则禁用'),
(68, 61, 2, 0, 10000, 'admin', 'Route', 'open', '', '路由规则启用', '', '路由规则启用'),
(69, 61, 2, 0, 10000, 'admin', 'Route', 'listOrder', '', '路由规则排序', '', '路由规则排序'),
(70, 61, 1, 0, 10000, 'admin', 'Route', 'select', '', '选择URL', '', '选择URL'),
(71, 6, 1, 1, 0, 'admin', 'Setting', 'site', '', '网站信息', '', '网站信息'),
(72, 71, 2, 0, 10000, 'admin', 'Setting', 'sitePost', '', '网站信息设置提交', '', '网站信息设置提交'),
(73, 6, 1, 0, 10000, 'admin', 'Setting', 'password', '', '密码修改', '', '密码修改'),
(74, 73, 2, 0, 10000, 'admin', 'Setting', 'passwordPost', '', '密码修改提交', '', '密码修改提交'),
(75, 6, 1, 1, 10000, 'admin', 'Setting', 'upload', '', '上传设置', '', '上传设置'),
(76, 75, 2, 0, 10000, 'admin', 'Setting', 'uploadPost', '', '上传设置提交', '', '上传设置提交'),
(77, 6, 1, 0, 10000, 'admin', 'Setting', 'clearCache', '', '清除缓存', '', '清除缓存'),
(78, 6, 1, 1, 40, 'admin', 'Slide', 'index', '', '幻灯片管理', '', '幻灯片管理'),
(79, 78, 1, 0, 10000, 'admin', 'Slide', 'add', '', '添加幻灯片', '', '添加幻灯片'),
(80, 78, 2, 0, 10000, 'admin', 'Slide', 'addPost', '', '添加幻灯片提交', '', '添加幻灯片提交'),
(81, 78, 1, 0, 10000, 'admin', 'Slide', 'edit', '', '编辑幻灯片', '', '编辑幻灯片'),
(82, 78, 2, 0, 10000, 'admin', 'Slide', 'editPost', '', '编辑幻灯片提交', '', '编辑幻灯片提交'),
(83, 78, 2, 0, 10000, 'admin', 'Slide', 'delete', '', '删除幻灯片', '', '删除幻灯片'),
(84, 78, 1, 0, 10000, 'admin', 'SlideItem', 'index', '', '幻灯片页面列表', '', '幻灯片页面列表'),
(85, 84, 1, 0, 10000, 'admin', 'SlideItem', 'add', '', '幻灯片页面添加', '', '幻灯片页面添加'),
(86, 84, 2, 0, 10000, 'admin', 'SlideItem', 'addPost', '', '幻灯片页面添加提交', '', '幻灯片页面添加提交'),
(87, 84, 1, 0, 10000, 'admin', 'SlideItem', 'edit', '', '幻灯片页面编辑', '', '幻灯片页面编辑'),
(88, 84, 2, 0, 10000, 'admin', 'SlideItem', 'editPost', '', '幻灯片页面编辑提交', '', '幻灯片页面编辑提交'),
(89, 84, 2, 0, 10000, 'admin', 'SlideItem', 'delete', '', '幻灯片页面删除', '', '幻灯片页面删除'),
(90, 84, 2, 0, 10000, 'admin', 'SlideItem', 'ban', '', '幻灯片页面隐藏', '', '幻灯片页面隐藏'),
(91, 84, 2, 0, 10000, 'admin', 'SlideItem', 'cancelBan', '', '幻灯片页面显示', '', '幻灯片页面显示'),
(92, 84, 2, 0, 10000, 'admin', 'SlideItem', 'listOrder', '', '幻灯片页面排序', '', '幻灯片页面排序'),
(93, 6, 1, 1, 10000, 'admin', 'Storage', 'index', '', '文件存储', '', '文件存储'),
(94, 93, 2, 0, 10000, 'admin', 'Storage', 'settingPost', '', '文件存储设置提交', '', '文件存储设置提交'),
(95, 6, 1, 1, 20, 'admin', 'Theme', 'index', '', '模板管理', '', '模板管理'),
(96, 95, 1, 0, 10000, 'admin', 'Theme', 'install', '', '安装模板', '', '安装模板'),
(97, 95, 2, 0, 10000, 'admin', 'Theme', 'uninstall', '', '卸载模板', '', '卸载模板'),
(98, 95, 2, 0, 10000, 'admin', 'Theme', 'installTheme', '', '模板安装', '', '模板安装'),
(99, 95, 2, 0, 10000, 'admin', 'Theme', 'update', '', '模板更新', '', '模板更新'),
(100, 95, 2, 0, 10000, 'admin', 'Theme', 'active', '', '启用模板', '', '启用模板'),
(101, 95, 1, 0, 10000, 'admin', 'Theme', 'files', '', '模板文件列表', '', '启用模板'),
(102, 95, 1, 0, 10000, 'admin', 'Theme', 'fileSetting', '', '模板文件设置', '', '模板文件设置'),
(103, 95, 1, 0, 10000, 'admin', 'Theme', 'fileArrayData', '', '模板文件数组数据列表', '', '模板文件数组数据列表'),
(104, 95, 2, 0, 10000, 'admin', 'Theme', 'fileArrayDataEdit', '', '模板文件数组数据添加编辑', '', '模板文件数组数据添加编辑'),
(105, 95, 2, 0, 10000, 'admin', 'Theme', 'fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', '', '模板文件数组数据添加编辑提交保存'),
(106, 95, 2, 0, 10000, 'admin', 'Theme', 'fileArrayDataDelete', '', '模板文件数组数据删除', '', '模板文件数组数据删除'),
(107, 95, 2, 0, 10000, 'admin', 'Theme', 'settingPost', '', '模板文件编辑提交保存', '', '模板文件编辑提交保存'),
(108, 95, 1, 0, 10000, 'admin', 'Theme', 'dataSource', '', '模板文件设置数据源', '', '模板文件设置数据源'),
(109, 95, 1, 0, 10000, 'admin', 'Theme', 'design', '', '模板设计', '', '模板设计'),
(110, 0, 0, 1, 10, 'user', 'AdminIndex', 'default', '', '用户管理', 'group', '用户管理'),
(111, 49, 1, 1, 10000, 'admin', 'User', 'index', '', '管理员', '', '管理员管理'),
(112, 111, 1, 0, 10000, 'admin', 'User', 'add', '', '管理员添加', '', '管理员添加'),
(113, 111, 2, 0, 10000, 'admin', 'User', 'addPost', '', '管理员添加提交', '', '管理员添加提交'),
(114, 111, 1, 0, 10000, 'admin', 'User', 'edit', '', '管理员编辑', '', '管理员编辑'),
(115, 111, 2, 0, 10000, 'admin', 'User', 'editPost', '', '管理员编辑提交', '', '管理员编辑提交'),
(116, 111, 1, 0, 10000, 'admin', 'User', 'userInfo', '', '个人信息', '', '管理员个人信息修改'),
(117, 111, 2, 0, 10000, 'admin', 'User', 'userInfoPost', '', '管理员个人信息修改提交', '', '管理员个人信息修改提交'),
(118, 111, 2, 0, 10000, 'admin', 'User', 'delete', '', '管理员删除', '', '管理员删除'),
(119, 111, 2, 0, 10000, 'admin', 'User', 'ban', '', '停用管理员', '', '停用管理员'),
(120, 111, 2, 0, 10000, 'admin', 'User', 'cancelBan', '', '启用管理员', '', '启用管理员'),
(121, 0, 0, 0, 30, 'portal', 'AdminIndex', 'default', '', '门户管理', 'th', '门户管理'),
(122, 121, 1, 1, 10000, 'portal', 'AdminArticle', 'index', '', '文章管理', '', '文章列表'),
(123, 122, 1, 0, 10000, 'portal', 'AdminArticle', 'add', '', '添加文章', '', '添加文章'),
(124, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'addPost', '', '添加文章提交', '', '添加文章提交'),
(125, 122, 1, 0, 10000, 'portal', 'AdminArticle', 'edit', '', '编辑文章', '', '编辑文章'),
(126, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'editPost', '', '编辑文章提交', '', '编辑文章提交'),
(127, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'delete', '', '文章删除', '', '文章删除'),
(128, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'publish', '', '文章发布', '', '文章发布'),
(129, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'top', '', '文章置顶', '', '文章置顶'),
(130, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'recommend', '', '文章推荐', '', '文章推荐'),
(131, 122, 2, 0, 10000, 'portal', 'AdminArticle', 'listOrder', '', '文章排序', '', '文章排序'),
(132, 121, 1, 1, 10000, 'portal', 'AdminCategory', 'index', '', '分类管理', '', '文章分类列表'),
(133, 132, 1, 0, 10000, 'portal', 'AdminCategory', 'add', '', '添加文章分类', '', '添加文章分类'),
(134, 132, 2, 0, 10000, 'portal', 'AdminCategory', 'addPost', '', '添加文章分类提交', '', '添加文章分类提交'),
(135, 132, 1, 0, 10000, 'portal', 'AdminCategory', 'edit', '', '编辑文章分类', '', '编辑文章分类'),
(136, 132, 2, 0, 10000, 'portal', 'AdminCategory', 'editPost', '', '编辑文章分类提交', '', '编辑文章分类提交'),
(137, 132, 1, 0, 10000, 'portal', 'AdminCategory', 'select', '', '文章分类选择对话框', '', '文章分类选择对话框'),
(138, 132, 2, 0, 10000, 'portal', 'AdminCategory', 'listOrder', '', '文章分类排序', '', '文章分类排序'),
(139, 132, 2, 0, 10000, 'portal', 'AdminCategory', 'delete', '', '删除文章分类', '', '删除文章分类'),
(140, 121, 1, 1, 10000, 'portal', 'AdminPage', 'index', '', '页面管理', '', '页面管理'),
(141, 140, 1, 0, 10000, 'portal', 'AdminPage', 'add', '', '添加页面', '', '添加页面'),
(142, 140, 2, 0, 10000, 'portal', 'AdminPage', 'addPost', '', '添加页面提交', '', '添加页面提交'),
(143, 140, 1, 0, 10000, 'portal', 'AdminPage', 'edit', '', '编辑页面', '', '编辑页面'),
(144, 140, 2, 0, 10000, 'portal', 'AdminPage', 'editPost', '', '编辑页面提交', '', '编辑页面提交'),
(145, 140, 2, 0, 10000, 'portal', 'AdminPage', 'delete', '', '删除页面', '', '删除页面'),
(146, 121, 1, 1, 10000, 'portal', 'AdminTag', 'index', '', '文章标签', '', '文章标签'),
(147, 146, 1, 0, 10000, 'portal', 'AdminTag', 'add', '', '添加文章标签', '', '添加文章标签'),
(148, 146, 2, 0, 10000, 'portal', 'AdminTag', 'addPost', '', '添加文章标签提交', '', '添加文章标签提交'),
(149, 146, 2, 0, 10000, 'portal', 'AdminTag', 'upStatus', '', '更新标签状态', '', '更新标签状态'),
(150, 146, 2, 0, 10000, 'portal', 'AdminTag', 'delete', '', '删除文章标签', '', '删除文章标签'),
(151, 0, 1, 0, 10000, 'user', 'AdminAsset', 'index', '', '资源管理', 'file', '资源管理列表'),
(152, 151, 2, 0, 10000, 'user', 'AdminAsset', 'delete', '', '删除文件', '', '删除文件'),
(153, 110, 0, 1, 10000, 'user', 'AdminIndex', 'default1', '', '用户组', '', '用户组'),
(154, 153, 1, 1, 10000, 'user', 'AdminIndex', 'index', '', '本站用户', '', '本站用户'),
(155, 154, 2, 0, 10000, 'user', 'AdminIndex', 'ban', '', '本站用户拉黑', '', '本站用户拉黑'),
(156, 154, 2, 0, 10000, 'user', 'AdminIndex', 'cancelBan', '', '本站用户启用', '', '本站用户启用'),
(157, 153, 1, 1, 10000, 'user', 'AdminOauth', 'index', '', '第三方用户', '', '第三方用户'),
(158, 157, 2, 0, 10000, 'user', 'AdminOauth', 'delete', '', '删除第三方用户绑定', '', '删除第三方用户绑定'),
(159, 6, 1, 1, 10000, 'user', 'AdminUserAction', 'index', '', '用户操作管理', '', '用户操作管理'),
(160, 159, 1, 0, 10000, 'user', 'AdminUserAction', 'edit', '', '编辑用户操作', '', '编辑用户操作'),
(161, 159, 2, 0, 10000, 'user', 'AdminUserAction', 'editPost', '', '编辑用户操作提交', '', '编辑用户操作提交'),
(162, 159, 1, 0, 10000, 'user', 'AdminUserAction', 'sync', '', '同步用户操作', '', '同步用户操作'),
(164, 0, 0, 1, 10000, 'admin', 'manage', 'default', '', '学校管理员', '', ''),
(165, 164, 1, 1, 10000, 'admin', 'manage', 'audit', 'status=2', '待审核', '', ''),
(166, 164, 1, 1, 10000, 'admin', 'manage', 'through', 'status=1', '已通过', '', ''),
(168, 164, 1, 0, 10000, 'admin', 'manage', 'school_info', '', '学校审核', '', ''),
(170, 0, 1, 1, 10000, 'admin', 'manage', 'general_admin', 'id=1', '普通管理员', '', ''),
(171, 0, 0, 1, 10000, 'admin', 'manage', 'default2', '', '普通用户', '', ''),
(172, 171, 1, 1, 10000, 'admin', 'manage', 'audit_user', 'id=2', '待审核', '', ''),
(173, 171, 1, 1, 10000, 'admin', 'manage', 'through_user', 'id=3', '已通过', '', ''),
(174, 0, 0, 1, 10000, 'admin', 'file', 'default', '', '文件管理', 'file', ''),
(175, 174, 1, 1, 10000, 'admin', 'file', 'audit', 'status=0', '待审核', '', ''),
(176, 174, 1, 1, 10000, 'admin', 'file', 'through', 'status=1', '已通过', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_asset`
--

CREATE TABLE `cmf_asset` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `file_size` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件大小,单位B',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传时间',
  `private_file` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0:公有, 1:私有',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态;1:可用,0:不可用',
  `download_times` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '下载次数',
  `file_number` int(10) UNSIGNED NOT NULL DEFAULT '1' COMMENT '引用oss上同一对象的文件个数',
  `file_key` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件惟一码',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `oss_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'oss地址',
  `oss_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'oss上的文件路径',
  `file_md5` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '文件md5值',
  `file_sha1` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名,不包括点',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '文件类型',
  `more` text COMMENT '其它详细信息,JSON格式'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资源表';

--
-- 转存表中的数据 `cmf_asset`
--

INSERT INTO `cmf_asset` (`id`, `user_id`, `file_size`, `create_time`, `private_file`, `status`, `download_times`, `file_number`, `file_key`, `filename`, `oss_host`, `oss_file`, `file_md5`, `file_sha1`, `suffix`, `type`, `more`) VALUES
(53, 14, 845941, 1547544472, 0, 1, 0, 3, '', 'Desert.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '14/Desert.jpg', 'ba45c8f60456a672e003a875e469d0eb', '', 'jpg', '图片', NULL),
(54, 14, 777835, 1547544473, 0, 1, 0, 1, '', 'Penguins.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '14/Penguins.jpg', '9d377b10ce778c4938b3c7e2c63a229a', '', 'jpg', '图片', NULL),
(55, 54, 0, 1547545144, 1, 2, 0, 1, '', '资源', '', '', '', '', '', '/', NULL),
(56, 54, 0, 1547545147, 1, 1, 0, 1, '', '资源', '', '', '', '', '', '/', NULL),
(57, 54, 0, 1547545149, 1, 1, 0, 1, '', '资源', '', '', '', '', '', '/', NULL),
(58, 54, 0, 1547549728, 1, 1, 0, 1, '', '哈哈', '', '', '', '', '', '/', NULL),
(59, 54, 0, 1547549730, 1, 1, 0, 1, '', '哈哈', '', '', '', '', '', '/', NULL),
(60, 46, 0, 1547552034, 1, 2, 0, 1, '', 'a', '', '', '', '', '', '/', NULL),
(61, 46, 0, 1547552036, 1, 2, 0, 1, '', 'a', '', '', '', '', '', '/', NULL),
(62, 46, 0, 1547552037, 1, 2, 0, 1, '', 'a', '', '', '', '', '', '/', NULL),
(63, 46, 0, 1547552037, 1, 2, 0, 1, '', 'a', '', '', '', '', '', '/', NULL),
(67, 46, 0, 1547555374, 1, 1, 0, 1, '', 'c', '', '', '', '', '', '/', NULL),
(69, 54, 0, 1547558886, 1, 1, 0, 1, '', '123', '', '', '', '', '', '/', NULL),
(72, 53, 10397, 1547599589, 0, 1, 0, 2, '', '1.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/1.jpg', 'a01b4e7b65d6fd781c8685546bb84352', '', 'jpg', '图片', NULL),
(73, 53, 4976441, 1547599657, 1, 2, 0, 5, '', 'you.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/you.mp3', '3c6a524f6834114860df0cc6bda9fd57', '', 'mp3', '音乐', NULL),
(74, 31, 0, 1547600189, 1, 1, 0, 1, '', '123', '', '', '', '', '', '/', NULL),
(75, 31, 0, 1547600191, 1, 1, 0, 1, '', '123', '', '', '', '', '', '/', NULL),
(76, 31, 0, 1547600220, 1, 1, 0, 1, '', '546', '', '', '', '', '', '/', NULL),
(77, 31, 0, 1547600237, 1, 1, 0, 1, '', '4987', '', '', '', '', '', '/', NULL),
(78, 31, 0, 1547600239, 1, 1, 0, 1, '', '4987', '', '', '', '', '', '/', NULL),
(81, 31, 845941, 1547600411, 1, 1, 0, 3, '', 'Desert.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '14/Desert.jpg', 'ba45c8f60456a672e003a875e469d0eb', '', 'jpg', '图片', NULL),
(82, 53, 0, 1547600772, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(83, 53, 0, 1547600776, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(84, 53, 0, 1547600777, 1, 1, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(85, 53, 0, 1547600777, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(86, 53, 0, 1547600777, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(87, 53, 0, 1547600778, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(88, 53, 0, 1547600778, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(89, 53, 0, 1547600778, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(90, 53, 0, 1547600779, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(91, 53, 0, 1547600781, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(92, 53, 0, 1547600782, 1, 2, 0, 1, '', 'zx', '', '', '', '', '', '/', NULL),
(93, 31, 0, 1547600805, 1, 1, 0, 1, '', '132', '', '', '', '', '', '/', NULL),
(94, 53, 4976441, 0, 1, 2, 0, 5, '', 'you.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/you.mp3', '3c6a524f6834114860df0cc6bda9fd57', '', 'mp3', '音乐', NULL),
(95, 31, 0, 1547600819, 1, 2, 0, 1, '', '54', '', '', '', '', '', '/', NULL),
(96, 46, 0, 1547600921, 1, 1, 0, 1, '', 'sc', '', '', '', '', '', '/', NULL),
(97, 53, 0, 1547600927, 1, 1, 0, 1, '', 'as', '', '', '', '', '', '/', NULL),
(98, 53, 10397, 1547600974, 1, 1, 0, 2, '', '2.ipg.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/1.jpg', 'a01b4e7b65d6fd781c8685546bb84352', '', 'jpg', '图片', NULL),
(99, 53, 0, 1547601005, 1, 1, 0, 1, '', 'zsd', '', '', '', '', '', '/', NULL),
(100, 53, 0, 1547601019, 1, 1, 0, 1, '', 'zsds', '', '', '', '', '', '/', NULL),
(101, 31, 775702, 1547601206, 1, 1, 0, 2, '', 'Jellyfish.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '31/Jellyfish.jpg', '5a44c7ba5bbe4ec867233d67e4806848', '', 'jpg', '图片', NULL),
(102, 31, 845941, 0, 1, 2, 0, 3, '', 'Desert.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '14/Desert.jpg', 'ba45c8f60456a672e003a875e469d0eb', '', 'jpg', '图片', NULL),
(103, 31, 775702, 0, 1, 2, 0, 2, '', 'Jellyfish.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '31/Jellyfish.jpg', '5a44c7ba5bbe4ec867233d67e4806848', '', 'jpg', '图片', NULL),
(104, 31, 6, 1547601664, 1, 2, 0, 1, '', 'mysql密码.txt', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '31/mysql密码.txt', 'e10adc3949ba59abbe56e057f20f883e', '', 'txt', '文档', NULL),
(105, 31, 19, 1547601674, 1, 2, 0, 1, '', 'SQL server 2008帐户和密码.txt', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '31/SQL server 2008帐户和密码.txt', 'b62b0ab73afea5e79b2a51db839085f2', '', 'txt', '文档', NULL),
(107, 45, 468509, 1547603141, 1, 1, 0, 1, '', '2cdc7353dfd98f92f05449ecceff69d4d701c4fb8005d-89s93H_fw658.png', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/2cdc7353dfd98f92f05449ecceff69d4d701c4fb8005d-89s93H_fw658.png', 'd73d3ceb5653891b8eed4ca852406022', '', 'png', '图片', NULL),
(108, 45, 178, 1547603242, 1, 1, 0, 1, '', 'test1.txt', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/test1.txt', '970db6237f990f03da70f42357397c9a', '', 'txt', '文档', NULL),
(109, 45, 6363180, 1547603370, 1, 1, 0, 2, '', 'f-18-11-19-02.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/f-18-11-19-02.mp3', '4ef9da2a36d519fcc90a5d41b345585d', '', 'mp3', '音乐', NULL),
(110, 54, 853504, 1547604028, 1, 1, 0, 1, '', 'qq.exe', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '54/diy0035344488.exe', '6d89ff46faa52b4d218e4160a0dd63c8', '', 'exe', '其他', NULL),
(111, 45, 0, 1547604297, 1, 1, 0, 1, '', 'hh', '', '', '', '', '', '/', NULL),
(112, 45, 0, 1547604310, 1, 1, 0, 1, '', 'hhh', '', '', '', '', '', '/', NULL),
(113, 45, 0, 1547604311, 1, 1, 0, 1, '', 'hhh', '', '', '', '', '', '/', NULL),
(114, 45, 0, 1547604311, 1, 1, 0, 1, '', 'hhh', '', '', '', '', '', '/', NULL),
(115, 45, 0, 1547604312, 1, 1, 0, 1, '', 'hhh', '', '', '', '', '', '/', NULL),
(116, 45, 0, 1547604313, 1, 1, 0, 1, '', 'hhh', '', '', '', '', '', '/', NULL),
(117, 53, 2039104, 1547605345, 1, 1, 0, 1, '', 'be100f9bb3a26491813fda39238dfc88.mp4', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/be100f9bb3a26491813fda39238dfc88.mp4', '44c4b1c5857b74eb8bcb6e1b06e624e0', '', 'mp4', '视频', NULL),
(118, 53, 4976441, 1547606535, 1, 1, 0, 5, '', 'you.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/you.mp3', '3c6a524f6834114860df0cc6bda9fd57', '', 'mp3', '音乐', NULL),
(119, 45, 938617, 1547606633, 1, 1, 0, 2, '', 'gif背景图.gif', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/gif背景图.gif', '688c1998919dd7e580c7fb0e59d580f8', '', 'gif', '图片', NULL),
(120, 53, 4976441, 1547606646, 1, 1, 0, 5, '', 'tuizheng.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/you.mp3', '3c6a524f6834114860df0cc6bda9fd57', '', 'mp3', '音乐', NULL),
(121, 45, 938617, 1547606678, 1, 1, 0, 2, '', 'gif背景图.gif', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/gif背景图.gif', '688c1998919dd7e580c7fb0e59d580f8', '', 'gif', '图片', NULL),
(122, 45, 458873938, 1547606783, 1, 1, 0, 1, '', 'mDust_005.mov', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/mDust_005.mov', 'b0ae1648871344400229cf1c77deb6f2', '', 'mov', '视频', NULL),
(123, 53, 4976441, 0, 1, 1, 0, 5, '', 'you.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '53/you.mp3', '3c6a524f6834114860df0cc6bda9fd57', '', 'mp3', '音乐', NULL),
(125, 54, 6363180, 1547609012, 1, 1, 0, 2, '', 'f-18-11-19-02.mp3', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '45/f-18-11-19-02.mp3', '4ef9da2a36d519fcc90a5d41b345585d', '', 'mp3', '音乐', NULL),
(126, 58, 1440799, 1547619641, 1, 2, 0, 1, '', '分布式文件管理系统需求说明书.docx', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/分布式文件管理系统需求说明书.docx', '2020cc6be30424dff2ed5bab6de20f46', '', 'docx', '文档', NULL),
(127, 58, 55296, 1547619661, 1, 1, 0, 1, '', '项目开发计划（GB856T——88）.doc', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/项目开发计划（GB856T——88）.doc', 'eeae56794d2c16958d6b45d3cf36e058', '', 'doc', '文档', NULL),
(128, 58, 81408, 1547619661, 1, 1, 0, 1, '', '网站建设方案.doc', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/网站建设方案.doc', '2ffaba527024c1587d705b629b29c777', '', 'doc', '文档', NULL),
(133, 58, 0, 1547619783, 1, 1, 0, 1, '', '454', '', '', '', '', '', '/', NULL),
(134, 58, 638464, 1547620679, 1, 2, 0, 1, '', 'zppt532.ppt', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/zppt532.ppt', 'fcab797f99082e6f9deefa6479b5c914', '', 'ppt', '文档', NULL),
(140, 58, 3177, 1547624247, 0, 1, 0, 1, '', '说明.htm', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/说明.htm', '4393f75e7770ca358ef82ec56a6dbea4', '', 'htm', '其他', NULL),
(141, 58, 337816, 1547625227, 1, 1, 0, 1, '', 'wallhaven-19797.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/wallhaven-19797.jpg', '73912023362e5eebf805d326653e0062', '', 'jpg', '图片', NULL),
(142, 58, 621442, 1547625233, 1, 1, 0, 1, '', 'wallhaven-555613.jpg', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '58/wallhaven-555613.jpg', 'e994c439c3f0d52d720ea3e3aa1ac51a', '', 'jpg', '图片', NULL),
(160, 46, 12376776, 1547645845, 1, 1, 5, 1, '', 'pic.ico', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '46/pic.ico', '3c91b8fae98450469a8e42403d04580b', '', 'ico', '其他', NULL),
(162, 46, 43151, 1547645973, 1, 1, 27, 1, '', 'distributions_scientific_linux_256px_540470_easyicon.net.png', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '46/distributions_scientific_linux_256px_540470_easyicon.net.png', '74ab98239dced7df23349f503db76aff', '', 'png', '图片', NULL),
(175, 46, 1070125, 1547646954, 1, 1, 2, 1, '', 'JM0203.zip', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '46/JM0203.zip', '270c3d62fe7b897ba0bf1e8594e8cba2', '', 'zip', '其他', NULL),
(180, 62, 22028, 1547695213, 1, 1, 0, 1, '', 'PHP面试题.docx', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '62/PHP面试题.docx', '48b5be0046d35ff506edaa91e47780f9', '', 'docx', '文档', NULL),
(181, 62, 127648, 1547696943, 0, 1, 0, 1, '', 'cowboy.sql', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '62/cowboy.sql', '00a8baf8bd66f23f2b30961a6c3e90c6', '', 'sql', '其他', NULL),
(182, 62, 0, 1547703822, 1, 1, 0, 1, '', '面包', '', '', '', '', '', '/', NULL),
(183, 62, 0, 1547703832, 1, 1, 2, 1, '', '牛奶', '', '', '', '', '', '/', NULL),
(184, 62, 0, 1547704003, 1, 1, 0, 1, '', '分享', '', '', '', '', '', '/', NULL),
(185, 46, 43520, 1547718859, 1, 1, 0, 1, '', '计算机161 班主任工作学生满意度测评表.doc', 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com', '46/计算机161 班主任工作学生满意度测评表.doc', '916235a4f1756886b23f0aaf5d850fd3', '', 'doc', '文档', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_auth_access`
--

CREATE TABLE `cmf_auth_access` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL COMMENT '角色',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类,请加应用前缀,如admin_'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限授权表';

--
-- 转存表中的数据 `cmf_auth_access`
--

INSERT INTO `cmf_auth_access` (`id`, `role_id`, `rule_name`, `type`) VALUES
(93, 3, 'admin/manage/default2', 'admin_url'),
(94, 3, 'admin/manage/audit_user', 'admin_url'),
(95, 3, 'admin/manage/through_user', 'admin_url'),
(96, 3, 'admin/file/default', 'admin_url'),
(97, 3, 'admin/file/audit', 'admin_url'),
(98, 3, 'admin/file/through', 'admin_url'),
(99, 2, 'admin/manage/general_admin', 'admin_url'),
(100, 2, 'admin/manage/default2', 'admin_url'),
(101, 2, 'admin/manage/audit_user', 'admin_url'),
(102, 2, 'admin/manage/through_user', 'admin_url'),
(103, 2, 'admin/file/default', 'admin_url'),
(104, 2, 'admin/file/audit', 'admin_url'),
(105, 2, 'admin/file/through', 'admin_url');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_auth_rule`
--

CREATE TABLE `cmf_auth_rule` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '规则id,自增主键',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `app` varchar(40) NOT NULL DEFAULT '' COMMENT '规则所属app',
  `type` varchar(30) NOT NULL DEFAULT '' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(100) NOT NULL DEFAULT '' COMMENT '额外url参数',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则描述',
  `condition` varchar(200) NOT NULL DEFAULT '' COMMENT '规则附加条件'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限规则表';

--
-- 转存表中的数据 `cmf_auth_rule`
--

INSERT INTO `cmf_auth_rule` (`id`, `status`, `app`, `type`, `name`, `param`, `title`, `condition`) VALUES
(1, 1, 'admin', 'admin_url', 'admin/Hook/index', '', '钩子管理', ''),
(2, 1, 'admin', 'admin_url', 'admin/Hook/plugins', '', '钩子插件管理', ''),
(3, 1, 'admin', 'admin_url', 'admin/Hook/pluginListOrder', '', '钩子插件排序', ''),
(4, 1, 'admin', 'admin_url', 'admin/Hook/sync', '', '同步钩子', ''),
(5, 1, 'admin', 'admin_url', 'admin/Link/index', '', '友情链接', ''),
(6, 1, 'admin', 'admin_url', 'admin/Link/add', '', '添加友情链接', ''),
(7, 1, 'admin', 'admin_url', 'admin/Link/addPost', '', '添加友情链接提交保存', ''),
(8, 1, 'admin', 'admin_url', 'admin/Link/edit', '', '编辑友情链接', ''),
(9, 1, 'admin', 'admin_url', 'admin/Link/editPost', '', '编辑友情链接提交保存', ''),
(10, 1, 'admin', 'admin_url', 'admin/Link/delete', '', '删除友情链接', ''),
(11, 1, 'admin', 'admin_url', 'admin/Link/listOrder', '', '友情链接排序', ''),
(12, 1, 'admin', 'admin_url', 'admin/Link/toggle', '', '友情链接显示隐藏', ''),
(13, 1, 'admin', 'admin_url', 'admin/Mailer/index', '', '邮箱配置', ''),
(14, 1, 'admin', 'admin_url', 'admin/Mailer/indexPost', '', '邮箱配置提交保存', ''),
(15, 1, 'admin', 'admin_url', 'admin/Mailer/template', '', '邮件模板', ''),
(16, 1, 'admin', 'admin_url', 'admin/Mailer/templatePost', '', '邮件模板提交', ''),
(17, 1, 'admin', 'admin_url', 'admin/Mailer/test', '', '邮件发送测试', ''),
(18, 1, 'admin', 'admin_url', 'admin/Menu/index', '', '后台菜单', ''),
(19, 1, 'admin', 'admin_url', 'admin/Menu/lists', '', '所有菜单', ''),
(20, 1, 'admin', 'admin_url', 'admin/Menu/add', '', '后台菜单添加', ''),
(21, 1, 'admin', 'admin_url', 'admin/Menu/addPost', '', '后台菜单添加提交保存', ''),
(22, 1, 'admin', 'admin_url', 'admin/Menu/edit', '', '后台菜单编辑', ''),
(23, 1, 'admin', 'admin_url', 'admin/Menu/editPost', '', '后台菜单编辑提交保存', ''),
(24, 1, 'admin', 'admin_url', 'admin/Menu/delete', '', '后台菜单删除', ''),
(25, 1, 'admin', 'admin_url', 'admin/Menu/listOrder', '', '后台菜单排序', ''),
(26, 1, 'admin', 'admin_url', 'admin/Menu/getActions', '', '导入新后台菜单', ''),
(27, 1, 'admin', 'admin_url', 'admin/Nav/index', '', '导航管理', ''),
(28, 1, 'admin', 'admin_url', 'admin/Nav/add', '', '添加导航', ''),
(29, 1, 'admin', 'admin_url', 'admin/Nav/addPost', '', '添加导航提交保存', ''),
(30, 1, 'admin', 'admin_url', 'admin/Nav/edit', '', '编辑导航', ''),
(31, 1, 'admin', 'admin_url', 'admin/Nav/editPost', '', '编辑导航提交保存', ''),
(32, 1, 'admin', 'admin_url', 'admin/Nav/delete', '', '删除导航', ''),
(33, 1, 'admin', 'admin_url', 'admin/NavMenu/index', '', '导航菜单', ''),
(34, 1, 'admin', 'admin_url', 'admin/NavMenu/add', '', '添加导航菜单', ''),
(35, 1, 'admin', 'admin_url', 'admin/NavMenu/addPost', '', '添加导航菜单提交保存', ''),
(36, 1, 'admin', 'admin_url', 'admin/NavMenu/edit', '', '编辑导航菜单', ''),
(37, 1, 'admin', 'admin_url', 'admin/NavMenu/editPost', '', '编辑导航菜单提交保存', ''),
(38, 1, 'admin', 'admin_url', 'admin/NavMenu/delete', '', '删除导航菜单', ''),
(39, 1, 'admin', 'admin_url', 'admin/NavMenu/listOrder', '', '导航菜单排序', ''),
(40, 1, 'admin', 'admin_url', 'admin/Plugin/default', '', '插件中心', ''),
(41, 1, 'admin', 'admin_url', 'admin/Plugin/index', '', '插件列表', ''),
(42, 1, 'admin', 'admin_url', 'admin/Plugin/toggle', '', '插件启用禁用', ''),
(43, 1, 'admin', 'admin_url', 'admin/Plugin/setting', '', '插件设置', ''),
(44, 1, 'admin', 'admin_url', 'admin/Plugin/settingPost', '', '插件设置提交', ''),
(45, 1, 'admin', 'admin_url', 'admin/Plugin/install', '', '插件安装', ''),
(46, 1, 'admin', 'admin_url', 'admin/Plugin/update', '', '插件更新', ''),
(47, 1, 'admin', 'admin_url', 'admin/Plugin/uninstall', '', '卸载插件', ''),
(48, 1, 'admin', 'admin_url', 'admin/Rbac/index', '', '角色管理', ''),
(49, 1, 'admin', 'admin_url', 'admin/Rbac/roleAdd', '', '添加角色', ''),
(50, 1, 'admin', 'admin_url', 'admin/Rbac/roleAddPost', '', '添加角色提交', ''),
(51, 1, 'admin', 'admin_url', 'admin/Rbac/roleEdit', '', '编辑角色', ''),
(52, 1, 'admin', 'admin_url', 'admin/Rbac/roleEditPost', '', '编辑角色提交', ''),
(53, 1, 'admin', 'admin_url', 'admin/Rbac/roleDelete', '', '删除角色', ''),
(54, 1, 'admin', 'admin_url', 'admin/Rbac/authorize', '', '设置角色权限', ''),
(55, 1, 'admin', 'admin_url', 'admin/Rbac/authorizePost', '', '角色授权提交', ''),
(56, 1, 'admin', 'admin_url', 'admin/RecycleBin/index', '', '回收站', ''),
(57, 1, 'admin', 'admin_url', 'admin/RecycleBin/restore', '', '回收站还原', ''),
(58, 1, 'admin', 'admin_url', 'admin/RecycleBin/delete', '', '回收站彻底删除', ''),
(59, 1, 'admin', 'admin_url', 'admin/Route/index', '', 'URL美化', ''),
(60, 1, 'admin', 'admin_url', 'admin/Route/add', '', '添加路由规则', ''),
(61, 1, 'admin', 'admin_url', 'admin/Route/addPost', '', '添加路由规则提交', ''),
(62, 1, 'admin', 'admin_url', 'admin/Route/edit', '', '路由规则编辑', ''),
(63, 1, 'admin', 'admin_url', 'admin/Route/editPost', '', '路由规则编辑提交', ''),
(64, 1, 'admin', 'admin_url', 'admin/Route/delete', '', '路由规则删除', ''),
(65, 1, 'admin', 'admin_url', 'admin/Route/ban', '', '路由规则禁用', ''),
(66, 1, 'admin', 'admin_url', 'admin/Route/open', '', '路由规则启用', ''),
(67, 1, 'admin', 'admin_url', 'admin/Route/listOrder', '', '路由规则排序', ''),
(68, 1, 'admin', 'admin_url', 'admin/Route/select', '', '选择URL', ''),
(69, 1, 'admin', 'admin_url', 'admin/Setting/default', '', '设置', ''),
(70, 1, 'admin', 'admin_url', 'admin/Setting/site', '', '网站信息', ''),
(71, 1, 'admin', 'admin_url', 'admin/Setting/sitePost', '', '网站信息设置提交', ''),
(72, 1, 'admin', 'admin_url', 'admin/Setting/password', '', '密码修改', ''),
(73, 1, 'admin', 'admin_url', 'admin/Setting/passwordPost', '', '密码修改提交', ''),
(74, 1, 'admin', 'admin_url', 'admin/Setting/upload', '', '上传设置', ''),
(75, 1, 'admin', 'admin_url', 'admin/Setting/uploadPost', '', '上传设置提交', ''),
(76, 1, 'admin', 'admin_url', 'admin/Setting/clearCache', '', '清除缓存', ''),
(77, 1, 'admin', 'admin_url', 'admin/Slide/index', '', '幻灯片管理', ''),
(78, 1, 'admin', 'admin_url', 'admin/Slide/add', '', '添加幻灯片', ''),
(79, 1, 'admin', 'admin_url', 'admin/Slide/addPost', '', '添加幻灯片提交', ''),
(80, 1, 'admin', 'admin_url', 'admin/Slide/edit', '', '编辑幻灯片', ''),
(81, 1, 'admin', 'admin_url', 'admin/Slide/editPost', '', '编辑幻灯片提交', ''),
(82, 1, 'admin', 'admin_url', 'admin/Slide/delete', '', '删除幻灯片', ''),
(83, 1, 'admin', 'admin_url', 'admin/SlideItem/index', '', '幻灯片页面列表', ''),
(84, 1, 'admin', 'admin_url', 'admin/SlideItem/add', '', '幻灯片页面添加', ''),
(85, 1, 'admin', 'admin_url', 'admin/SlideItem/addPost', '', '幻灯片页面添加提交', ''),
(86, 1, 'admin', 'admin_url', 'admin/SlideItem/edit', '', '幻灯片页面编辑', ''),
(87, 1, 'admin', 'admin_url', 'admin/SlideItem/editPost', '', '幻灯片页面编辑提交', ''),
(88, 1, 'admin', 'admin_url', 'admin/SlideItem/delete', '', '幻灯片页面删除', ''),
(89, 1, 'admin', 'admin_url', 'admin/SlideItem/ban', '', '幻灯片页面隐藏', ''),
(90, 1, 'admin', 'admin_url', 'admin/SlideItem/cancelBan', '', '幻灯片页面显示', ''),
(91, 1, 'admin', 'admin_url', 'admin/SlideItem/listOrder', '', '幻灯片页面排序', ''),
(92, 1, 'admin', 'admin_url', 'admin/Storage/index', '', '文件存储', ''),
(93, 1, 'admin', 'admin_url', 'admin/Storage/settingPost', '', '文件存储设置提交', ''),
(94, 1, 'admin', 'admin_url', 'admin/Theme/index', '', '模板管理', ''),
(95, 1, 'admin', 'admin_url', 'admin/Theme/install', '', '安装模板', ''),
(96, 1, 'admin', 'admin_url', 'admin/Theme/uninstall', '', '卸载模板', ''),
(97, 1, 'admin', 'admin_url', 'admin/Theme/installTheme', '', '模板安装', ''),
(98, 1, 'admin', 'admin_url', 'admin/Theme/update', '', '模板更新', ''),
(99, 1, 'admin', 'admin_url', 'admin/Theme/active', '', '启用模板', ''),
(100, 1, 'admin', 'admin_url', 'admin/Theme/files', '', '模板文件列表', ''),
(101, 1, 'admin', 'admin_url', 'admin/Theme/fileSetting', '', '模板文件设置', ''),
(102, 1, 'admin', 'admin_url', 'admin/Theme/fileArrayData', '', '模板文件数组数据列表', ''),
(103, 1, 'admin', 'admin_url', 'admin/Theme/fileArrayDataEdit', '', '模板文件数组数据添加编辑', ''),
(104, 1, 'admin', 'admin_url', 'admin/Theme/fileArrayDataEditPost', '', '模板文件数组数据添加编辑提交保存', ''),
(105, 1, 'admin', 'admin_url', 'admin/Theme/fileArrayDataDelete', '', '模板文件数组数据删除', ''),
(106, 1, 'admin', 'admin_url', 'admin/Theme/settingPost', '', '模板文件编辑提交保存', ''),
(107, 1, 'admin', 'admin_url', 'admin/Theme/dataSource', '', '模板文件设置数据源', ''),
(108, 1, 'admin', 'admin_url', 'admin/Theme/design', '', '模板设计', ''),
(109, 1, 'admin', 'admin_url', 'admin/User/default', '', '管理组', ''),
(110, 1, 'admin', 'admin_url', 'admin/User/index', '', '管理员', ''),
(111, 1, 'admin', 'admin_url', 'admin/User/add', '', '管理员添加', ''),
(112, 1, 'admin', 'admin_url', 'admin/User/addPost', '', '管理员添加提交', ''),
(113, 1, 'admin', 'admin_url', 'admin/User/edit', '', '管理员编辑', ''),
(114, 1, 'admin', 'admin_url', 'admin/User/editPost', '', '管理员编辑提交', ''),
(115, 1, 'admin', 'admin_url', 'admin/User/userInfo', '', '个人信息', ''),
(116, 1, 'admin', 'admin_url', 'admin/User/userInfoPost', '', '管理员个人信息修改提交', ''),
(117, 1, 'admin', 'admin_url', 'admin/User/delete', '', '管理员删除', ''),
(118, 1, 'admin', 'admin_url', 'admin/User/ban', '', '停用管理员', ''),
(119, 1, 'admin', 'admin_url', 'admin/User/cancelBan', '', '启用管理员', ''),
(120, 1, 'portal', 'admin_url', 'portal/AdminArticle/index', '', '文章管理', ''),
(121, 1, 'portal', 'admin_url', 'portal/AdminArticle/add', '', '添加文章', ''),
(122, 1, 'portal', 'admin_url', 'portal/AdminArticle/addPost', '', '添加文章提交', ''),
(123, 1, 'portal', 'admin_url', 'portal/AdminArticle/edit', '', '编辑文章', ''),
(124, 1, 'portal', 'admin_url', 'portal/AdminArticle/editPost', '', '编辑文章提交', ''),
(125, 1, 'portal', 'admin_url', 'portal/AdminArticle/delete', '', '文章删除', ''),
(126, 1, 'portal', 'admin_url', 'portal/AdminArticle/publish', '', '文章发布', ''),
(127, 1, 'portal', 'admin_url', 'portal/AdminArticle/top', '', '文章置顶', ''),
(128, 1, 'portal', 'admin_url', 'portal/AdminArticle/recommend', '', '文章推荐', ''),
(129, 1, 'portal', 'admin_url', 'portal/AdminArticle/listOrder', '', '文章排序', ''),
(130, 1, 'portal', 'admin_url', 'portal/AdminCategory/index', '', '分类管理', ''),
(131, 1, 'portal', 'admin_url', 'portal/AdminCategory/add', '', '添加文章分类', ''),
(132, 1, 'portal', 'admin_url', 'portal/AdminCategory/addPost', '', '添加文章分类提交', ''),
(133, 1, 'portal', 'admin_url', 'portal/AdminCategory/edit', '', '编辑文章分类', ''),
(134, 1, 'portal', 'admin_url', 'portal/AdminCategory/editPost', '', '编辑文章分类提交', ''),
(135, 1, 'portal', 'admin_url', 'portal/AdminCategory/select', '', '文章分类选择对话框', ''),
(136, 1, 'portal', 'admin_url', 'portal/AdminCategory/listOrder', '', '文章分类排序', ''),
(137, 1, 'portal', 'admin_url', 'portal/AdminCategory/delete', '', '删除文章分类', ''),
(138, 1, 'portal', 'admin_url', 'portal/AdminIndex/default', '', '门户管理', ''),
(139, 1, 'portal', 'admin_url', 'portal/AdminPage/index', '', '页面管理', ''),
(140, 1, 'portal', 'admin_url', 'portal/AdminPage/add', '', '添加页面', ''),
(141, 1, 'portal', 'admin_url', 'portal/AdminPage/addPost', '', '添加页面提交', ''),
(142, 1, 'portal', 'admin_url', 'portal/AdminPage/edit', '', '编辑页面', ''),
(143, 1, 'portal', 'admin_url', 'portal/AdminPage/editPost', '', '编辑页面提交', ''),
(144, 1, 'portal', 'admin_url', 'portal/AdminPage/delete', '', '删除页面', ''),
(145, 1, 'portal', 'admin_url', 'portal/AdminTag/index', '', '文章标签', ''),
(146, 1, 'portal', 'admin_url', 'portal/AdminTag/add', '', '添加文章标签', ''),
(147, 1, 'portal', 'admin_url', 'portal/AdminTag/addPost', '', '添加文章标签提交', ''),
(148, 1, 'portal', 'admin_url', 'portal/AdminTag/upStatus', '', '更新标签状态', ''),
(149, 1, 'portal', 'admin_url', 'portal/AdminTag/delete', '', '删除文章标签', ''),
(150, 1, 'user', 'admin_url', 'user/AdminAsset/index', '', '资源管理', ''),
(151, 1, 'user', 'admin_url', 'user/AdminAsset/delete', '', '删除文件', ''),
(152, 1, 'user', 'admin_url', 'user/AdminIndex/default', '', '用户管理', ''),
(153, 1, 'user', 'admin_url', 'user/AdminIndex/default1', '', '用户组', ''),
(154, 1, 'user', 'admin_url', 'user/AdminIndex/index', '', '本站用户', ''),
(155, 1, 'user', 'admin_url', 'user/AdminIndex/ban', '', '本站用户拉黑', ''),
(156, 1, 'user', 'admin_url', 'user/AdminIndex/cancelBan', '', '本站用户启用', ''),
(157, 1, 'user', 'admin_url', 'user/AdminOauth/index', '', '第三方用户', ''),
(158, 1, 'user', 'admin_url', 'user/AdminOauth/delete', '', '删除第三方用户绑定', ''),
(159, 1, 'user', 'admin_url', 'user/AdminUserAction/index', '', '用户操作管理', ''),
(160, 1, 'user', 'admin_url', 'user/AdminUserAction/edit', '', '编辑用户操作', ''),
(161, 1, 'user', 'admin_url', 'user/AdminUserAction/editPost', '', '编辑用户操作提交', ''),
(162, 1, 'user', 'admin_url', 'user/AdminUserAction/sync', '', '同步用户操作', ''),
(163, 1, 'admin', 'admin_url', 'admin/user/audit', 'value=1', '管理员审核', ''),
(164, 1, 'admin', 'admin_url', 'admin/manage/default', '', '学校管理员', ''),
(165, 1, 'admin', 'admin_url', 'admin/manage/audit', 'status=2', '待审核', ''),
(166, 1, 'admin', 'admin_url', 'admin/manage/through', 'status=1', '已通过', ''),
(167, 1, 'admin', 'admin_url', 'admin/manage/school_info', 'id = 19', '学校审核信息', ''),
(168, 1, 'admin', 'admin_url', 'admin/manage/default2', '', '用户管理', ''),
(169, 1, 'admin', 'admin_url', 'admin/manage/general_admin', 'id=1', '普通管理员', ''),
(170, 1, 'admin', 'admin_url', 'admin/manage/audit_user', 'id=2', '待审核', ''),
(171, 1, 'admin', 'admin_url', 'admin/manage/through_user', 'id=3', '已通过', ''),
(172, 1, 'admin', 'admin_url', 'admin/file/default', '', '文件管理', ''),
(173, 1, 'admin', 'admin_url', 'admin/file/audit', 'status=0', '待审核', ''),
(174, 1, 'admin', 'admin_url', 'admin/file/through', 'status=1', '已通过', '');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_comment`
--

CREATE TABLE `cmf_comment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_user_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `object_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '点赞数',
  `dislike_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '不喜欢数',
  `floor` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '楼层数',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论时间',
  `delete_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '删除时间',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:已审核,0:未审核',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '评论内容所在表，不带表前缀',
  `full_name` varchar(50) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '评论者邮箱',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系',
  `url` text COMMENT '原文地址',
  `content` text CHARACTER SET utf8mb4 COMMENT '评论内容',
  `more` text CHARACTER SET utf8mb4 COMMENT '扩展属性'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_dir_file`
--

CREATE TABLE `cmf_dir_file` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dir_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件夹ID',
  `file_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件ID'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='文件夹和文件关系表';

--
-- 转存表中的数据 `cmf_dir_file`
--

INSERT INTO `cmf_dir_file` (`id`, `dir_id`, `file_id`) VALUES
(63, 0, 63),
(62, 0, 62),
(61, 0, 61),
(54, 0, 54),
(53, 0, 53),
(60, 0, 60),
(59, 0, 59),
(57, 0, 57),
(56, 0, 56),
(55, 0, 55),
(183, 182, 183),
(182, 0, 182),
(58, 0, 58),
(109, 0, 109),
(67, 65, 67),
(108, 0, 108),
(107, 0, 107),
(69, 0, 69),
(111, 0, 111),
(110, 0, 110),
(72, 0, 72),
(73, 0, 73),
(74, 0, 74),
(75, 0, 75),
(76, 0, 76),
(77, 0, 77),
(78, 0, 78),
(81, 78, 81),
(82, 0, 82),
(83, 0, 83),
(84, 0, 84),
(85, 0, 85),
(86, 0, 86),
(87, 0, 87),
(88, 0, 88),
(89, 0, 89),
(90, 0, 90),
(91, 0, 91),
(92, 0, 92),
(93, 78, 93),
(94, 82, 94),
(95, 0, 95),
(96, 0, 96),
(97, 91, 97),
(98, 84, 98),
(99, 0, 99),
(100, 0, 100),
(101, 78, 101),
(102, 95, 102),
(103, 95, 103),
(104, 95, 104),
(105, 95, 105),
(185, 0, 185),
(112, 0, 112),
(113, 0, 113),
(114, 0, 114),
(115, 0, 115),
(116, 0, 116),
(117, 84, 117),
(118, 100, 118),
(119, 0, 119),
(120, 0, 120),
(121, 0, 121),
(122, 0, 122),
(123, 84, 123),
(125, 0, 125),
(126, 0, 126),
(127, 0, 127),
(128, 133, 128),
(142, 133, 142),
(134, 133, 134),
(133, 0, 133),
(141, 133, 141),
(140, 0, 140),
(162, 0, 162),
(181, 0, 181),
(160, 0, 160),
(180, 183, 180),
(175, 0, 175),
(184, 183, 184);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_file_recycle`
--

CREATE TABLE `cmf_file_recycle` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `file_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件ID',
  `recycle_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件放入回收站的时间',
  `end_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件自动清理的时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `cmf_file_recycle`
--

INSERT INTO `cmf_file_recycle` (`id`, `file_id`, `recycle_time`, `end_time`) VALUES
(84, 135, 1547621265, 1548226065),
(83, 136, 1547621265, 1548226065),
(82, 137, 1547621265, 1548226065),
(81, 138, 1547621265, 1548226065),
(80, 139, 1547621265, 1548226065),
(79, 129, 1547619801, 1548224601),
(78, 130, 1547619800, 1548224600),
(77, 131, 1547619799, 1548224599),
(76, 132, 1547619796, 1548224596),
(69, 64, 1547602928, 1548207728),
(68, 66, 1547602928, 1548207728),
(67, 68, 1547602928, 1548207728),
(65, 71, 1547602928, 1548207728),
(61, 105, 1547601869, 1548206669),
(58, 102, 1547601356, 1548206156),
(57, 85, 1547600906, 1548205706),
(56, 86, 1547600906, 1548205706),
(55, 87, 1547600906, 1548205706),
(54, 88, 1547600906, 1548205706),
(53, 89, 1547600906, 1548205706),
(52, 90, 1547600906, 1548205706),
(51, 91, 1547600906, 1548205706),
(50, 83, 1547600885, 1548205685),
(49, 82, 1547600885, 1548205685),
(48, 92, 1547600878, 1548205678),
(47, 73, 1547600863, 1548205663),
(62, 95, 1547602716, 1548207516),
(45, 55, 1547580888, 1548185688),
(44, 65, 1547552582, 1548157382),
(66, 70, 1547602928, 1548207728),
(42, 44, 1547548832, 1548153632),
(41, 50, 1547544641, 1548149441),
(40, 51, 1547544641, 1548149441),
(38, 45, 1547489348, 1548094148),
(85, 148, 1547626372, 1548231172),
(86, 146, 1547626373, 1548231173),
(87, 147, 1547626374, 1548231174),
(88, 145, 1547626376, 1548231176),
(89, 144, 1547626377, 1548231177),
(90, 134, 1547626730, 1548231530),
(91, 126, 1547626733, 1548231533),
(92, 151, 1547637082, 1548241882),
(93, 152, 1547637373, 1548242173),
(94, 153, 1547637608, 1548242408),
(95, 154, 1547637685, 1548242485),
(96, 155, 1547637897, 1548242697),
(97, 156, 1547638530, 1548243330),
(98, 158, 1547645805, 1548250605),
(99, 157, 1547645805, 1548250605),
(100, 150, 1547645805, 1548250605),
(101, 149, 1547645805, 1548250605),
(102, 106, 1547645805, 1548250605),
(103, 49, 1547645805, 1548250605),
(104, 48, 1547645805, 1548250605),
(105, 47, 1547645805, 1548250605),
(106, 46, 1547645805, 1548250605),
(107, 164, 1547646242, 1548251042),
(108, 163, 1547646242, 1548251042),
(109, 166, 1547646567, 1548251367),
(110, 169, 1547646765, 1548251565),
(111, 168, 1547646765, 1548251565),
(112, 172, 1547646868, 1548251668),
(113, 171, 1547646868, 1548251668),
(114, 174, 1547646928, 1548251728),
(115, 173, 1547646928, 1548251728),
(116, 170, 1547646928, 1548251728),
(117, 167, 1547646928, 1548251728),
(118, 161, 1547646928, 1548251728),
(119, 165, 1547646928, 1548251728),
(120, 176, 1547658036, 1548262836),
(121, 159, 1547664690, 1548269490),
(123, 143, 1547717703, 1548322503),
(124, 124, 1547717703, 1548322503),
(125, 178, 1547717709, 1548322509),
(126, 179, 1547717709, 1548322509),
(127, 80, 1547717712, 1548322512),
(128, 79, 1547717712, 1548322512),
(129, 177, 1547717725, 1548322525);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_file_tag`
--

CREATE TABLE `cmf_file_tag` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `file_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件ID',
  `tag_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签ID'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `cmf_file_tag`
--

INSERT INTO `cmf_file_tag` (`id`, `file_id`, `tag_id`) VALUES
(7, 106, 0),
(6, 106, 0),
(16, 150, 20),
(14, 106, 18),
(18, 180, 24),
(19, 180, 25),
(20, 181, 26),
(21, 181, 27),
(23, 133, 29);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_hook`
--

CREATE TABLE `cmf_hook` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '钩子类型(1:系统钩子;2:应用钩子;3:模板钩子;4:后台模板钩子)',
  `once` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否只允许一个插件运行(0:多个;1:一个)',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子',
  `app` varchar(15) NOT NULL DEFAULT '' COMMENT '应用名(只有应用钩子才用)',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子表';

--
-- 转存表中的数据 `cmf_hook`
--

INSERT INTO `cmf_hook` (`id`, `type`, `once`, `name`, `hook`, `app`, `description`) VALUES
(1, 1, 0, '应用初始化', 'app_init', 'cmf', '应用初始化'),
(2, 1, 0, '应用开始', 'app_begin', 'cmf', '应用开始'),
(3, 1, 0, '模块初始化', 'module_init', 'cmf', '模块初始化'),
(4, 1, 0, '控制器开始', 'action_begin', 'cmf', '控制器开始'),
(5, 1, 0, '视图输出过滤', 'view_filter', 'cmf', '视图输出过滤'),
(6, 1, 0, '应用结束', 'app_end', 'cmf', '应用结束'),
(7, 1, 0, '日志write方法', 'log_write', 'cmf', '日志write方法'),
(8, 1, 0, '输出结束', 'response_end', 'cmf', '输出结束'),
(9, 1, 0, '后台控制器初始化', 'admin_init', 'cmf', '后台控制器初始化'),
(10, 1, 0, '前台控制器初始化', 'home_init', 'cmf', '前台控制器初始化'),
(11, 1, 1, '发送手机验证码', 'send_mobile_verification_code', 'cmf', '发送手机验证码'),
(12, 3, 0, '模板 body标签开始', 'body_start', '', '模板 body标签开始'),
(13, 3, 0, '模板 head标签结束前', 'before_head_end', '', '模板 head标签结束前'),
(14, 3, 0, '模板底部开始', 'footer_start', '', '模板底部开始'),
(15, 3, 0, '模板底部开始之前', 'before_footer', '', '模板底部开始之前'),
(16, 3, 0, '模板底部结束之前', 'before_footer_end', '', '模板底部结束之前'),
(17, 3, 0, '模板 body 标签结束之前', 'before_body_end', '', '模板 body 标签结束之前'),
(18, 3, 0, '模板左边栏开始', 'left_sidebar_start', '', '模板左边栏开始'),
(19, 3, 0, '模板左边栏结束之前', 'before_left_sidebar_end', '', '模板左边栏结束之前'),
(20, 3, 0, '模板右边栏开始', 'right_sidebar_start', '', '模板右边栏开始'),
(21, 3, 0, '模板右边栏结束之前', 'before_right_sidebar_end', '', '模板右边栏结束之前'),
(22, 3, 1, '评论区', 'comment', '', '评论区'),
(23, 3, 1, '留言区', 'guestbook', '', '留言区'),
(24, 2, 0, '后台首页仪表盘', 'admin_dashboard', 'admin', '后台首页仪表盘'),
(25, 4, 0, '后台模板 head标签结束前', 'admin_before_head_end', '', '后台模板 head标签结束前'),
(26, 4, 0, '后台模板 body 标签结束之前', 'admin_before_body_end', '', '后台模板 body 标签结束之前'),
(27, 2, 0, '后台登录页面', 'admin_login', 'admin', '后台登录页面'),
(28, 1, 1, '前台模板切换', 'switch_theme', 'cmf', '前台模板切换'),
(29, 3, 0, '主要内容之后', 'after_content', '', '主要内容之后'),
(30, 2, 0, '文章显示之前', 'portal_before_assign_article', 'portal', '文章显示之前'),
(31, 2, 0, '后台文章保存之后', 'portal_admin_after_save_article', 'portal', '后台文章保存之后'),
(32, 2, 1, '获取上传界面', 'fetch_upload_view', 'user', '获取上传界面'),
(33, 3, 0, '主要内容之前', 'before_content', 'cmf', '主要内容之前'),
(34, 1, 0, '日志写入完成', 'log_write_done', 'cmf', '日志写入完成'),
(35, 1, 1, '后台模板切换', 'switch_admin_theme', 'cmf', '后台模板切换'),
(36, 1, 1, '验证码图片', 'captcha_image', 'cmf', '验证码图片'),
(37, 2, 1, '后台模板设计界面', 'admin_theme_design_view', 'admin', '后台模板设计界面'),
(38, 2, 1, '后台设置网站信息界面', 'admin_setting_site_view', 'admin', '后台设置网站信息界面'),
(39, 2, 1, '后台清除缓存界面', 'admin_setting_clear_cache_view', 'admin', '后台清除缓存界面'),
(40, 2, 1, '后台导航管理界面', 'admin_nav_index_view', 'admin', '后台导航管理界面'),
(41, 2, 1, '后台友情链接管理界面', 'admin_link_index_view', 'admin', '后台友情链接管理界面'),
(42, 2, 1, '后台幻灯片管理界面', 'admin_slide_index_view', 'admin', '后台幻灯片管理界面'),
(43, 2, 1, '后台管理员列表界面', 'admin_user_index_view', 'admin', '后台管理员列表界面'),
(44, 2, 1, '后台角色管理界面', 'admin_rbac_index_view', 'admin', '后台角色管理界面'),
(45, 2, 1, '门户后台文章管理列表界面', 'portal_admin_article_index_view', 'portal', '门户后台文章管理列表界面'),
(46, 2, 1, '门户后台文章分类管理列表界面', 'portal_admin_category_index_view', 'portal', '门户后台文章分类管理列表界面'),
(47, 2, 1, '门户后台页面管理列表界面', 'portal_admin_page_index_view', 'portal', '门户后台页面管理列表界面'),
(48, 2, 1, '门户后台文章标签管理列表界面', 'portal_admin_tag_index_view', 'portal', '门户后台文章标签管理列表界面'),
(49, 2, 1, '用户管理本站用户列表界面', 'user_admin_index_view', 'user', '用户管理本站用户列表界面'),
(50, 2, 1, '资源管理列表界面', 'user_admin_asset_index_view', 'user', '资源管理列表界面'),
(51, 2, 1, '用户管理第三方用户列表界面', 'user_admin_oauth_index_view', 'user', '用户管理第三方用户列表界面'),
(52, 2, 1, '后台首页界面', 'admin_index_index_view', 'admin', '后台首页界面'),
(53, 2, 1, '后台回收站界面', 'admin_recycle_bin_index_view', 'admin', '后台回收站界面'),
(54, 2, 1, '后台菜单管理界面', 'admin_menu_index_view', 'admin', '后台菜单管理界面'),
(55, 2, 1, '后台自定义登录是否开启钩子', 'admin_custom_login_open', 'admin', '后台自定义登录是否开启钩子'),
(56, 4, 0, '门户后台文章添加编辑界面右侧栏', 'portal_admin_article_edit_view_right_sidebar', 'portal', '门户后台文章添加编辑界面右侧栏'),
(57, 4, 0, '门户后台文章添加编辑界面主要内容', 'portal_admin_article_edit_view_main', 'portal', '门户后台文章添加编辑界面主要内容'),
(58, 2, 1, '门户后台文章添加界面', 'portal_admin_article_add_view', 'portal', '门户后台文章添加界面'),
(59, 2, 1, '门户后台文章编辑界面', 'portal_admin_article_edit_view', 'portal', '门户后台文章编辑界面'),
(60, 2, 1, '门户后台文章分类添加界面', 'portal_admin_category_add_view', 'portal', '门户后台文章分类添加界面'),
(61, 2, 1, '门户后台文章分类编辑界面', 'portal_admin_category_edit_view', 'portal', '门户后台文章分类编辑界面'),
(62, 2, 1, '门户后台页面添加界面', 'portal_admin_page_add_view', 'portal', '门户后台页面添加界面'),
(63, 2, 1, '门户后台页面编辑界面', 'portal_admin_page_edit_view', 'portal', '门户后台页面编辑界面'),
(64, 2, 1, '后台幻灯片页面列表界面', 'admin_slide_item_index_view', 'admin', '后台幻灯片页面列表界面'),
(65, 2, 1, '后台幻灯片页面添加界面', 'admin_slide_item_add_view', 'admin', '后台幻灯片页面添加界面'),
(66, 2, 1, '后台幻灯片页面编辑界面', 'admin_slide_item_edit_view', 'admin', '后台幻灯片页面编辑界面'),
(67, 2, 1, '后台管理员添加界面', 'admin_user_add_view', 'admin', '后台管理员添加界面'),
(68, 2, 1, '后台管理员编辑界面', 'admin_user_edit_view', 'admin', '后台管理员编辑界面'),
(69, 2, 1, '后台角色添加界面', 'admin_rbac_role_add_view', 'admin', '后台角色添加界面'),
(70, 2, 1, '后台角色编辑界面', 'admin_rbac_role_edit_view', 'admin', '后台角色编辑界面'),
(71, 2, 1, '后台角色授权界面', 'admin_rbac_authorize_view', 'admin', '后台角色授权界面');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_hook_plugin`
--

CREATE TABLE `cmf_hook_plugin` (
  `id` int(10) UNSIGNED NOT NULL,
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `hook` varchar(50) NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) NOT NULL DEFAULT '' COMMENT '插件'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统钩子插件表';

--
-- 转存表中的数据 `cmf_hook_plugin`
--

INSERT INTO `cmf_hook_plugin` (`id`, `list_order`, `status`, `hook`, `plugin`) VALUES
(4, 10000, 1, 'admin_login', 'ShangAdminLogin');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_link`
--

CREATE TABLE `cmf_link` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='友情链接表';

--
-- 转存表中的数据 `cmf_link`
--

INSERT INTO `cmf_link` (`id`, `status`, `rating`, `list_order`, `description`, `url`, `name`, `image`, `target`, `rel`) VALUES
(1, 1, 1, 8, 'thinkcmf官网', 'http://www.thinkcmf.com', 'ThinkCMF', '', '_blank', '');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_nav`
--

CREATE TABLE `cmf_nav` (
  `id` int(10) UNSIGNED NOT NULL,
  `is_main` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否为主导航;1:是;0:不是',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '导航位置名称',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='前台导航位置表';

--
-- 转存表中的数据 `cmf_nav`
--

INSERT INTO `cmf_nav` (`id`, `is_main`, `name`, `remark`) VALUES
(1, 1, '主导航', '主导航'),
(2, 0, '底部导航', '');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_nav_menu`
--

CREATE TABLE `cmf_nav_menu` (
  `id` int(11) NOT NULL,
  `nav_id` int(11) NOT NULL COMMENT '导航 id',
  `parent_id` int(11) NOT NULL COMMENT '父 id',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '打开方式',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(20) NOT NULL DEFAULT '' COMMENT '图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '层级关系'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='前台导航菜单表';

--
-- 转存表中的数据 `cmf_nav_menu`
--

INSERT INTO `cmf_nav_menu` (`id`, `nav_id`, `parent_id`, `status`, `list_order`, `name`, `target`, `href`, `icon`, `path`) VALUES
(1, 1, 0, 1, 0, '首页', '', 'home', '', '0-1');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_option`
--

CREATE TABLE `cmf_option` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `autoload` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否自动加载;1:自动加载;0:不自动加载',
  `option_name` varchar(64) NOT NULL DEFAULT '' COMMENT '配置名',
  `option_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '配置值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='全站配置表' ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `cmf_option`
--

INSERT INTO `cmf_option` (`id`, `autoload`, `option_name`, `option_value`) VALUES
(1, 1, 'site_info', '{\"site_name\":\"\\u5206\\u5e03\\u5f0f\\u6587\\u4ef6\\u7ba1\\u7406\\u7cfb\\u7edf\",\"site_seo_title\":\"\\u5206\\u5e03\\u5f0f\\u6587\\u4ef6\\u7ba1\\u7406\\u7cfb\\u7edf\",\"site_seo_keywords\":\"ThinkCMF,php,\\u5185\\u5bb9\\u7ba1\\u7406\\u6846\\u67b6,cmf,cms,\\u7b80\\u7ea6\\u98ce, simplewind,framework,\\u6587\\u4ef6\\u7ba1\\u7406\",\"site_seo_description\":\"\\u8fd9\\u662f\\u725b\\u4ed4\\u5f88\\u5fd9\\u56e2\\u961f\\u5f00\\u53d1\\u7684\\u5206\\u5e03\\u5f0f\\u6587\\u4ef6\\u7ba1\\u7406\\u7cfb\\u7edf\"}'),
(2, 1, 'smtp_setting', '{\"from_name\":\"\\u5206\\u5e03\\u5f0f\\u6587\\u4ef6\\u7ba1\\u7406\\u7cfb\\u7edf\",\"from\":\"763992263@qq.com\",\"host\":\"smtp.qq.com\",\"smtp_secure\":\"ssl\",\"port\":\"465\",\"username\":\"763992263@qq.com\",\"password\":\"xekmbzgmqumubejb\"}'),
(3, 1, 'email_template_verification_code', '{\"subject\":\"\\u5206\\u5e03\\u5f0f\\u6587\\u4ef6\\u7ba1\\u7406\\u7cfb\\u7edf\",\"template\":\"&lt;p style=&quot;white-space: normal;&quot;&gt;\\u4f60\\u597d {$username}\\uff0c\\u4f60\\u7684\\u9a8c\\u8bc1\\u7801\\u4e3a\\uff1a{$code}&lt;\\/p&gt;\"}'),
(4, 1, 'admin_dashboard_widgets', '[{\"name\":\"CmfHub\",\"is_system\":1},{\"name\":\"MainContributors\",\"is_system\":1},{\"name\":\"Contributors\",\"is_system\":1},{\"name\":\"CmfDocuments\",\"is_system\":1},{\"name\":\"Custom1\",\"is_system\":1},{\"name\":\"Custom2\",\"is_system\":1},{\"name\":\"Custom3\",\"is_system\":1},{\"name\":\"Custom4\",\"is_system\":1},{\"name\":\"Custom5\",\"is_system\":1}]');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_plugin`
--

CREATE TABLE `cmf_plugin` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '自增id',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件表';

--
-- 转存表中的数据 `cmf_plugin`
--

INSERT INTO `cmf_plugin` (`id`, `type`, `has_admin`, `status`, `create_time`, `name`, `title`, `demo_url`, `hooks`, `author`, `author_url`, `version`, `description`, `config`) VALUES
(4, 1, 0, 1, 0, 'ShangAdminLogin', '大气后台登录页面', '', '', '推尚网络', '', '1.0', '新版蓝色大气后台登录页面', '{\"login_title\":\"\\u6587\\u4ef6\\u7ba1\\u7406\\u7cfb\\u7edf\\u540e\\u53f0\",\"login_en\":\"File management system background\",\"login_copyright\":\"\\u6280\\u672f\\u652f\\u6301\\uff1a\\u725b\\u4ed4\\u5f88\\u5fd9\"}');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_portal_category`
--

CREATE TABLE `cmf_portal_category` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '分类id',
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类父id',
  `post_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类文章数',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `delete_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '删除时间',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '分类层级关系路径',
  `seo_title` varchar(100) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(255) NOT NULL DEFAULT '',
  `list_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类列表模板',
  `one_tpl` varchar(50) NOT NULL DEFAULT '' COMMENT '分类文章页模板',
  `more` text COMMENT '扩展属性'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章分类表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_portal_category_post`
--

CREATE TABLE `cmf_portal_category_post` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文章id',
  `category_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 分类文章对应表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_portal_post`
--

CREATE TABLE `cmf_portal_post` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父级id',
  `post_type` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '类型,1:文章;2:页面',
  `post_format` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '内容格式;1:html;2:md',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发表者用户id',
  `post_status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态;1:已发布;0:未发布;',
  `comment_status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '评论状态;1:允许;0:不允许',
  `is_top` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否置顶;1:置顶;0:不置顶',
  `recommended` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_hits` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '查看数',
  `post_favorites` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏数',
  `post_like` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '点赞数',
  `comment_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论数',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `published_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发布时间',
  `delete_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '删除时间',
  `post_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'post标题',
  `post_keywords` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo keywords',
  `post_excerpt` varchar(500) NOT NULL DEFAULT '' COMMENT 'post摘要',
  `post_source` varchar(150) NOT NULL DEFAULT '' COMMENT '转载文章的来源',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `post_content` text COMMENT '文章内容',
  `post_content_filtered` text COMMENT '处理过的文章内容',
  `more` text COMMENT '扩展属性,如缩略图;格式为json'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章表' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- 表的结构 `cmf_portal_tag`
--

CREATE TABLE `cmf_portal_tag` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '分类id',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:发布,0:不发布',
  `recommended` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否推荐;1:推荐;0:不推荐',
  `post_count` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签文章数',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标签名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='portal应用 文章标签表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_portal_tag_post`
--

CREATE TABLE `cmf_portal_tag_post` (
  `id` bigint(20) NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签 id',
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文章 id',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:发布;0:不发布'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='portal应用 标签文章对应表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_recycle_bin`
--

CREATE TABLE `cmf_recycle_bin` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `object_id` int(11) DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int(10) UNSIGNED DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=' 回收站';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_role`
--

CREATE TABLE `cmf_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '状态;0:禁用;1:正常',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `list_order` float NOT NULL DEFAULT '0' COMMENT '排序',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

--
-- 转存表中的数据 `cmf_role`
--

INSERT INTO `cmf_role` (`id`, `parent_id`, `status`, `create_time`, `update_time`, `list_order`, `name`, `remark`) VALUES
(1, 0, 1, 1329633709, 1329633709, 0, '超级管理员', '拥有网站最高管理员权限！'),
(2, 0, 1, 1329633709, 1329633709, 0, '学校管理员', '权限由最高管理员分配！'),
(3, 0, 1, 0, 0, 0, '普通管理员', '权限由学校管理员分配!'),
(4, 0, 1, 0, 0, 0, '普通用户', '权限由普通管理员分配!');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_role_user`
--

CREATE TABLE `cmf_role_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '角色 id',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `school_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '学校ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

--
-- 转存表中的数据 `cmf_role_user`
--

INSERT INTO `cmf_role_user` (`id`, `role_id`, `user_id`, `school_id`) VALUES
(1, 2, 2, 1),
(2, 4, 12, 1),
(3, 4, 13, 1),
(4, 3, 14, 1),
(5, 2, 15, 6),
(6, 2, 16, 6),
(7, 4, 17, 6),
(8, 4, 18, 6),
(10, 4, 20, 6),
(11, 2, 21, 7),
(12, 4, 22, 1),
(21, 2, 31, 16),
(22, 4, 32, 1),
(25, 4, 35, 16),
(26, 4, 36, 16),
(31, 2, 41, 18),
(32, 3, 42, 16),
(33, 4, 43, 1),
(34, 4, 44, 1),
(35, 3, 45, 1),
(36, 3, 46, 2),
(37, 4, 47, 1),
(38, 4, 48, 1),
(39, 4, 49, 2),
(40, 4, 50, 1),
(41, 4, 51, 1),
(42, 4, 52, 1),
(43, 4, 53, 2),
(44, 4, 54, 1),
(46, 4, 56, 1),
(47, 4, 57, 1),
(48, 4, 58, 1),
(49, 4, 59, 1),
(50, 3, 60, 1),
(51, 4, 61, 1),
(52, 4, 62, 1);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_route`
--

CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL COMMENT '路由id',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态;1:启用,0:不启用',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'URL规则类型;1:用户自定义;2:别名添加',
  `full_url` varchar(255) NOT NULL DEFAULT '' COMMENT '完整url',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '实际显示的url'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='url路由表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_school`
--

CREATE TABLE `cmf_school` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '学校ID',
  `school_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学校名称',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学校地址',
  `register_time` int(11) NOT NULL DEFAULT '0' COMMENT '学校注册时间',
  `status` tinyint(3) NOT NULL DEFAULT '2' COMMENT '学校状态;0:禁用,1:正常,2:未验证',
  `business_license` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '学校营业执照',
  `school_logo` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '学校logo'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `cmf_school`
--

INSERT INTO `cmf_school` (`id`, `school_name`, `address`, `register_time`, `status`, `business_license`, `school_logo`) VALUES
(1, '广轻', '佛山狮山南海', 1541231336, 1, '', ''),
(2, '今天你学习了吗', '304', 1541231400, 1, '', ''),
(5, 'asdf', 'asdf', 1541231536, 2, '', ''),
(6, '303', 'asdf', 1541231236, 1, '', ''),
(7, '302', 'asdfdf', 1541231567, 1, '', ''),
(16, '人才培训所', '303', 1543417042, 1, '', ''),
(18, 'ee', '303', 1543825597, 1, 'school/5c04e8bdf084b.jpeg', 'school/5c04e8bdf0987.jpeg');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_share`
--

CREATE TABLE `cmf_share` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '分享链接id',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `share_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分享时间',
  `dead_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '失效时间, 0为永久有效',
  `code` varchar(64) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '提取码',
  `link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分享链接',
  `uniqid` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分享链接的加密参数',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分享链接名字',
  `qr_path` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '二维码保存路径, 相对于public文件夹',
  `view_count` int(10) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `download_count` int(10) NOT NULL DEFAULT '0' COMMENT '下载次数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='分享文件表';

--
-- 转存表中的数据 `cmf_share`
--

INSERT INTO `cmf_share` (`id`, `user_id`, `share_time`, `dead_time`, `code`, `link`, `uniqid`, `name`, `qr_path`, `view_count`, `download_count`) VALUES
(20, 62, 1547718407, 0, '', 'http://centos3.huangdf.com/#/share?id=1d388ab5cfb1d46a46bb740d48ee4aa1', '1d388ab5cfb1d46a46bb740d48ee4aa1', '牛奶', 'upload/QRshare/1d388ab5cfb1d46a46bb740d48ee4aa1.png', 0, 0),
(3, 53, 1547607091, 0, '', 'http://centos3.huangdf.com/#/share?id=81ea8ae46451dcbce1c864ece20e3673', '81ea8ae46451dcbce1c864ece20e3673', 'tuizheng.mp3', 'upload/QRshare/81ea8ae46451dcbce1c864ece20e3673.png', 5, 0),
(4, 45, 1547607473, 0, '', 'http://centos3.huangdf.com/#/share?id=b843b9493d84341920d07954ad6f9dbe', 'b843b9493d84341920d07954ad6f9dbe', 'gif背景图.gif', 'upload/QRshare/b843b9493d84341920d07954ad6f9dbe.png', 0, 0),
(12, 58, 1547621133, 0, '', 'http://centos3.huangdf.com/#/share?id=264f6a481ce54e07fcdcfa4533b910e1', '264f6a481ce54e07fcdcfa4533b910e1', '454', 'upload/QRshare/264f6a481ce54e07fcdcfa4533b910e1.png', 7, 0),
(13, 58, 1547621231, 0, '', 'http://centos3.huangdf.com/#/share?id=7f7fe1ff7f7615cffeb8efd36bc262bb', '7f7fe1ff7f7615cffeb8efd36bc262bb', 'zppt532.ppt', 'upload/QRshare/7f7fe1ff7f7615cffeb8efd36bc262bb.png', 3, 0),
(15, 58, 1547629220, 0, 're8v', 'http://centos3.huangdf.com/#/share?id=ece2b2d877b64b5cb506ca54ddca9059', 'ece2b2d877b64b5cb506ca54ddca9059', 'wallhaven-19797.jpg', 'upload/QRshare/ece2b2d877b64b5cb506ca54ddca9059.png', 0, 0),
(16, 62, 1547701989, 1548306789, 'j4b9', 'http://centos3.huangdf.com/#/share?id=55ec46e75affdc43ca6c037c14bda4f0', '55ec46e75affdc43ca6c037c14bda4f0', 'PHP面试题.docx', 'upload/QRshare/55ec46e75affdc43ca6c037c14bda4f0.png', 2, 1),
(17, 62, 1547703872, 0, '', 'http://centos3.huangdf.com/#/share?id=a5270010a27fd2c7227d49013c89f7db', 'a5270010a27fd2c7227d49013c89f7db', 'PHP面试题.docx', 'upload/QRshare/a5270010a27fd2c7227d49013c89f7db.png', 1, 0),
(18, 62, 1547704102, 1548308902, 'rxzu', 'http://centos3.huangdf.com/#/share?id=d5cf3bff6ff694de7f45846e1ddf1de5', 'd5cf3bff6ff694de7f45846e1ddf1de5', '牛奶', 'upload/QRshare/d5cf3bff6ff694de7f45846e1ddf1de5.png', 0, 0),
(19, 46, 1547717891, 0, '', 'http://centos3.huangdf.com/#/share?id=aec61612be92b7e9ec72f34400649cf5', 'aec61612be92b7e9ec72f34400649cf5', 'distributions_scientific_linux_256px_540470_easyicon.net.png', 'upload/QRshare/aec61612be92b7e9ec72f34400649cf5.png', 0, 0),
(21, 46, 1547718883, 0, '', 'http://centos3.huangdf.com/#/share?id=18f221ddc6305ef0449134f06687a149', '18f221ddc6305ef0449134f06687a149', '计算机161 班主任工作学生满意度测评表.doc', 'upload/QRshare/18f221ddc6305ef0449134f06687a149.png', 6, 0),
(22, 46, 1547718941, 0, '', 'http://centos3.huangdf.com/#/share?id=62504cb5c3129f73874d1abb150cba47', '62504cb5c3129f73874d1abb150cba47', '计算机161 班主任工作学生满意度测评表.doc', 'upload/QRshare/62504cb5c3129f73874d1abb150cba47.png', 0, 0),
(23, 62, 1547718986, 0, 'yx6v', 'http://centos3.huangdf.com/#/share?id=9496f48a2da144018a6daf3c36576e69', '9496f48a2da144018a6daf3c36576e69', 'PHP面试题.docx', 'upload/QRshare/9496f48a2da144018a6daf3c36576e69.png', 0, 0),
(24, 46, 1547719012, 0, '', 'http://centos3.huangdf.com/#/share?id=270ec08e2a9a26429c377358c777f4c1', '270ec08e2a9a26429c377358c777f4c1', 'sc', 'upload/QRshare/270ec08e2a9a26429c377358c777f4c1.png', 0, 0),
(25, 46, 1547719431, 0, '', 'http://centos3.huangdf.com/#/share?id=c14c07a237e4e90f089c3936e0e28d11', 'c14c07a237e4e90f089c3936e0e28d11', 'sc', 'upload/QRshare/c14c07a237e4e90f089c3936e0e28d11.png', 0, 0),
(26, 46, 1547719856, 0, '', 'http://centos3.huangdf.com/#/share?id=611447d3d3e43ec99d9afa6858e65e2d', '611447d3d3e43ec99d9afa6858e65e2d', 'JM0203.zip', 'upload/QRshare/611447d3d3e43ec99d9afa6858e65e2d.png', 0, 0),
(27, 46, 1547719864, 0, '', 'http://centos3.huangdf.com/#/share?id=ff6a0d75fd5474f7405350c036622a6b', 'ff6a0d75fd5474f7405350c036622a6b', 'sc', 'upload/QRshare/ff6a0d75fd5474f7405350c036622a6b.png', 0, 0),
(28, 46, 1547719869, 0, '', 'http://centos3.huangdf.com/#/share?id=7b97adc51f976e95a2471bb3d1e2823e', '7b97adc51f976e95a2471bb3d1e2823e', 'JM0203.zip', 'upload/QRshare/7b97adc51f976e95a2471bb3d1e2823e.png', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_share_file`
--

CREATE TABLE `cmf_share_file` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `share_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分享链接',
  `file_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件链接'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='分享文件关联表';

--
-- 转存表中的数据 `cmf_share_file`
--

INSERT INTO `cmf_share_file` (`id`, `share_id`, `file_id`) VALUES
(21, 20, 183),
(3, 3, 120),
(4, 4, 121),
(14, 13, 134),
(13, 12, 133),
(16, 15, 141),
(17, 16, 180),
(18, 17, 180),
(19, 18, 183),
(20, 19, 162),
(22, 21, 185),
(23, 22, 185),
(24, 23, 180),
(25, 24, 96),
(26, 25, 96),
(27, 26, 175),
(28, 27, 96),
(29, 28, 175);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_slide`
--

CREATE TABLE `cmf_slide` (
  `id` int(11) NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:显示,0不显示',
  `delete_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '删除时间',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片分类',
  `remark` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '分类备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_slide_item`
--

CREATE TABLE `cmf_slide_item` (
  `id` int(10) UNSIGNED NOT NULL,
  `slide_id` int(11) NOT NULL DEFAULT '0' COMMENT '幻灯片id',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态,1:显示;0:隐藏',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '幻灯片名称',
  `image` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片图片',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '幻灯片链接',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `description` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT '幻灯片描述',
  `content` text CHARACTER SET utf8 COMMENT '幻灯片内容',
  `more` text COMMENT '扩展信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='幻灯片子项表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_tag`
--

CREATE TABLE `cmf_tag` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '标签ID',
  `tag_name` varchar(20) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '标签名',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签拥有者ID'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `cmf_tag`
--

INSERT INTO `cmf_tag` (`id`, `tag_name`, `user_id`) VALUES
(10, 'sdfdsd', 46),
(7, 'aa', 46),
(20, 'aaaass', 46),
(19, 'wz', 46),
(13, '2', 45),
(14, '3', 45),
(15, 'xy', 46),
(18, 'ss', 46),
(24, 'PHP', 62),
(25, '面试题', 62),
(26, '公共', 62),
(27, '菲斯有', 62),
(29, '旅游', 58);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_theme`
--

CREATE TABLE `cmf_theme` (
  `id` int(11) NOT NULL,
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后升级时间',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '模板状态,1:正在使用;0:未使用',
  `is_compiled` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否为已编译模板',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '主题目录名，用于主题的维一标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '主题名称',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '主题版本号',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `author` varchar(20) NOT NULL DEFAULT '' COMMENT '主题作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `lang` varchar(10) NOT NULL DEFAULT '' COMMENT '支持语言',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '主题关键字',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '主题描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cmf_theme`
--

INSERT INTO `cmf_theme` (`id`, `create_time`, `update_time`, `status`, `is_compiled`, `theme`, `name`, `version`, `demo_url`, `thumbnail`, `author`, `author_url`, `lang`, `keywords`, `description`) VALUES
(1, 0, 0, 0, 0, 'simpleboot3', 'simpleboot3', '1.0.2', 'http://demo.thinkcmf.com', '', 'ThinkCMF', 'http://www.thinkcmf.com', 'zh-cn', 'ThinkCMF模板', 'ThinkCMF默认模板');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_theme_file`
--

CREATE TABLE `cmf_theme_file` (
  `id` int(11) NOT NULL,
  `is_public` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否公共的模板文件',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `theme` varchar(20) NOT NULL DEFAULT '' COMMENT '模板名称',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '模板文件名',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作',
  `file` varchar(50) NOT NULL DEFAULT '' COMMENT '模板文件，相对于模板根目录，如Portal/index.html',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '模板文件描述',
  `more` text COMMENT '模板更多配置,用户自己后台设置的',
  `config_more` text COMMENT '模板更多配置,来源模板的配置文件',
  `draft_more` text COMMENT '模板更多配置,用户临时保存的配置'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `cmf_theme_file`
--

INSERT INTO `cmf_theme_file` (`id`, `is_public`, `list_order`, `theme`, `name`, `action`, `file`, `description`, `more`, `config_more`, `draft_more`) VALUES
(1, 0, 10, 'simpleboot3', '文章页', 'portal/Article/index', 'portal/article', '文章页模板文件', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"hot_articles_category_id\":{\"title\":\"Hot Articles\\u5206\\u7c7bID\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', NULL),
(2, 0, 10, 'simpleboot3', '联系我们页', 'portal/Page/index', 'portal/contact', '联系我们页模板文件', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"baidu_map_info_window_text\":{\"title\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57\",\"name\":\"baidu_map_info_window_text\",\"value\":\"ThinkCMF<br\\/><span class=\'\'>\\u5730\\u5740\\uff1a\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def2601\\u53f7<\\/span>\",\"type\":\"text\",\"tip\":\"\\u767e\\u5ea6\\u5730\\u56fe\\u6807\\u6ce8\\u6587\\u5b57,\\u652f\\u6301\\u7b80\\u5355html\\u4ee3\\u7801\",\"rule\":[]},\"company_location\":{\"title\":\"\\u516c\\u53f8\\u5750\\u6807\",\"value\":\"\",\"type\":\"location\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_cn\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\",\"value\":\"\\u4e0a\\u6d77\\u5e02\\u5f90\\u6c47\\u533a\\u659c\\u571f\\u8def0001\\u53f7\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"address_en\":{\"title\":\"\\u516c\\u53f8\\u5730\\u5740\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"NO.0001 Xie Tu Road, Shanghai China\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"email\":{\"title\":\"\\u516c\\u53f8\\u90ae\\u7bb1\",\"value\":\"catman@thinkcmf.com\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_cn\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\",\"value\":\"021 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"phone_en\":{\"title\":\"\\u516c\\u53f8\\u7535\\u8bdd\\uff08\\u82f1\\u6587\\uff09\",\"value\":\"+8621 1000 0001\",\"type\":\"text\",\"tip\":\"\",\"rule\":{\"require\":true}},\"qq\":{\"title\":\"\\u8054\\u7cfbQQ\",\"value\":\"478519726\",\"type\":\"text\",\"tip\":\"\\u591a\\u4e2a QQ\\u4ee5\\u82f1\\u6587\\u9017\\u53f7\\u9694\\u5f00\",\"rule\":{\"require\":true}}}}', NULL),
(3, 0, 5, 'simpleboot3', '首页', 'portal/Index/index', 'portal/index', '首页模板文件', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":{\"top_slide\":{\"title\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"admin\\/Slide\\/index\",\"multi\":false},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"tip\":\"\\u9876\\u90e8\\u5e7b\\u706f\\u7247\",\"rule\":{\"require\":true}}},\"widgets\":{\"features\":{\"title\":\"\\u5feb\\u901f\\u4e86\\u89e3ThinkCMF\",\"display\":\"1\",\"vars\":{\"sub_title\":{\"title\":\"\\u526f\\u6807\\u9898\",\"value\":\"Quickly understand the ThinkCMF\",\"type\":\"text\",\"placeholder\":\"\\u8bf7\\u8f93\\u5165\\u526f\\u6807\\u9898\",\"tip\":\"\",\"rule\":{\"require\":true}},\"features\":{\"title\":\"\\u7279\\u6027\\u4ecb\\u7ecd\",\"value\":[{\"title\":\"MVC\\u5206\\u5c42\\u6a21\\u5f0f\",\"icon\":\"bars\",\"content\":\"\\u4f7f\\u7528MVC\\u5e94\\u7528\\u7a0b\\u5e8f\\u88ab\\u5206\\u6210\\u4e09\\u4e2a\\u6838\\u5fc3\\u90e8\\u4ef6\\uff1a\\u6a21\\u578b\\uff08M\\uff09\\u3001\\u89c6\\u56fe\\uff08V\\uff09\\u3001\\u63a7\\u5236\\u5668\\uff08C\\uff09\\uff0c\\u4ed6\\u4e0d\\u662f\\u4e00\\u4e2a\\u65b0\\u7684\\u6982\\u5ff5\\uff0c\\u53ea\\u662fThinkCMF\\u5c06\\u5176\\u53d1\\u6325\\u5230\\u4e86\\u6781\\u81f4\\u3002\"},{\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"group\",\"content\":\"ThinkCMF\\u5185\\u7f6e\\u4e86\\u7075\\u6d3b\\u7684\\u7528\\u6237\\u7ba1\\u7406\\u65b9\\u5f0f\\uff0c\\u5e76\\u53ef\\u76f4\\u63a5\\u4e0e\\u7b2c\\u4e09\\u65b9\\u7ad9\\u70b9\\u8fdb\\u884c\\u4e92\\u8054\\u4e92\\u901a\\uff0c\\u5982\\u679c\\u4f60\\u613f\\u610f\\u751a\\u81f3\\u53ef\\u4ee5\\u5bf9\\u5355\\u4e2a\\u7528\\u6237\\u6216\\u7fa4\\u4f53\\u7528\\u6237\\u7684\\u884c\\u4e3a\\u8fdb\\u884c\\u8bb0\\u5f55\\u53ca\\u5206\\u4eab\\uff0c\\u4e3a\\u60a8\\u7684\\u8fd0\\u8425\\u51b3\\u7b56\\u63d0\\u4f9b\\u6709\\u6548\\u53c2\\u8003\\u6570\\u636e\\u3002\"},{\"title\":\"\\u4e91\\u7aef\\u90e8\\u7f72\",\"icon\":\"cloud\",\"content\":\"\\u901a\\u8fc7\\u9a71\\u52a8\\u7684\\u65b9\\u5f0f\\u53ef\\u4ee5\\u8f7b\\u677e\\u652f\\u6301\\u4e91\\u5e73\\u53f0\\u7684\\u90e8\\u7f72\\uff0c\\u8ba9\\u4f60\\u7684\\u7f51\\u7ad9\\u65e0\\u7f1d\\u8fc1\\u79fb\\uff0c\\u5185\\u7f6e\\u5df2\\u7ecf\\u652f\\u6301SAE\\u3001BAE\\uff0c\\u6b63\\u5f0f\\u7248\\u5c06\\u5bf9\\u4e91\\u7aef\\u90e8\\u7f72\\u8fdb\\u884c\\u8fdb\\u4e00\\u6b65\\u4f18\\u5316\\u3002\"},{\"title\":\"\\u5b89\\u5168\\u7b56\\u7565\",\"icon\":\"heart\",\"content\":\"\\u63d0\\u4f9b\\u7684\\u7a33\\u5065\\u7684\\u5b89\\u5168\\u7b56\\u7565\\uff0c\\u5305\\u62ec\\u5907\\u4efd\\u6062\\u590d\\uff0c\\u5bb9\\u9519\\uff0c\\u9632\\u6cbb\\u6076\\u610f\\u653b\\u51fb\\u767b\\u9646\\uff0c\\u7f51\\u9875\\u9632\\u7be1\\u6539\\u7b49\\u591a\\u9879\\u5b89\\u5168\\u7ba1\\u7406\\u529f\\u80fd\\uff0c\\u4fdd\\u8bc1\\u7cfb\\u7edf\\u5b89\\u5168\\uff0c\\u53ef\\u9760\\uff0c\\u7a33\\u5b9a\\u7684\\u8fd0\\u884c\\u3002\"},{\"title\":\"\\u5e94\\u7528\\u6a21\\u5757\\u5316\",\"icon\":\"cubes\",\"content\":\"\\u63d0\\u51fa\\u5168\\u65b0\\u7684\\u5e94\\u7528\\u6a21\\u5f0f\\u8fdb\\u884c\\u6269\\u5c55\\uff0c\\u4e0d\\u7ba1\\u662f\\u4f60\\u5f00\\u53d1\\u4e00\\u4e2a\\u5c0f\\u529f\\u80fd\\u8fd8\\u662f\\u4e00\\u4e2a\\u5168\\u65b0\\u7684\\u7ad9\\u70b9\\uff0c\\u5728ThinkCMF\\u4e2d\\u4f60\\u53ea\\u662f\\u589e\\u52a0\\u4e86\\u4e00\\u4e2aAPP\\uff0c\\u6bcf\\u4e2a\\u72ec\\u7acb\\u8fd0\\u884c\\u4e92\\u4e0d\\u5f71\\u54cd\\uff0c\\u4fbf\\u4e8e\\u7075\\u6d3b\\u6269\\u5c55\\u548c\\u4e8c\\u6b21\\u5f00\\u53d1\\u3002\"},{\"title\":\"\\u514d\\u8d39\\u5f00\\u6e90\",\"icon\":\"certificate\",\"content\":\"\\u4ee3\\u7801\\u9075\\u5faaApache2\\u5f00\\u6e90\\u534f\\u8bae\\uff0c\\u514d\\u8d39\\u4f7f\\u7528\\uff0c\\u5bf9\\u5546\\u4e1a\\u7528\\u6237\\u4e5f\\u65e0\\u4efb\\u4f55\\u9650\\u5236\\u3002\"}],\"type\":\"array\",\"item\":{\"title\":{\"title\":\"\\u6807\\u9898\",\"value\":\"\",\"type\":\"text\",\"rule\":{\"require\":true}},\"icon\":{\"title\":\"\\u56fe\\u6807\",\"value\":\"\",\"type\":\"text\"},\"content\":{\"title\":\"\\u63cf\\u8ff0\",\"value\":\"\",\"type\":\"textarea\"}},\"tip\":\"\"}}},\"last_news\":{\"title\":\"\\u6700\\u65b0\\u8d44\\u8baf\",\"display\":\"1\",\"vars\":{\"last_news_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/Category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', NULL),
(4, 0, 10, 'simpleboot3', '文章列表页', 'portal/List/index', 'portal/list', '文章列表模板文件', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"vars\":[],\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', NULL),
(5, 0, 10, 'simpleboot3', '单页面', 'portal/Page/index', 'portal/page', '单页面模板文件', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', '{\"widgets\":{\"hottest_articles\":{\"title\":\"\\u70ed\\u95e8\\u6587\\u7ae0\",\"display\":\"1\",\"vars\":{\"hottest_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}},\"last_articles\":{\"title\":\"\\u6700\\u65b0\\u53d1\\u5e03\",\"display\":\"1\",\"vars\":{\"last_articles_category_id\":{\"title\":\"\\u6587\\u7ae0\\u5206\\u7c7bID\",\"value\":\"\",\"type\":\"text\",\"dataSource\":{\"api\":\"portal\\/category\\/index\",\"multi\":true},\"placeholder\":\"\\u8bf7\\u9009\\u62e9\\u5206\\u7c7b\",\"tip\":\"\",\"rule\":{\"require\":true}}}}}}', NULL),
(6, 0, 10, 'simpleboot3', '搜索页面', 'portal/search/index', 'portal/search', '搜索模板文件', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', '{\"vars\":{\"varName1\":{\"title\":\"\\u70ed\\u95e8\\u641c\\u7d22\",\"value\":\"1\",\"type\":\"text\",\"tip\":\"\\u8fd9\\u662f\\u4e00\\u4e2atext\",\"rule\":{\"require\":true}}}}', NULL),
(7, 1, 0, 'simpleboot3', '模板全局配置', 'public/Config', 'public/config', '模板全局配置文件', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', '{\"vars\":{\"enable_mobile\":{\"title\":\"\\u624b\\u673a\\u6ce8\\u518c\",\"value\":1,\"type\":\"select\",\"options\":{\"1\":\"\\u5f00\\u542f\",\"0\":\"\\u5173\\u95ed\"},\"tip\":\"\"}}}', NULL),
(8, 1, 1, 'simpleboot3', '导航条', 'public/Nav', 'public/nav', '导航条模板文件', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', '{\"vars\":{\"company_name\":{\"title\":\"\\u516c\\u53f8\\u540d\\u79f0\",\"name\":\"company_name\",\"value\":\"ThinkCMF\",\"type\":\"text\",\"tip\":\"\",\"rule\":[]}}}', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_third_party_user`
--

CREATE TABLE `cmf_third_party_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方惟一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='第三方用户表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user`
--

CREATE TABLE `cmf_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_type` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户类型;1:admin;2:普通用户',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别;0:保密,1:男,2:女',
  `birthday` int(11) NOT NULL DEFAULT '631152000' COMMENT '生日',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `coin` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '金币',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `user_status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户状态;0:禁用,1:正常,2:未验证',
  `user_login` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码;cmf_password加密',
  `user_nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '用户登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网址',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT '个性签名',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '中国手机不带国家代码，国际手机号格式为：国家代码-手机号',
  `id_card` varchar(20) NOT NULL DEFAULT '' COMMENT '用户身份证号码',
  `more` text COMMENT '扩展属性'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

--
-- 转存表中的数据 `cmf_user`
--

INSERT INTO `cmf_user` (`id`, `user_type`, `sex`, `birthday`, `last_login_time`, `score`, `coin`, `balance`, `create_time`, `user_status`, `user_login`, `user_pass`, `user_nickname`, `user_email`, `user_url`, `avatar`, `signature`, `last_login_ip`, `user_activation_key`, `mobile`, `id_card`, `more`) VALUES
(1, 1, 0, 652546800, 1547711392, 5, 5, '0.00', 1541231336, 1, 'admin', '###358c95ae4cf3a099719c59eafb9fda92', 'admin', '763992263@qq.com', '', 'avatar/20181128/52315d96e3bfbc87db0af395b542a5b0.jpg', '', '172.17.144.18', '', '', '', NULL),
(2, 1, 0, 631152000, 0, 0, 0, '0.00', 1541231336, 1, '王泽', '###6f004ddff663c5f4669702c24e88fd02', '王泽', 'wz@qq.com', '', '', '', '', '', '15907689000', '445121199704094274', NULL),
(12, 2, 0, 631152000, 1542788054, 4, 4, '0.00', 1541574355, 1, '1234', '###358c95ae4cf3a099719c59eafb9fda92', '1234', '1@qq.com', '', 'avatar/20181121/65b8efe0fa421b2ef330fc0bb65d4f06.jpg', '', '0.0.0.0', '', '', '', NULL),
(13, 2, 0, 631152000, 1547692217, 0, 0, '0.00', 1541730630, 1, '12345', '###358c95ae4cf3a099719c59eafb9fda92', '12345', '12@qq.com', '', '', '', '172.18.99.41', '', '', '', NULL),
(14, 1, 0, 631152000, 1547717572, 2, 2, '0.00', 1541731289, 1, '123', '###358c95ae4cf3a099719c59eafb9fda92', '123', '123@qq.com', '', '', '', '172.18.99.240', '', '', '', NULL),
(15, 1, 0, 631152000, 1543063467, 0, 0, '0.00', 1542776400, 1, '111@qq.com', '###358c95ae4cf3a099719c59eafb9fda92', 'asdf', '111@qq.com', '', '', '', '0.0.0.0', '', '15907689954', '445121199704094274', NULL),
(16, 1, 0, 631152000, 1543213673, 0, 0, '0.00', 1542814250, 1, '303@qq.com', '###358c95ae4cf3a099719c59eafb9fda92', 'asdf', '303@qq.com', '', '', '', '0.0.0.0', '', '15907689955', '445121199704094274', NULL),
(17, 2, 0, 631152000, 0, 0, 0, '0.00', 1542814287, 1, '1233', '###358c95ae4cf3a099719c59eafb9fda92', '1233', '11@qq.com', '', '', '', '', '', '', '', NULL),
(18, 2, 0, 631152000, 0, 0, 0, '0.00', 1542814301, 1, '12333', '###358c95ae4cf3a099719c59eafb9fda92', '12333', '1122@qq.com', '', '', '', '', '', '', '', NULL),
(20, 2, 0, 631152000, 0, 0, 0, '0.00', 1543195828, 1, '555', '###358c95ae4cf3a099719c59eafb9fda92', '555', '555@qq.com', '', '', '', '', '', '', '', NULL),
(21, 1, 0, 631152000, 0, 0, 0, '0.00', 1543195861, 1, '302@qq.com', '###358c95ae4cf3a099719c59eafb9fda92', 'asdfdf', '302@qq.com', '', '', '', '', '', '15907689950', '445121199704094274', NULL),
(22, 2, 0, 631152000, 0, 0, 0, '0.00', 1543201567, 1, '666', '###358c95ae4cf3a099719c59eafb9fda92', '666', '666@qq.com', '', '', '', '', '', '', '', NULL),
(31, 1, 0, 631152000, 1547606410, 1, 1, '0.00', 1543417042, 1, 'seven@qq.com', '###358c95ae4cf3a099719c59eafb9fda92', 'seven', 'seven@qq.com', '', '', '', '172.17.147.246', '', '15907689940', '445121199704094274', NULL),
(32, 2, 0, 631152000, 0, 0, 0, '0.00', 1543482266, 1, '777', '###358c95ae4cf3a099719c59eafb9fda92', '777', '777@qq.com', '', '', '', '', '', '', '', NULL),
(35, 2, 0, 631152000, 1543500987, 0, 0, '0.00', 1543496731, 1, '3', '###358c95ae4cf3a099719c59eafb9fda92', '3', '3@qq.com', '', '', '', '0.0.0.0', '', '', '', NULL),
(36, 2, 0, 631152000, 0, 0, 0, '0.00', 1543496737, 1, '4', '###358c95ae4cf3a099719c59eafb9fda92', '4', '4@qq.com', '', '', '', '', '', '', '', NULL),
(41, 1, 0, 631152000, 0, 0, 0, '0.00', 1543825597, 1, 'ee@qq.com', '###358c95ae4cf3a099719c59eafb9fda92', 'ee', 'ee@qq.com', '', '', '', '', '', '15907689932', '445121199704094274', NULL),
(42, 1, 0, 631152000, 1543828368, 0, 0, '0.00', 1543828333, 1, '7', '###80f6d11579523f7697c4e9f16367258a', 'huang7', '7@7.com', '', '', '', '172.18.161.80', '', '', '', NULL),
(43, 2, 0, 631152000, 1547022369, 0, 0, '0.00', 1544408784, 0, '2016060501354', '###358c95ae4cf3a099719c59eafb9fda92', '钟俊艺', '122386977@qq.com', '', '', '', '172.18.215.4', '', '', '', NULL),
(44, 2, 0, 631152000, 1547621097, 0, 0, '0.00', 1545621527, 1, '2016060501313', '###358c95ae4cf3a099719c59eafb9fda92', '456', '456@qq.com', '', '', '', '172.17.144.18', '', '', '', NULL),
(45, 1, 0, 631152000, 1547626715, 0, 0, '0.00', 1545621568, 1, '2016063111', '###358c95ae4cf3a099719c59eafb9fda92', '789', '789@qq.com', '', '', '', '172.18.215.6', '', '', '', NULL),
(46, 1, 1, 1548432000, 1547719194, 0, 0, '0.00', 1545787353, 1, '201606666', '###358c95ae4cf3a099719c59eafb9fda92', '201606666', '7@qq.com', '', '', '', '172.18.99.41', '', '', '', NULL),
(47, 2, 0, 631152000, 1547428045, 0, 0, '0.00', 1545809936, 1, '123321', '###358c95ae4cf3a099719c59eafb9fda92', '123321', '123321@qq.com', '', '', '', '172.17.147.246', '', '', '', NULL),
(48, 2, 0, 631152000, 0, 0, 0, '0.00', 1546011905, 1, '2016060501111', '###ef3d313b9e8387224dbc51e7036b3666', '我是谁', 'ddd36@qq.com', '', '', '', '', '', '', '', NULL),
(49, 2, 0, 631152000, 0, 0, 0, '0.00', 1546346272, 1, '20160666665', '###358c95ae4cf3a099719c59eafb9fda92', 'hxy', '911074623@qq.com', '', '', '', '', '', '', '', NULL),
(50, 2, 0, 631152000, 1546924785, 0, 0, '0.00', 1546346332, 1, '2016065544', '###358c95ae4cf3a099719c59eafb9fda92', 'hxy', '2@qq.com', '', '', '', '172.18.99.41', '', '', '', NULL),
(51, 2, 0, 631152000, 0, 0, 0, '0.00', 1546390963, 1, '2016060501366', '###358c95ae4cf3a099719c59eafb9fda92', '谭大大', '1784104114@qq.com', '', '', '', '', '', '', '', NULL),
(52, 2, 0, 631152000, 0, 0, 0, '0.00', 1546392958, 1, '2016060501302', '###358c95ae4cf3a099719c59eafb9fda92', '陈承基', '1461132821@qq.com', '', '', '', '', '', '', '', NULL),
(53, 2, 0, 0, 1547716741, 0, 0, '0.00', 1546998413, 1, '1235235', '###358c95ae4cf3a099719c59eafb9fda92', '1235235', '147@qq.com', '', '', '', '172.17.56.238', '', '', '', NULL),
(54, 2, 0, 631152000, 1547715988, 0, 0, '0.00', 1546998454, 1, '2016060501360', '###65230426b50c91babd41d0e813fbdfe3', 'haha', '123456@qq.com', '', '', '', '172.17.56.11', '', '', '', NULL),
(56, 2, 0, 631152000, 0, 0, 0, '0.00', 1547022871, 1, '2016060501301', '###5abcc0c78cd8d38594bb2ec68b17ea24', '钟俊艺', '1223869@qq.com', '', '', '', '', '', '', '', NULL),
(57, 2, 0, 631152000, 0, 0, 0, '0.00', 1547128544, 1, '123456789', '###929789cf4db41998c058198e4b9e4cc3', '123456', '123456@163.com', '', '', '', '', '', '', '', NULL),
(58, 2, 0, 631152000, 1547712240, 0, 0, '0.00', 1547128878, 1, '20000', '###929789cf4db41998c058198e4b9e4cc3', 'asd', '147258@qq.com', '', '', '', '172.17.144.18', '', '', '', NULL),
(59, 2, 0, 631152000, 1547455799, 0, 0, '0.00', 1547427432, 1, '2016060501300', '###f75f061864072e27de836a7917ded84e', '小李飞刀', '999999@qq.com', '', '', '', '172.17.56.11', '', '', '', NULL),
(60, 1, 0, 631152000, 1547539840, 0, 0, '0.00', 1547427843, 1, '2016060501311', '###358c95ae4cf3a099719c59eafb9fda92', '冯宝', '1329082038@qq.com', '', '', '', '172.17.147.246', '', '', '', NULL),
(61, 2, 0, 631152000, 0, 0, 0, '0.00', 1547624971, 1, '2016060501306', '###358c95ae4cf3a099719c59eafb9fda92', '小乖乖', '1223869777@qq.com', '', '', '', '', '', '', '', NULL),
(62, 2, 0, 631152000, 1547696911, 0, 0, '0.00', 1547694247, 1, '2016060501340', '###358c95ae4cf3a099719c59eafb9fda92', '王泽', '11ze@qq.com', '', '', '', '172.18.99.41', '', '', '', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_action`
--

CREATE TABLE `cmf_user_action` (
  `id` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int(11) NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作表';

--
-- 转存表中的数据 `cmf_user_action`
--

INSERT INTO `cmf_user_action` (`id`, `score`, `coin`, `reward_number`, `cycle_type`, `cycle_time`, `name`, `action`, `app`, `url`) VALUES
(1, 1, 1, 1, 2, 1, '用户登录', 'login', 'user', '');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_action_log`
--

CREATE TABLE `cmf_user_action_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问记录表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_balance_log`
--

CREATE TABLE `cmf_user_balance_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改后余额',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户余额变更日志表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_favorite`
--

CREATE TABLE `cmf_user_favorite` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，JSON格式',
  `description` text COMMENT '收藏内容的描述',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int(10) UNSIGNED DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int(10) UNSIGNED DEFAULT '0' COMMENT '收藏时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_like`
--

CREATE TABLE `cmf_user_like` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户 id',
  `object_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '内容原来的主键id',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '内容以前所在表,不带前缀',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容的原文地址，不带域名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `description` text COMMENT '内容的描述'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户点赞表';

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_login_attempt`
--

CREATE TABLE `cmf_user_login_attempt` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `login_attempts` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户登录尝试表' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_score_log`
--

CREATE TABLE `cmf_user_score_log` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户操作积分等奖励日志表';

--
-- 转存表中的数据 `cmf_user_score_log`
--

INSERT INTO `cmf_user_score_log` (`id`, `user_id`, `create_time`, `action`, `score`, `coin`) VALUES
(1, 1, 1541233798, 'login', 1, 1),
(2, 7, 1541573871, 'login', 1, 1),
(3, 1, 1541727975, 'login', 1, 1),
(4, 12, 1541861272, 'login', 1, 1),
(5, 12, 1542592163, 'login', 1, 1),
(6, 12, 1542618228, 'login', 1, 1),
(7, 12, 1542787281, 'login', 1, 1),
(8, 1, 1543374719, 'login', 1, 1),
(9, 1, 1547128622, 'login', 1, 1),
(10, 14, 1547302374, 'login', 1, 1),
(11, 31, 1547601271, 'login', 1, 1),
(12, 14, 1547622252, 'login', 1, 1),
(13, 1, 1547705215, 'login', 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `cmf_user_token`
--

CREATE TABLE `cmf_user_token` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户客户端登录 token 表';

--
-- 转存表中的数据 `cmf_user_token`
--

INSERT INTO `cmf_user_token` (`id`, `user_id`, `expire_time`, `create_time`, `token`, `device_type`) VALUES
(1, 1, 1560923790, 1545371790, '9b2545b2485f53cc991faadbec4e257c95f9bdabdfe6eea930a5af194955aab2', 'web'),
(2, 7, 1557125871, 1541573871, '5199fd81fbb2aae81f83983045348b0a5199fd81fbb2aae81f83983045348b0a', 'web'),
(3, 12, 1558270014, 1542718014, 'e3bd2a0bf005b2617e17c304791e3764e3bd2a0bf005b2617e17c304791e3764', 'web'),
(4, 13, 1563244217, 1547692217, '', 'web'),
(5, 14, 1563269572, 1547717572, '411bf5b6c5eff4c66969fc88844be88b375a3614753de9d47ddeb5cbe17643d9', 'web'),
(6, 15, 1558615467, 1543063467, '3f4376f035c8573663993bb393179fac3f4376f035c8573663993bb393179fac', 'web'),
(7, 16, 1558615615, 1543063615, '9b7e7e986d1170a3a3f66de0894975039b7e7e986d1170a3a3f66de089497503', 'web'),
(8, 31, 1563152790, 1547600790, '913584957513db0ea92e4186b989a48206cf798bacabc6bc3605d7e094eeca92', 'web'),
(9, 35, 1559052987, 1543500987, 'ab1dada288ffc80d32834d00fd96f5a6ab1dada288ffc80d32834d00fd96f5a6', 'web'),
(10, 42, 1559380368, 1543828368, 'c601e6697b3f423dd110ca3b97964fcacae2342d7eb09e032511e5bab469a336', 'web'),
(11, 43, 1562574370, 1547022370, '', 'web'),
(12, 44, 1563173097, 1547621097, '0ecedf1bc10ce9e4178a3e01316265ed9cefe2e3286c4fc82fab03626a20eb4d', 'web'),
(13, 45, 1563178715, 1547626715, 'c1b54d712d3ee919bd5d742410d4116ce111cb3303474c2155165dd67e0b2ef3', 'web'),
(14, 46, 1563271194, 1547719194, 'a898808499f3990c74acfffebafe66a48c3ef7acdbb12ffd420391106a3f88ca', 'web'),
(15, 47, 1562980045, 1547428045, 'babdf2bc415519392558e95db2a58d23e70071e959a14d7f747dffdc1da85e6d', 'web'),
(16, 50, 1562476785, 1546924785, 'd0f8c3a0c980c500a2cbf730575890c203bc2385cf2b9efdc295fce70047b92b', 'web'),
(17, 54, 1563267988, 1547715988, 'c13542d71cf9008fbe5d108e4b642c37711324701501da42c7589772ecccd3c5', 'web'),
(18, 53, 1563268741, 1547716741, '55dccbfa52ae53383e8fa3d8c83c2a854d0e9537d8d9efc9863da438ce18c2b4', 'web'),
(19, 58, 1563264240, 1547712240, '06cad2321f6910eddff5ebd03f484453911e3602d8999940ef5cf7a4d4f0780f', 'web'),
(20, 60, 1563091840, 1547539840, 'edee43190a926916318246164b8bf10f02b839422cbc6def4f875d5d91db0147', 'web'),
(21, 59, 1563007799, 1547455799, '65485531eb666155f5429a6ea596133990d233530aea307947d8d9c6f56d0982', 'web'),
(22, 62, 1563248911, 1547696911, 'fc38d82e0a274e623505eebb151973c92b0c4033777133f27d761188c098b5c6', 'web');

-- --------------------------------------------------------

--
-- 表的结构 `cmf_verification_code`
--

CREATE TABLE `cmf_verification_code` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '表id',
  `count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '手机号或者邮箱'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='手机邮箱数字验证码表';

--
-- 转存表中的数据 `cmf_verification_code`
--

INSERT INTO `cmf_verification_code` (`id`, `count`, `send_time`, `expire_time`, `code`, `account`) VALUES
(1, 1, 1547539290, 1547541090, '641884', '911074625@qq.com'),
(2, 1, 1541923184, 1541924984, '367929', '763992263@qq.com'),
(3, 1, 1547537573, 1547539373, '345926', '9292@wqd.asd'),
(4, 1, 1547537920, 1547539720, '199838', 'dasds@dsad.fsads'),
(5, 1, 1547538116, 1547539916, '742695', 'asdas2@dsds.das'),
(6, 1, 1547538360, 1547540160, '918903', 'dsa@asd.dasd'),
(7, 1, 1547538436, 1547540236, '171169', 'asds@asdasd.sadas'),
(8, 1, 1547538488, 1547540288, '408670', 'asdasd@asdasd.dfds'),
(9, 2, 1547538644, 1547540444, '487225', 'asds@asdas.asdfas'),
(10, 1, 1547539360, 1547541160, '333893', 'asds@sdwd.das'),
(11, 1, 1547600911, 1547602711, '952345', '122386977@qq.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cmf_admin_menu`
--
ALTER TABLE `cmf_admin_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `controller` (`controller`);

--
-- Indexes for table `cmf_asset`
--
ALTER TABLE `cmf_asset`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_auth_access`
--
ALTER TABLE `cmf_auth_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `rule_name` (`rule_name`) USING BTREE;

--
-- Indexes for table `cmf_auth_rule`
--
ALTER TABLE `cmf_auth_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`) USING BTREE,
  ADD KEY `module` (`app`,`status`,`type`);

--
-- Indexes for table `cmf_comment`
--
ALTER TABLE `cmf_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `table_id_status` (`table_name`,`object_id`,`status`),
  ADD KEY `object_id` (`object_id`) USING BTREE,
  ADD KEY `status` (`status`) USING BTREE,
  ADD KEY `parent_id` (`parent_id`) USING BTREE,
  ADD KEY `create_time` (`create_time`) USING BTREE;

--
-- Indexes for table `cmf_dir_file`
--
ALTER TABLE `cmf_dir_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_file_recycle`
--
ALTER TABLE `cmf_file_recycle`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `file_id` (`file_id`);

--
-- Indexes for table `cmf_file_tag`
--
ALTER TABLE `cmf_file_tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_hook`
--
ALTER TABLE `cmf_hook`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_hook_plugin`
--
ALTER TABLE `cmf_hook_plugin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_link`
--
ALTER TABLE `cmf_link`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `cmf_nav`
--
ALTER TABLE `cmf_nav`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_nav_menu`
--
ALTER TABLE `cmf_nav_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_option`
--
ALTER TABLE `cmf_option`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `option_name` (`option_name`);

--
-- Indexes for table `cmf_plugin`
--
ALTER TABLE `cmf_plugin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_portal_category`
--
ALTER TABLE `cmf_portal_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_portal_category_post`
--
ALTER TABLE `cmf_portal_category_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `term_taxonomy_id` (`category_id`);

--
-- Indexes for table `cmf_portal_post`
--
ALTER TABLE `cmf_portal_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`create_time`,`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `create_time` (`create_time`) USING BTREE;

--
-- Indexes for table `cmf_portal_tag`
--
ALTER TABLE `cmf_portal_tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_portal_tag_post`
--
ALTER TABLE `cmf_portal_tag_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `cmf_recycle_bin`
--
ALTER TABLE `cmf_recycle_bin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_role`
--
ALTER TABLE `cmf_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `cmf_role_user`
--
ALTER TABLE `cmf_role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cmf_route`
--
ALTER TABLE `cmf_route`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_school`
--
ALTER TABLE `cmf_school`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_share`
--
ALTER TABLE `cmf_share`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_share_file`
--
ALTER TABLE `cmf_share_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_slide`
--
ALTER TABLE `cmf_slide`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_slide_item`
--
ALTER TABLE `cmf_slide_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slide_id` (`slide_id`);

--
-- Indexes for table `cmf_tag`
--
ALTER TABLE `cmf_tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_theme`
--
ALTER TABLE `cmf_theme`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_theme_file`
--
ALTER TABLE `cmf_theme_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_third_party_user`
--
ALTER TABLE `cmf_third_party_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_user`
--
ALTER TABLE `cmf_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_login` (`user_login`),
  ADD KEY `user_nickname` (`user_nickname`);

--
-- Indexes for table `cmf_user_action`
--
ALTER TABLE `cmf_user_action`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_user_action_log`
--
ALTER TABLE `cmf_user_action_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_object_action` (`user_id`,`object`,`action`),
  ADD KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`);

--
-- Indexes for table `cmf_user_balance_log`
--
ALTER TABLE `cmf_user_balance_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_user_favorite`
--
ALTER TABLE `cmf_user_favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`user_id`);

--
-- Indexes for table `cmf_user_like`
--
ALTER TABLE `cmf_user_like`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`user_id`);

--
-- Indexes for table `cmf_user_login_attempt`
--
ALTER TABLE `cmf_user_login_attempt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_user_score_log`
--
ALTER TABLE `cmf_user_score_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_user_token`
--
ALTER TABLE `cmf_user_token`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cmf_verification_code`
--
ALTER TABLE `cmf_verification_code`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `cmf_admin_menu`
--
ALTER TABLE `cmf_admin_menu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- 使用表AUTO_INCREMENT `cmf_asset`
--
ALTER TABLE `cmf_asset`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- 使用表AUTO_INCREMENT `cmf_auth_access`
--
ALTER TABLE `cmf_auth_access`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- 使用表AUTO_INCREMENT `cmf_auth_rule`
--
ALTER TABLE `cmf_auth_rule`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键', AUTO_INCREMENT=175;

--
-- 使用表AUTO_INCREMENT `cmf_comment`
--
ALTER TABLE `cmf_comment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_dir_file`
--
ALTER TABLE `cmf_dir_file`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- 使用表AUTO_INCREMENT `cmf_file_recycle`
--
ALTER TABLE `cmf_file_recycle`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- 使用表AUTO_INCREMENT `cmf_file_tag`
--
ALTER TABLE `cmf_file_tag`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- 使用表AUTO_INCREMENT `cmf_hook`
--
ALTER TABLE `cmf_hook`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- 使用表AUTO_INCREMENT `cmf_hook_plugin`
--
ALTER TABLE `cmf_hook_plugin`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `cmf_link`
--
ALTER TABLE `cmf_link`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `cmf_nav`
--
ALTER TABLE `cmf_nav`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `cmf_nav_menu`
--
ALTER TABLE `cmf_nav_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `cmf_option`
--
ALTER TABLE `cmf_option`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `cmf_plugin`
--
ALTER TABLE `cmf_plugin`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id', AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `cmf_portal_category`
--
ALTER TABLE `cmf_portal_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id';

--
-- 使用表AUTO_INCREMENT `cmf_portal_category_post`
--
ALTER TABLE `cmf_portal_category_post`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_portal_post`
--
ALTER TABLE `cmf_portal_post`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_portal_tag`
--
ALTER TABLE `cmf_portal_tag`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id';

--
-- 使用表AUTO_INCREMENT `cmf_portal_tag_post`
--
ALTER TABLE `cmf_portal_tag_post`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_recycle_bin`
--
ALTER TABLE `cmf_recycle_bin`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_role`
--
ALTER TABLE `cmf_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `cmf_role_user`
--
ALTER TABLE `cmf_role_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- 使用表AUTO_INCREMENT `cmf_route`
--
ALTER TABLE `cmf_route`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id';

--
-- 使用表AUTO_INCREMENT `cmf_school`
--
ALTER TABLE `cmf_school`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '学校ID', AUTO_INCREMENT=19;

--
-- 使用表AUTO_INCREMENT `cmf_share`
--
ALTER TABLE `cmf_share`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分享链接id', AUTO_INCREMENT=29;

--
-- 使用表AUTO_INCREMENT `cmf_share_file`
--
ALTER TABLE `cmf_share_file`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- 使用表AUTO_INCREMENT `cmf_slide`
--
ALTER TABLE `cmf_slide`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_slide_item`
--
ALTER TABLE `cmf_slide_item`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_tag`
--
ALTER TABLE `cmf_tag`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签ID', AUTO_INCREMENT=30;

--
-- 使用表AUTO_INCREMENT `cmf_theme`
--
ALTER TABLE `cmf_theme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `cmf_theme_file`
--
ALTER TABLE `cmf_theme_file`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `cmf_third_party_user`
--
ALTER TABLE `cmf_third_party_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_user`
--
ALTER TABLE `cmf_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- 使用表AUTO_INCREMENT `cmf_user_action`
--
ALTER TABLE `cmf_user_action`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `cmf_user_action_log`
--
ALTER TABLE `cmf_user_action_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_user_balance_log`
--
ALTER TABLE `cmf_user_balance_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_user_favorite`
--
ALTER TABLE `cmf_user_favorite`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_user_like`
--
ALTER TABLE `cmf_user_like`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_user_login_attempt`
--
ALTER TABLE `cmf_user_login_attempt`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `cmf_user_score_log`
--
ALTER TABLE `cmf_user_score_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `cmf_user_token`
--
ALTER TABLE `cmf_user_token`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- 使用表AUTO_INCREMENT `cmf_verification_code`
--
ALTER TABLE `cmf_verification_code`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '表id', AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
