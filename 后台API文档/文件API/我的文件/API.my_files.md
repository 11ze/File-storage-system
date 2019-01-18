## 查看我的文件夹

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/files/my_files

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|dir_id|true|int|文件夹ID, 0代表根目录|
|keyword|false|string|按关键字模糊查找文件名|
|order|false|string|排序 filename:文件名 time:时间 size:大小|
|tagFind|false|string|按标签模糊查找符合的文件|
备注: 如果加了关键字或标签查询, 返回的结果将不包含文件夹

 **返回示例**

``` 
{
    "code": 1,
    "msg": "我的所有文件",
    "data": [
        {
            "id": 182,
            "user_id": 62,
            "file_size": 0,
            "create_time": 1547703822,
            "download_times": 0,
            "filename": "面包",
            "oss_host": "",
            "oss_file": "",
            "suffix": "",
            "type": "/"
        }
    ]
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|文件列表|

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