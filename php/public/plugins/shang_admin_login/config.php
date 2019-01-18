<?php

return [
    'login_title'     => [// 在后台插件配置表单中的键名 ,会是config[text]
        'title' => '系统名称', // 表单的label标题
        'type'  => 'text',// 表单的类型：text,password,textarea,checkbox,radio,select等
        'value' => '网站后台管理系统',// 表单的默认值
        'tip'   => '' //表单的帮助提示
    ],
    'login_en' => [// 在后台插件配置表单中的键名 ,会是config[password]
        'title' => '英文名称',
        'type'  => 'text',
        'value' => 'Management System',
        'tip'   => ''
    ],
    'login_copyright' => [
        'title' => '版权信息',
        'type'  => 'textarea',
        'value' => '技术支持：推尚网络',
        'tip'   => ''
    ]
];
					