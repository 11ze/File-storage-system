## 用户头像修改

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/profile/change_avatar

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|avatar|true|file|用户头像, jpg jpeg png|


#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|