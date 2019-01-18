import plupload from 'plupload'

var accessid = ''
var accesskey = ''
var host = ''
var policyBase64 = ''
var signature = ''
var callbackbody = ''
var filename = ''
var key = ''
var expire = 0
var g_object_name = ''
var g_object_name_type = ''
var now = Date.parse(new Date()) / 1000
function send_request() //获取回调信息
{
    var xmlhttp =''
    http.apipost('/php/public/api/file/articles/get').then(res=>{console.log(res)
        xmlhttp = res
    })
    return xmlhttp.responseText
}
function get_signature()
{
    // 可以判断当前expire是否超过了当前时间， 如果超过了当前时间， 就重新取一下，3s 作为缓冲。
    var now = Date.parse(new Date()) / 1000;
    if (expire < now + 3)
    {
        var body = send_request()
        var obj = eval ("(" + body + ")");
        host = obj['host']
        policyBase64 = obj['policy']
        accessid = obj['accessid']
        signature = obj['signature']
        expire = parseInt(obj['expire'])
        callbackbody = obj['callback']
        key = obj['dir']
        return true;
    }
    return false;
}
function get_suffix(filename) {
    var pos = filename.lastIndexOf('.') //文件后缀名
    var suffix = ''
    if (pos != -1) {
        var suffix = filename.substring(pos)
    }
    return suffix;
}
function calculate_object_name(filename)
{
    if (g_object_name_type == 'local_name')
    {
        g_object_name += "${filename}"
    }
    else if (g_object_name_type == 'random_name')
    {
        var suffix = get_suffix(filename)
        g_object_name = key + random_string(10) + suffix
    }
    return ''
}
function set_upload_param(up, filename, ret)
{
    if (ret == false)
    {
        ret = get_signature()  //判断是否获取到允许上传的回调
    }
    g_object_name = key;
    if (filename != '') { var suffix = get_suffix(filename)
        calculate_object_name(filename)
    }
    var new_multipart_params = {
        'key' : g_object_name,
        'policy': policyBase64,
        'OSSAccessKeyId': accessid,
        'success_action_status' : '200', //让服务端返回200,不然，默认会返回204
        'callback' : callbackbody,
        'signature': signature,
    };

    up.setOption({
        'url': host,
        'multipart_params': new_multipart_params
    });

    up.start();
}
const commonFns = {


    check_object_radio() {
        g_object_name_type = 'local_name';
    },

    get_uploaded_object_name(filename)
    {
        if (g_object_name_type == 'local_name')
        {
            var tmp_name = g_object_name
            var tmp_name = tmp_name.replace("${filename}", filename);
            return tmp_name
        }
        else if(g_object_name_type == 'random_name')
        {
            return g_object_name
        }
    },
    uploadfile() {
        var uploader = new plupload.Uploader({
            runtimes: 'html5,flash,silverlight,html4',
            browse_button: 'selectfiles',//触发文件选择对话框的DOM元素，当点击该元素后便后弹出文件选择对话框。该值可以是DOM元素对象本身，也可以是该DOM元素的id
            //multi_selection: false,
            container: document.getElementById('container'), //用来指定Plupload所创建的html结构的父容器，默认为前面指定的browse_button的父元素。该参数的值可以是一个元素的id,也可以是DOM元素本身。
            flash_swf_url: 'lib/plupload-2.1.2/js/Moxie.swf', //flash上传组件的url地址，如果是相对路径，则相对的是调用Plupload的html文档。当使用flash上传方式会用到该参数。
            silverlight_xap_url: 'lib/plupload-2.1.2/js/Moxie.xap',//silverlight上传组件的url地址，如果是相对路径，则相对的是调用Plupload的html文档。当使用silverlight上传方式会用到该参数。
            url: 'http://oss.aliyuncs.com',//服务器端接收和处理上传文件的脚本地址，可以是相对路径(相对于当前调用Plupload的文档)，也可以是绝对路径
//可以使用该参数来限制上传文件的类型，大小等，该参数以对象的形式传入，它包括三个属性：mime_types：用来限定上传文件的类型，为一个数组，该数组的每个元素又是一个对象，该对象有title和extensions两个属性，title为该过滤器的名称，extensions为文件扩展名，有多个时用逗号隔开。该属性默认为一个空数组，即不做限制。
//  
//
// max_file_size：用来限定上传文件的大小，如果文件体积超过了该值，则不能被选取。值可以为一个数字，单位为b,也可以是一个字符串，由数字和单位组成，如’200kb’
//
// prevent_duplicates：是否允许选取重复的文件，为true时表示不允许，为false时表示允许，默认为false。如果两个文件的文件名和大小都相同，则会被认为是重复的文件
//
// filters完整的配置示例如下(当然也可以只配置其中的某一项)：
            filters: {
                mime_types: [ //只允许上传图片和zip文件
                    {title: "Image files", extensions: "jpg,gif,png,bmp"},
                    {title: "Zip files", extensions: "zip,rar"},
                    {title : "编程语言", extensions : "py,java,c,"}
                ],
                max_file_size: '1000mb', //最大只能上传10mb的文件
                prevent_duplicates: true //不允许选取重复文件
            },
//当Plupload初始化完成后触发监听函数参数：(uploader)
//
//
// uploader为当前的plupload实例对象
            init: {
                //当Init事件发生后触发监听函数参数PostInit：(uploader)
                //
                //
                // uploader为当前的plupload实例对象
                PostInit: function () {
                    document.getElementById('ossfile').innerHTML = '';
                    document.getElementById('postfiles').onclick = function () {
                        set_upload_param(uploader, '', false);
                        return false;
                    };
                },
                //选中文件触发
                FilesAdded: function (up, files) {
                    plupload.each(files, function (file) {
                        document.getElementById('ossfile').innerHTML += '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ')<b></b>'
                            + '<div class="progress"><div class="progress-bar" style="width: 0%"></div></div>'
                            + '</div>';
                    });
                },
                //文件上传前触发
                BeforeUpload: function (up, file) {
                    check_object_radio();
                    set_upload_param(up, file.name, true);
                },
//会在文件上传过程中不断触发，可以用此事件来显示上传进度监听函数参数：(uploader,file)
//
//
// uploader为当前的plupload实例对象，file为触发此事件的文件对象
                UploadProgress: function (up, file) {
                    var d = document.getElementById(file.id);
                    d.getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
                    var prog = d.getElementsByTagName('div')[0];
                    var progBar = prog.getElementsByTagName('div')[0]
                    progBar.style.width = 2 * file.percent + 'px';
                    progBar.setAttribute('aria-valuenow', file.percent);
                },
                //文件上传后触发
                FileUploaded: function (up, file, info) {
                    if (info.status == 200) {
                        document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = 'upload to oss success, object name:' + get_uploaded_object_name(file.name) + ' 回调服务器返回的内容是:' + info.response;
                    }
                    else if (info.status == 203) {
                        document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '上传到OSS成功，但是oss访问用户设置的上传回调服务器失败，失败原因是:' + info.response;
                    }
                    else {
                        document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = info.response;
                    }
                },
//当发生错误时触发监听函数参数：(uploader,errObject)
//  
//
// uploader为当前的plupload实例对象，errObject为错误对象，它至少包含以下3个属性(因为不同类型的错误，属性可能会不同)：
//
// code：错误代码，具体请参考plupload上定义的表示错误代码的常量属性
//
// file：与该错误相关的文件对象
//
// message：错误信息
                Error: function (up, err) {
                    if (err.code == -600) {
                        document.getElementById('console').appendChild(document.createTextNode("\n选择的文件太大了,可以根据应用情况，在upload.js 设置一下上传的最大大小"));
                    }
                    else if (err.code == -601) {
                        document.getElementById('console').appendChild(document.createTextNode("\n选择的文件后缀不对,可以根据应用情况，在upload.js进行设置可允许的上传文件类型"));
                    }
                    else if (err.code == -602) {
                        document.getElementById('console').appendChild(document.createTextNode("\n这个文件已经上传过一遍了"));
                    }
                    else {
                        document.getElementById('console').appendChild(document.createTextNode("\nError xml:" + err.response));
                    }
                }
            }
        });
    },
}
export default commonFns
