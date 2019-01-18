<template>
    <div style="width: 300px">
        <el-input
                placeholder="请输入文件夹名"
                v-model="inputfolder"
                class="input-with-select"
                clearable>
            <el-button v-if="begins==false" type="primary" slot="append" icon="el-icon-search" round @click="newfolders()">确定</el-button>
            <el-button v-if="begins==true" type="primary" slot="append" icon="el-icon-search" round disabled>等待</el-button>
        </el-input>
    </div>
</template>

<script>

    export default {
        name: "upfolder",

        data(){
            return{
                newfolder:'',
                inputfolder:'',
                begins:false,
            }
        },
        methods:{
            sendRequests() {
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
                    xmlhttp.setRequestHeader('XX-Token', this.$store.state.token)
                    xmlhttp.send( null );
                    return xmlhttp.responseText
                }
                else
                {
                    alert("Your browser does not support XMLHTTP.");
                }

            },
            getSignatures() {
                // 可以判断当前expire是否超过了当前时间,如果超过了当前时间,就重新取一下.3s 做为缓冲
                    // console.log('test2:'+res)
                    const body = this.sendRequests();
                    console.log(body)
                    const obj = eval ("(" + body + ")");
                    console.log(obj)
                    this.$store.state.user_cata = obj.data.dir;
                    this.$store.commit('set_user_cata',obj.data.dir)
            },
            allfile(now){
                let formData = new FormData();
                formData.append('dir_id',now);
                http.apipost('/php/public/api/file/files/my_files',formData).then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取数据失败');
                    }else {
                        this.$store.commit('set_files', res.data)
                        this.$store.state.uploaderview = false
                    }
                })
            },
            newfolders() {

                this.getSignatures()
                console.log(this.inputfolder)
                console.log(this.$store.state.get_nav)

                // console.log(this.$store.state.get_nav[this.$store.state.get_nav.length-1].filename) //获取目录名
                // console.log(this.$store.state.get_nav[this.$store.state.get_nav.length-1].id) //获取目录名
                if(this.$store.state.get_nav[0]){
                    var thefileid = this.$store.state.get_nav[this.$store.state.get_nav.length-1].id
                    this.newfolder =this.$store.state.get_nav[this.$store.state.get_nav.length-1].filename + "/"+this.inputfolder
                }else {
                    thefileid = 0
                    this.newfolder = "/"+this.inputfolder
                }
                    if (this.newfolder != '') {
                            this.begins = true
                            let formData = new FormData();
                            formData.append('filename',this.newfolder);
                            formData.append('file_size', '0');
                            formData.append('isdir', '1');
                            formData.append('dir_id', thefileid);
                            formData.append('tags', '');
                            formData.append('status', '1');
                            console.log('文件：' + this.newfolder)
                            http.apipost('php/public/api/file/files/upload', formData).then(res => {
                                console.log(res)
                                if (res.code == 1) {
                                    this.$message.success('新建成功！');
                                    this.inputfolder=[]
                                    this.newfolder =[]
                                    this.begins = false
                                    this.allfile(0)
                                    this.$store.commit('set_get_nav','')
                                } else {
                                    this.$message.error('新建失败！');
                                    this.begins = false

                                }
                            })
                        } else {
                            this.$message.error('请输入文件夹名称！');
                            this.$router.go(0)
                            //return false
                        }


                //this.$router.go(0)
            }
            }

    }
</script>

<style >

</style>
