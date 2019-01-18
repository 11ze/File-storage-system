## 查看分享链接里面的文件夹, 返回文件夹中的文件

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/read

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|dir_id|true|int|分享链接里的文件夹ID|


 **返回示例**

``` 
{
    "code": 1,
    "msg": "操作成功",
    "data": [
        {
            "id": 184,
            "user_id": 62,
            "file_size": 0,
            "create_time": 1547704003,
            "download_times": 0,
            "filename": "分享",
            "oss_host": "",
            "oss_file": "",
            "suffix": "",
            "type": "/"
        },
    ]
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|返回数据|

##### 返回字段 "data" 子项

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|id|int|文件ID|
|user_id|int|上传者ID|
|file_size|string|文件大小|
|create_time|int|上传时间|
|download_times|int|下载次数|
|filename|string|文件名|
|oss_host|string|oss存储服务器host|
|oss_file|string|oss上的存储路径|
|suffix|string|文件后缀名|
|type|string|文件类型|