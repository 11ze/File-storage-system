## 将公共文件变为私有文件

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/public/to_private

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|files|true|array|公共文件ID, 可多选|
|new_dir_id|true|int|私有文件存放的文件夹ID|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|