## 根据文件的md5值判断文件在oss是否已存在

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/signature/file_exist

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|file_md5|true|string|文件的md5值|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:已存在 0:不存在|
|msg|string|提示信息|