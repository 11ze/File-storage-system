## 用户密码重置, 新密码将发送到用户邮箱

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/public/passwordReset



#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|useremail|true|string|邮箱|
|password|true|string|新密码|
|code|true|int|邮箱验证码|


#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|