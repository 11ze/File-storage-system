
<template lang="html">
    <div >
        <el-radio v-model="radio" label="1">私有文件</el-radio>
        <el-radio v-model="radio" label="0">公有文件</el-radio>
        <el-row>
            <h4>文件标签：</h4>
            <el-tag
                    :key="tag"
                    v-for="tag in dynamicTags"
                    closable
                    :disable-transitions="false"
                    @close="handleClose(tag)">
                {{tag}}
            </el-tag>
            <el-input
                    class="input-new-tag"
                    v-if="inputVisible"
                    v-model="inputValue"
                    ref="saveTagInput"
                    size="small"
                    @keyup.enter.native="handleInputConfirm"
                    @blur="handleInputConfirm"
            >
            </el-input>

            <el-button v-else class="button-new-tag" size="small" @click="showInput">增加标签</el-button>
        </el-row>

        <h4>您所选择的文件列表：</h4>
        <div id="ossfile" ></div>

        <br/>

        <div id="container">
            <a  id="selectfiles"  href="javascript:void(0);" class='btn' v-loading.fullscreen.lock="loading"
                element-loading-text="准备上传中..."
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(0, 0, 0, 0.8)" >选择文件</a>
            <a  id="postfiles" href="javascript:void(0);" class='btn'>开始上传</a>


        </div>
        <pre id="console">{{message}}</pre>

        <p>&nbsp;</p>
    </div>

</template>

<script>
    import plupload from '../../../static/pupload/plupload-2.1.2/js/plupload.full.min.js';
    import BMF from 'browser-md5-file';
    const bmf = new BMF();
    export default {
        name: 'upload',
        data() {
            return {
                dynamicTags: [],
                isselect:false,
                inputVisible:false,
                del_file_list:[],
                inputValue: '',
                radio: '1',
                accessid: '',
                file_list:[],
                loading:false,
                md5:'',
                filesize:'',
                isupload:'',
                accesskey: '',
                host: '',
                policyBase64: '',
                signature: '',
                callbackbody: '',
                filename: '',
                key:'',
                expire: 0,
                g_object_name: '',
                g_object_name_type: '',
                now: Date.parse(new Date()) / 1000,
                message: '',
            };
        },
        props: {
            fileId: '',
            beforeUpload: Function,
            onSuccess: Function,
            onError: Function,
            onProgress: Function,
        },
        beforeCreate() {
        },
        mounted() {
            this.$nextTick(() => {
                this.upload();
            });
        },
        methods: {

            handleClose(tag) {
                this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
            },

            showInput() {
                this.inputVisible = true;
                this.$nextTick(_ => {
                    this.$refs.saveTagInput.$refs.input.focus();
                });
            },

            handleInputConfirm() {
                let inputValue = this.inputValue;
                if (inputValue) {
                    this.dynamicTags.push(inputValue);
                }
                this.inputVisible = false;
                this.inputValue = '';
            },
            sendRequest() {
                var xmlhttp = null;
                if (window.XMLHttpRequest)
                {
                    xmlhttp=new XMLHttpRequest();

                }
                else if (window.ActiveXObject)
                {
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }

                if (xmlhttp!=null)
                {
                    // serverUrl是 用户获取 '签名和Policy' 等信息的应用服务器的URL，请将下面的IP和Port配置为您自己的真实信息。
                    const serverUrl = '/php/public/api/file/signature/get';
                    //const serverUrl = '/oss/php/callback.php';

                    xmlhttp.open( "GET", serverUrl, false );
                    xmlhttp.setRequestHeader('XX-Token', sessionStorage.getItem("token"))
                    xmlhttp.send( null );
                    return xmlhttp.responseText
                }
                else
                {
                    alert("Your browser does not support XMLHTTP.");
                }

            },
            getSignature() {
                // 可以判断当前expire是否超过了当前时间,如果超过了当前时间,就重新取一下.3s 做为缓冲
                this.now = Date.parse(new Date()) / 1000;
                if (this.expire < this.now + 3) {

                    // console.log('test2:'+res)
                    const body = this.sendRequest();
                    const obj = eval ("(" + body + ")");
                    this.host = obj.data.host;
                    this.policyBase64 = obj.data.policy;
                    this.accessid = obj.data.accessid;
                    this.signature = obj.data.signature;
                    this.expire = parseInt(obj.data.expire, 10);
                    obj.data.dir = obj.data.dir.substr(0, obj.data.dir
                        .length - 1)

                    this.key = obj.data.dir
                    console.log('得到允许上传')
                    return true;
                }
                return false;
            },
            getSuffix(filename) {
                const pos = filename.lastIndexOf('.');
                let suffix = '';
                if (pos !== -1) {
                    suffix = filename.substring(pos);
                }
                return suffix;
            },
            calculateObjectName(filename) {
                this.g_object_name += '/'+filename;
                return '';
            },
            mds(event){
                const file = event
                //const file  = event.target.files[0];
                console.log(file)
                bmf.md5(
                    file,
                    (err, md5) => {
                        console.log('错误:', err);
                        console.log('md5 :', md5);
                        this.md5 = md5
                        if(this.md5!='') {
                            this.loading = false
                            let formdata = new FormData();
                            formdata.append('file_md5',this.md5)
                            http.apipost('php/public/api/file/signature/file_exist',formdata).then(res => {
                                console.log(res)
                                if (res.msg=='已存在') {
                                    this.upsql(file)
                                    this.file_list.push(file)
                                    this.del_file_list.push(file.name)
                                }else {
                                    this.file_list.push(file)
                                    //this.uposs(file)
                                }
                            })
                        }
                    },
                    progress => {
                        console.log('progress number:', progress);
                    },
                );
            },
            upsql(file){
                    if(this.$store.state.catalogid ==''){
                        this.$store.commit('set_catalogid','0')
                    }

                    let formData = new FormData();
                    formData.append('filename',this.g_object_name);
                    console.log("filename:"+this.g_object_name)
                    formData.append('isdir','0');
                    formData.append('dir_id',this.$store.state.catalogid);
                    formData.append('file_size',file.size);
                    formData.append('status',this.radio);
                    formData.append('file_md5',this.md5);
                    formData.append('tags',this.dynamicTags);
                    http.apipost('php/public/api/file/files/upload',formData).then(res=>{
                        console.log(res)
                        this.$store.commit('set_over',true)
                        if(res.code == 1){
                            console.log("只循环到数据库")
                            this.$store.commit('set_over',true)
                        }else {

                        }
                    })

                },

            uposs(file){
                        let formData = new FormData();
                        if(this.$store.state.catalogid == ''){
                            console.log("目录为空")
                            this.$store.state.catalogid = '0'
                        }
                        console.log("id:"+this.$store.state.catalogid)
                        formData.append('filename', this.g_object_name);
                        console.log("filename_oss"+this.g_object_name)
                        formData.append('isdir', '0');
                        formData.append('dir_id', this.$store.state.catalogid);
                        formData.append('file_size', file.size);
                        formData.append('status', this.radio);
                        formData.append('file_md5', this.md5);
                        formData.append('tags', this.dynamicTags);
                        console.log('文件名：' + this.g_object_name)
                        http.apipost('php/public/api/file/files/upload', formData).then(res => {
                            console.log(res)
                            this.$store.commit('set_over',true)
                            if (res.code == 1) {
                                console.log("循环到数据库和oss")
                            }
                        })
                },
            setUploadParam(up, file, ret) {
                if (ret === false) {
                    ret = this.getSignature();
                }

                this.g_object_name = this.key ;

                if (file !== '') {
                        this.getSuffix(file)
                        this.calculateObjectName(file);

                }
                const newMultipartParams = {
                    key: this.g_object_name,
                    policy: this.policyBase64,
                    OSSAccessKeyId: this.accessid,
                    // 让服务端返回200,不然，默认会返回204
                    success_action_status: '200',
                    signature: this.signature,
                    // callback: this.callbackbody,
                };


                up.setOption({
                    'url': this.host,
                    'multipart_params': newMultipartParams,
                });

                    up.start();


            },
            upload() {
                const that = this;
                const uploader = new plupload.Uploader({
                    runtimes: 'html5,flash,silverlight,html4',
                    browse_button: 'selectfiles',
                    multi_selection: false,
                    container: document.getElementById('container'),
                    flash_swf_url: '../../static/pupload/plupload-2.1.2/js/Moxie.swf',
                    silverlight_xap_url: '../../static/pupload/plupload-2.1.2/js/Moxie.xap',
                    url: 'http://oss.aliyuncs.com',
                    filters: {
                        mime_types: [],
                        // 最大只能上传200mb的文件
                        max_file_size: '1000mb',
                        // 不允许队列中存在重复文件
                        prevent_duplicates: true,
                    },
                    init: {
                        PostInit: () => {
                            document.getElementById('ossfile').innerHTML = '';
                            document.getElementById('postfiles').onclick = () => {
                                that.setUploadParam(uploader, '', false);
                                return false;
                            };
                        },
                        FilesAdded: (up, files) => {
                            plupload.each(files, (file) => {
                                this.filesize = file.size
                                document.getElementById('ossfile').innerHTML += `<div id="${file.id}">${file.name} (${plupload.formatSize(file.size)})<b></b><div class="progress"><div class="progress-bar" style="width: 0"></div></div></div>`;
                                that.message = '';
                            });
                        },

                        BeforeUpload: (up, file) => {
                            this.loading = true
                            var f = file.getNative()
                            console.log("触发上传",f)
                            this.mds(f)
                            this.setUploadParam(up, file.name, true );


                        },
                        UploadProgress: (up, file) => {

                            if(this.del_file_list ==''){

                                var d = document.getElementById(file.id);
                                d.getElementsByTagName('b')[0].innerHTML = `<span>${file.percent}%</span>`;
                                var prog = d.getElementsByTagName('div')[0];
                                var progBar = prog.getElementsByTagName('div')[0];
                                progBar.style.width = `${2 * file.percent}px`;
                                progBar.setAttribute('aria-valuenow', file.percent);

                            }else {
                                for (let i = 0; i < this.del_file_list.length; i++) {
                                    if (this.del_file_list[i] == file.name) {
                                        console.log("存在跳过")

                                        up.removeFile(file)
                                        var d = document.getElementById(file.id);
                                        d.getElementsByTagName('b')[0].innerHTML = `<span>${100}%</span>`;
                                        var prog = d.getElementsByTagName('div')[0];
                                        var progBar = prog.getElementsByTagName('div')[0];
                                        progBar.style.width = `${200}px`;
                                        progBar.setAttribute('aria-valuenow', file.percent);

                                    } else {

                                        var d = document.getElementById(file.id);
                                        d.getElementsByTagName('b')[0].innerHTML = `<span>${file.percent}%</span>`;
                                        var prog = d.getElementsByTagName('div')[0];
                                        var progBar = prog.getElementsByTagName('div')[0];
                                        progBar.style.width = `${2 * file.percent}px`;
                                        progBar.setAttribute('aria-valuenow', file.percent);
                                    }
                                }
                            }

                        },
                        FileUploaded: (up, file, info) => {
                            if (info.status == 200)
                            {
                                console.log(this.file_list)
                                console.log(this.del_file_list)
                                for(let i=0;i<this.file_list.length;i++){
                                    if(this.del_file_list[i] == this.file_list[i].name){
                                        console.log("you")
                                    }else {
                                        console.log("meiyou")
                                        this.uposs(this.file_list[i])
                                    }
                                }
                                let infor = info
                                console.log("信息："+infor)
                                // console.log("this.g_object_name:"+this.g_object_name)
                                // console.log('文件名：'+file.name+'文件大小:'+file.size+'文件路径：'+this.g_object_name)
                                // //http.apipost()
                                // console.log('标签：'+this.dynamicTags+'公私：'+this.radio)
                                //document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = ' 回调服务器返回的内容是:' + info.response;
                            }
                            else if (info.status == 203)
                            {
                                document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '上传到OSS成功，但是oss访问用户设置的上传回调服务器失败，失败原因是:' + info.response;
                            }
                            else
                            {
                                document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = info.response;
                            }
                        },
                        Error: (up, err) => {
                            console.log('上传失败：', err, that.onError, up);
                            if (err.code === -600) {
                                that.message = '文件大小超出限制，限制大小为200M';
                            } else if (err.status === 403) {
                                that.message = '上传失败!请刷新页面后重新上传文件！';

                            } else {
                                // console.log('文件上传失败，请刷新页面后重新上传文件！');
                                that.message = '上传失败，请刷新页面后重新上传文件！';
                            }
                            if (that.onError) {
                                that.onError(err.message, up, err);
                            }
                        },
                    },
                });
                uploader.init();

            },
        },
    }
</script>
<style src="./upload.css"> .el-tag + .el-tag {
    margin-left: 10px;
}
.button-new-tag {
    margin-left: 10px;
    height: 32px;
    line-height: 30px;
    padding-top: 0;
    padding-bottom: 0;
}
.input-new-tag {
    width: 90px;
    margin-left: 10px;
    vertical-align: bottom;
}</style>
