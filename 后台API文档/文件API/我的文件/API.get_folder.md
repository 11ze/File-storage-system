## 获取从根目录开始的嵌套文件夹列表, 用于选择移动 复制和保存文件的路径

#### 调用地址

http://centos3.huangdf.com/php/public/api/file/share/get_folder

需要header['XX-Token']

 **返回示例**

``` 
{
    "code": 1,
    "msg": "选择文件夹",
    "data": [
        {
            "value": 0,
            "label": "主文件夹",
            "children": [
                {
                    "value": 182,
                    "label": "面包",
                    "children": [
                        {
                            "value": 183,
                            "label": "牛奶",
                            "children": [
                                {
                                    "value": 184,
                                    "label": "分享"
                                }
                            ]
                        }
                    ]
                }
            ]
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
|value|int|文件夹ID|
|label|string|文件夹名字|
|children|array|同 "data" 子项|