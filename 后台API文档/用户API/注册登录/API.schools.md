## 读取已有学校列表

#### 调用地址

http://centos3.huangdf.com/php/public/api/user/public/schools

 **返回示例**
``` 
{
    "code": 1,
    "msg": "查询学校列表成功",
    "data": [
        "广轻",
        "今天你学习了吗",
        "人才培训所",
        "ee",
        "303",
        "302"
    ]
}
```

#### 返回

|返回值字段|字段类型|字段说明|
|----------|--------|--------|
|code|int|1:成功 0:失败|
|msg|string|提示信息|
|data|array|包含已有学校名称|