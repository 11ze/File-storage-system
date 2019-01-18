## 个人主页的面包屑导航

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/get_nav

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|dir_id|true|int|分享链接里的文件夹ID|


 **返回示例**

``` 
{
    "code": 1,
    "msg": "面包屑导航",
    "data": [
        {
            "id": 182,
            "filename": "面包"
        },
        {
            "id": 183,
            "filename": "牛奶"
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
|id|int|文件夹ID|
|filename|string|文件夹名字|