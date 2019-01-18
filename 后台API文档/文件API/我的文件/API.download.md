## 获取下载文件需要的验证信息并更新下载次数

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/files/download

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|files|true|array|要下载的文件ID|

 **返回示例**

``` 
{
    "code": 1,
    "msg": "操作成功",
    "data": {
        "region": "oss-cn-beijing.aliyuncs.com/",
        "accessKeyId": "<yourAccessKeyId>",
        "accessKeySecret": "<yourAccessKeySecret>",
        "bucket": "gdqy-bucket-2"
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
|region|string|OSS region|
|bucket|string|bucketname|