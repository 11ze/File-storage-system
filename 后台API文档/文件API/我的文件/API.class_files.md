## 查找分类文件

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/files/class_files

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|type|true|string|文件分类: 图片 音乐 视频 文档 其他|
|keyword|false|string|按关键字查找文件名|

 **返回示例**

``` 
{
    "code": 1,
    "msg": "请求成功",
    "data": [
        {
            "id": 180,
            "user_id": 62,
            "file_size": 22028,
            "create_time": 1547695213,
            "download_times": 0,
            "filename": "PHP面试题.docx",
            "oss_host": "http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com",
            "oss_file": "62/PHP面试题.docx",
            "suffix": "docx",
            "type": "文档"
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