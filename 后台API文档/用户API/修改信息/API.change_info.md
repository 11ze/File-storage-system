## 用户基本信息修改

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/profile/change_info

需要header['XX-Token']

#### 参数

|字段|必选|类型|说明|
|----|----|----|----|
|user_nickname|true|string|用户昵称|
|sex|true|int|性别, 0:保密 1:男 2:女|
|birthday|true|int|用户生日时间戳|
|signature|true|string|个性签名|
当所有字段为空时返回错误

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
|user_nickname|string|昵称|
|sex|int|性别, 0:保密 1:男 2:女|
|signature|string|个性签名|
|birthday|int|生日时间戳|