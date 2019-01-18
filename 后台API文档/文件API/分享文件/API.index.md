## 获取我的所有分享链接

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/index

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|share_id|true|array|分享链接的ID, 可多选|


 **返回示例**

``` 
{
    "code": 1,
    "msg": "我的分享",
    "data": [
        {
            "id": 16,
            "share_time": 1547701989,
            "dead_time": 1548306789,
            "code": "j4b9",
            "link": "http://centos3.huangdf.com/#/share?id=55ec46e75affdc43ca6c037c14bda4f0",
            "name": "PHP面试题.docx",
            "view_count": 2,
            "download_count": 0
        }
    ]
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
|id|int|分享链接ID|
|name|string|链接名字|
|share_time|int|分享时间|
|dead_time|int|分享有效期|
|code|string|文件提取码, 没有时为空|
|link|string|加密的分享链接|
|view_count|int|浏览次数|
|download_count|int|下载次数|