## 学校管理员注册

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/public/addSchool



#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|nickname|true|string|联系人名字|
|password|true|string|密码, 6< 长度< 16, 不能为纯数字|
|password2|true|string|确认密码|
|useremail|true|string|邮箱|
|mobile|true|string|联系人手机号|
|schoolname|true|string|学校名|
|saddress|true|string|学校地址|
|idcard|true|string|联系人身份证号, 必须为有效身份证号码|
|license|true|file|学校营业执照, jpg jpeg png格式的图片|
|logo|true|file|学校logo|


#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|