## 获取用户所有标签

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/tags/read_all

需要header['XX-Token']

 **返回示例**
``` 
{
    "code": 1,
    "msg": "用户所有标签",
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
|data|array|用户标签名集合|