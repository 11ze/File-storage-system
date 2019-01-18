<?php

namespace api\file\validate;

use think\Validate;

class FileValidate extends Validate
{
    protected $rule = [
        'filename'  =>  'require',
	    'file_size' =>  'require',
	    'status'    =>  'require',
        'dir_id'    =>  'require',
    ];
    protected $message = [
        'filename.require'   =>  '文件名不能为空',
	    'file_size.require'  =>  '文件大小不能为空',
	    'status.require'     =>  '文件公私有不能为空',
        'dir_id'             =>  '当前目录不能为空',
    ];

    protected $scene = [
        'upload'  => [ 'filename', 'file_size', 'status', 'dir_id'],
    ];
}