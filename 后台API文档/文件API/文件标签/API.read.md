## 获取指定文件的标签

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/tags/read

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|fid|true|int|文件ID|

 **返回示例**
``` 
{
    "code": 1,
    "msg": "文件标签",
    "data": [
        "PHP",
        "面试题"
    ]
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|文件标签名集合|