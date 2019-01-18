<?php

namespace api\file\controller;

use cmf\controller\RestUserBaseController;
use think\Db;
use DateTime;

class SignatureController extends RestUserBaseController
{

    protected function gmt_iso8601($time) {
        $dtStr = date("c", $time);
        $mydatetime = new DateTime($dtStr);
        $expiration = $mydatetime->format(DateTime::ISO8601);
        $pos = strpos($expiration, '+');
        $expiration = substr($expiration, 0, $pos);
        return $expiration."Z";
    }

    /**
     * 获取oss上传需要的验证信息
     * @return code: 1:已存在 0:不存在 msg: 提示信息 data: 验证信息
     */
    public function get()
    {
        $id= '';          // 请填写您的AccessKeyId。
        $key= '';     // 请填写您的AccessKeySecret。
        // $host的格式为 bucketname.endpoint，请替换为您的真实信息。
        $host = 'http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com/';  
        // $callbackUrl为上传回调服务器的URL，请将下面的IP和Port配置为您自己的真实URL信息。
        $userId = $this->getUserId();
        $dir = $userId . '/';          // 用户上传文件时指定的前缀。
        
        $now = time();
        $expire = 30;  //设置该policy超时时间是10s. 即这个policy过了这个有效时间，将不能访问。
        $end = $now + $expire;
        $expiration = $this->gmt_iso8601($end);


        //最大文件大小.用户可以自己设置
        $condition = array(0=>'content-length-range', 1=>0, 2=>1048576000);
        $conditions[] = $condition; 

        // 表示用户上传的数据，必须是以$dir开始，不然上传会失败，这一步不是必须项，只是为了安全起见，防止用户通过policy上传到别人的目录。
        $start = array(0=>'starts-with', 1=>'$key', 2=>$dir);
        $conditions[] = $start; 

        $arr = array('expiration'=>$expiration,'conditions'=>$conditions);
        $policy = json_encode($arr);
        $base64_policy = base64_encode($policy);
        $string_to_sign = $base64_policy;
        $signature = base64_encode(hash_hmac('sha1', $string_to_sign, $key, true));

        $response = array();
        $response['accessid'] = $id;
        $response['key'] = $key;
        $response['host'] = $host;
        $response['policy'] = $base64_policy;
        $response['signature'] = $signature;
        $response['expire'] = $end;
        $response['dir'] = $dir;  // 这个参数是设置用户上传文件时指定的前缀。
        $this->success('获取签名成功!', $response);
    }


    /**
     * 根据文件的md5和sha1值判断是否已经上传过
     * @param  string file_md5   文件的md5值
     * @param  string file_sha1  文件的sha1值  暂时不传
     * @return code: 1:已存在 0:不存在 msg: 提示信息
     */
    public function file_exist()
    {
        $file_md5  = $this->request->param('file_md5');
        //$sha1 = $this->request->param('file_sha1');

        $findFile = Db::name("asset")
            ->where('file_md5', $file_md5)
            //->where('file_sha1', $fileSha1)
            ->find();

        if (!empty($findFile)) {
            $this->success('已存在');
        } else {
            $this->error('不存在');
        }
    }

}