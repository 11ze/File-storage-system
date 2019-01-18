## 获取分享链接对应的内容

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/get_share_file

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|id|true|int|分享链接中的加密ID|


 **返回示例**

``` 
{
    "code": 1,
    "msg": "获取分享链接文件",
    "data": {
        "id": 16,
        "user_id": 62,
        "share_time": 1547701989,
        "dead_time": 1548306789,
        "code": "j4b9",
        "name": "PHP面试题.docx",
        "view_count": 1,
        "download_count": 0,
        "files": [
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
        ],
        "user_info": {
            "id": 62,
            "user_nickname": "王泽",
            "avatar": "http://centos3.huangdf.com/php/public/user/public/avatar/62"
        }
    }
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
|id|int|分享链接的ID|
|user_id|int|分享文件的用户ID|
|share_time|int|分享时间|
|dead_time|int|分享有效期|
|code|string|文件提取码|
|name|string|链接名字|
|view_count|int|浏览次数|
|download_count|int|下载次数|
|files|array|文件列表|
|user_info|array|用户信息|

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

##### 返回字段 "user_info" 子项

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|id|int|用户ID|
|user_nickname|string|用户昵称|
|avatar|string|用户头像|