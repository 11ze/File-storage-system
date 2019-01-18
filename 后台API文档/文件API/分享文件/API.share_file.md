## 生成分享文件链接

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/share_file

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|files|true|array|文件ID, 可多选|
|dead_time|true|int|有效时间, 1:一天 7:七天 0:永久|
|iscode|true|int|是否加密, 1:加密 2:不加密|


 **返回示例**

``` 
{
    "code": 1,
    "msg": "成功生成分享链接",
    "data": {
        "link": "http://centos3.huangdf.com/#/share?id=55ec46e75affdc43ca6c037c14bda4f0",
        "code": "j4b9",
        "qr_code": "http://centos3.huangdf.com/php/public/upload/QRshare/55ec46e75affdc43ca6c037c14bda4f0.png"
    }
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|返回数据|

##### 返回字段 "data" 子项

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|link|string|生成的加密链接|
|code|string|链接提取码, 不生成时为空|
|qr_code|string|分享链接的二维码图片地址|