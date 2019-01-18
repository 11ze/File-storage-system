## 取消分享

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/cancel_share

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|share_id|true|array|分享链接的ID, 可多选|

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|返回数据|