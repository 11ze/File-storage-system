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
return [
    'customer_login_title' => [
        'title' => '后台标题文字',
        'type'  => 'text',
        'value' => 'ThinkCMF',
        'tip'   => '用于后台登录也的title显示'
    ],
    'customer_login_title_color' => [
        'title' => '标题颜色',
        'type'  => 'color',
        'value' => '#FFFFFF',
        'tip'   => '默认白色，建议在接近背景的情况下进行调整'
    ],
    'customer_login_copyright' => [
        'title' => '后台版权文字',
        'type'  => 'textarea',
        'value' => 'powered by ThinkCMF',
        'tip'   => '用于后台版权文字显示，支持HTML'
    ],
    'customer_login_type' => [
        'title' => '背景类型',
        'type'  => 'select',
		'options' => [
					'color' => '纯色',
					'image' => '图片'
					],
        'value' => 'image',
        'tip'   => '选择您想要的背景类型'
    ],
    'customer_login_bg_color' => [
        'title' => '背景颜色',
        'type'  => 'color',
        'value' => '#585858',
        'tip'   => '默认深灰色'
    ],
    'customer_login_bg_image' => [
        'title' => '背景图片URL',
        'type'  => 'image',
        'value' => '',
        'tip'   => '作为登录页的背景图片'
    ],
    'customer_login_bg_style' => [
        'title' => '背景风格',
        'type'  => 'select',
        'options' => [
            'background-repeat: no-repeat; background-position: center;' => '居中',
            'background-size: cover; background-repeat: no-repeat;' => '填充',
            'background-size: 100% 100%; background-repeat: no-repeat;' => '拉伸',
            'background-position: center;' => '平铺'],
		'value' => 'background-size: 100% 100%; background-repeat: no-repeat;',
        'tip'   => '背景展示样式'
    ]
];
					