## 获取用户所属学校的公共文件

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/public/index

需要header['XX-Token']

#### 参数

字段|必选|类型|说明|
|----|----|----|----|
|keyword|false|string|按关键字模糊查找文件名|
|order|false|string|排序 filename:文件名 time:时间 size:大小|
|tagFind|false|string|按标签模糊查找符合的文件|

 **返回示例**

``` 
{
    "code": 1,
    "msg": "学校公共文件列表",
    "data": [
        {
            "id": 54,
            "user_id": 14,
            "file_size": 777835,
            "create_time": 1547544473,
            "download_times": 0,
            "filename": "Penguins.jpg",
            "oss_host": "http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com",
            "oss_file": "14/Penguins.jpg",
            "suffix": "jpg",
            "type": "图片",
        },
    ]
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|返回数据, 所有公共文件的集合|

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