## 用户登录

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/public/login



#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|username|true|string|学号或邮箱|
|password|true|string|密码|
|schoolname|true|string|学校名|


 **返回示例**
``` 
{
    "code": 1,
    "msg": "登录成功!",
    "data": {
        "token": "a202cc0eb37eff56e416c92ff797e782f05c3dda4ddd4de63171de443536ec04",
        "user": {
            "id": 62,
            "user_type": 2,
            "sex": 0,
            "birthday": 631152000,
            "last_login_time": 0,
            "create_time": 1547694247,
            "user_login": "2016060501340",
            "user_nickname": "王泽",
            "user_email": "11ze@qq.com",
            'signature': "";
            "last_login_ip": "",
            "mobile": "",
            "school_name": "广轻"
        }
    }
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|返回数据|

##### 返回字段data子项
|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|token|string|用户登录token|
|user|array|用户信息|

##### 返回字段user子项
|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|id|int|用户ID|
|user_type|int|用户类型, 1:管理员 2|普通用户|
|sex|int|性别, 0:保密 1:男 2:女|
|birthday|int|用户生日时间戳|
|last_login_time|int|最后登录时间戳|
|create_time|int|账号创建时间戳|
|user_login|string|学号|
user_nickname|string|昵称|
|user_email|string|邮箱|
|signature|string|个性签名|
|last_login_ip|string|最后登录IP|
|mobile|string|手机号|
|school_name|string|所属学校名|