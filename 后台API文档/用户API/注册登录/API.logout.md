## 退出登录

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/public/logout

需要header['XX-Token']

 **返回示例**
``` 
{
    "code": 1,
    "msg": "退出成功!",
    "data": ""
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|