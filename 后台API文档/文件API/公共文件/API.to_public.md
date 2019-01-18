## 将私有文件变为公共文件, 加入后台待审核列表

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/public/to_public

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|files|true|array|私有文件ID, 可多选|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|