## 获取用户所有已通过审核的公共文件

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/public/me

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|keyword|false|string|按文件名搜索文件|

 **返回示例**

``` 
{
    "code": 1,
    "msg": "用户通过审核的公共文件列表",
    "data": [
        {
            "id": 181,
            "user_id": 62,
            "file_size": 127648,
            "create_time": 1547696943,
            "download_times": 0,
            "filename": "cowboy.sql",
            "oss_host": "http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com",
            "oss_file": "62/cowboy.sql",
            "suffix": "sql",
            "type": "其他"
        }
    ]
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|返回数据, 用户已通过审核公共文件的集合|

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