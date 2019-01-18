## 编辑用户所有标签

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/tags/edit_all

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|tags|true|array|包含多个标签名的数组|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|