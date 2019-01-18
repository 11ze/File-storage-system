## 修改密码

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/profile/change_password

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|old_password|true|string|用户旧密码|
|password|true|string|新密码|
|password2|true|string|确认新密码|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|