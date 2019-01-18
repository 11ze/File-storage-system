## 获取oss上传需要的验证信息

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/signature/get

需要header['XX-Token']

 **返回示例**

``` 
{
    "code": 1,
    "msg": "获取签名成功!",
    "data": {
        "accessid": "<yourAccessKeyId>",
        "key": "<yourAccessKeySecret>",
        "host": "http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com/",
        "policy": "eyJleHBpcmF0aW9uIjoiMjAxOS0wMS0xN1QxNDoyMDozMVoiLCJjb25kaXRpb25zIjpbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsMCwxMDQ4NTc2MDAwXSxbInN0YXJ0cy13aXRoIiwiJGtleSIsIjYyXC8iXV19",
        "signature": "SQoHKb0Y9X4lALXMCTJEyR24Byo=",
        "expire": 1547706031,
        "dir": "62/"
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
|accessid|string|OSS AccessKeyId|
|key|string|OSS AccessKeySecret|
|host|string|bucketname.endpoint|
|policy|string|无|
|signature|string|签名|
|expire|string|设置policy超时时间, 这里为30s|
|dir|string|用户上传文件时指定的前缀|