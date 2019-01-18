## 用户注册

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/public/register



#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|username|true|string|学号, 必须为纯数字|
|nickname|true|string|姓名|
|password|true|string|密码, 6< 长度< 32, 不能为纯数字|
|passwrod2|true|string|确认密码|
|useremail|true|string|邮箱|
|schoolname|true|string|学校名|


 **返回示例**
``` 
{
    "code": 1,
    "msg": "注册成功, 请等待邮件通知结果!",
    "data": ""
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|