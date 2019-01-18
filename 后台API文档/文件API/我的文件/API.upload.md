## 上传文件, 传入信息写入数据库

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/files/upload

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|filename|true|string|带路径文件名|
|file_size|true|int|文件大小|
|status|true|int|文件公私有, 0:公有 1:私有|
|tags|false|array|文件标签名|
|isdir|true|int|1:文件夹 0:文件|
|file_md5|true|string|文件的md5值|
|dir_id|true|int|文件夹ID, 根目录传0|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|