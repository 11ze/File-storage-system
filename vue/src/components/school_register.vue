<template>
    <div class="big">
        <div class="divps">
            <div class="divcs">
                <el-card class="box-cards">
                    <el-row><h1>{{ msg }}</h1></el-row>
                    <div v-if="next ==false">
                        <h3>填写学校信息</h3>
                        <el-row>
                            <el-input type="text" style="width:350px;" v-model="form.schoolname" placeholder="学校名称"></el-input>
                            <el-input type="text" style="width:350px;" v-model="form.schoolplace" placeholder="学校地址"></el-input>
                        </el-row>
                        <el-row>
                            <el-col :span="12"><h3>上传学校营业执照</h3></el-col>
                            <el-col :span="12"><h3>上传学校标志logo</h3></el-col>
                        </el-row>
                        <el-row >
                            <el-col :span="12">
                                <form>
                                    <label class="jj">
                                        <input type="file" @change="getFile($event)" id="pic" style="display:none" accept="image/gif,image/jpeg,image/jpg,image/png">
                                        <img  id="show" src="" width="200px" height="200px">
                                    </label>
                                </form>
                            </el-col>
                            <el-col :span="12">   <form>
                                <label class="jj">
                                    <!--<input type="file" @change="getFile($event)" style="display:none" webkitdirectory> 上传文件夹 -->
                                    <input type="file" @change="getFiles($event)" id="pics" style="display:none" accept="image/gif,image/jpeg,image/jpg,image/png">
                                    <img  id="shows" src="" width="200px" height="200px">
                                </label>
                            </form>   </el-col>
                        </el-row>
                        <el-row>
                            <el-button type="primary" style="width:350px;" @click="next=true">下一步</el-button>
                            <!--<button @click="submitForm($event)">提交</button>-->
                        </el-row>
                    </div>

                    <div v-if="next==true">
                        <h3>设置管理员帐号信息</h3>
                        <el-row>
                            <el-input type="text" style="width:350px;" v-model="form.schoolman" placeholder="学校联系人"></el-input>
                            <el-input type="text" style="width:350px;" v-model="form.schoolphone" placeholder="联系人电话"></el-input>
                        </el-row>
                        <el-row>
                            <el-input type="text" style="width:350px;" v-model="form.schoolemail" placeholder="联系人邮箱"></el-input>
                            <el-input type="text" style="width:350px;" v-model="form.schoolidcard" placeholder="联系人身份证号"></el-input>
                        </el-row>
                        <el-row>
                            <el-input type="password" style="width:350px;" v-model="form.password" placeholder="密码"></el-input>
                            <el-input type="password" style="width:350px;" v-model="form.password2" placeholder="确认密码"></el-input>
                        </el-row>
                        <el-row>
                            <el-input type="text" style="width:350px;" v-model="form.code" placeholder="输入验证码"></el-input>
                            <el-button v-if="ifx==false" @click="getverifi()">{{upcode}}</el-button>
                            <el-button v-else="ifx==true" disabled>{{upcode}}</el-button>
                        </el-row>


                        <el-row>
                            <el-button type="primary" style="width:350px;" @click="addschool($event)">注册学校系统</el-button>
                            <!--<button @click="submitForm($event)">提交</button>-->
                        </el-row>
                        <el-row><el-button   @click="next==true">上一页</el-button></el-row>
                    </div>

                </el-card>
            </div>
        </div>
    </div>

</template>

<script>

    export default {
        name: "school_register",

        data() {
            return {
                thecount:60,
                upcode:'发送验证码',
                ifx:false,
                next:false,
                maxSize: 10240000 / 2,//图片的最大大小
                maxCount: 1,//最大数量
                filesArr: [],//保存要上传图片的数组
                images: [],//转成base64后的图片的数组
                msg: '分布式文件管理系统',
                form: {
                    schoolname: '',
                    schoolplace: '',
                    schoolman: '',
                    schoolphone: '',
                    schoolemail: '',
                    schoolidcard: '',
                    password: '',
                    password2: '',
                    file:'',
                    files:'',
                    begintime:'',

                },
            }
        },
        mounted() {
        },
        methods: {
            getverifi(){

                let formData = new FormData();
                formData.append('username',this.form.schoolemail);
                console.log('获取验证码',formData)
                http.apipost('php/public/api/user/verification_code/send',formData).then(res=>{console.log(res)
                    if(res.code == 1){
                        this.$message.success(res.msg);
                        this.ifx = true
                            let clock = window.setInterval(() => {
                                this.thecount--
                                this.upcode = this.thecount + 's后重新发送'
                                if (this.thecount < 0) {
                                    window.clearInterval(clock)
                                    this.upcode = '重新发送验证码'
                                    this.thecount = 60
                                    this.ifx = false //这里重新开启
                                }
                            }, 1000)

                    }else {
                        this.$message.error(res.msg)
                        this.ifx = false
                    }
                })
            },
            addschool(event) {

                event.preventDefault();
                let formData = new FormData();
                formData.append('license', this.file);
                formData.append('logo', this.files);
                formData.append('nickname', this.form.schoolman);
                formData.append('password', this.form.password);
                formData.append('password2', this.form.password2);
                formData.append('useremail', this.form.schoolemail);
                formData.append('mobile', this.form.schoolphone);
                formData.append('schoolname', this.form.schoolname);
                formData.append('saddress', this.form.schoolplace);
                formData.append('idcard', this.form.schoolidcard);

                http.apipost('php/public/api/user/public/addSchool', formData).then(res => {
                    console.log(res)
                    if (res.code == 1) {
                        this.$message.success(res.msg)
                    } else {
                        this.$message.error(res.msg)
                    }
                })
            },
            getFile(event) {
                this.file = event.target.files[0];
                let url =this.file
                // var newsrc=getObjectURL(obj.files[0]);
                // 下面函数执行的效果是一样的，只是需要针对不同的浏览器执行不同的 js 函数而已
                if (window.createObjectURL!=undefined) { // basic
                    url = window.createObjectURL(url) ;
                } else if (window.URL!=undefined) { // mozilla(firefox)
                    url = window.URL.createObjectURL(url) ;
                } else if (window.webkitURL!=undefined) { // webkit or chrome
                    url = window.webkitURL.createObjectURL(url) ;
                }
                console.log(url)
                // var imageurl = document.getElementById("pic").value;
                console.log(this.file);
                document.getElementById('show').src=url;
                // console.log(imageurl)
            },
            getFiles(event) {
                this.files = event.target.files[0];
                let urls =this.files
                // var newsrc=getObjectURL(obj.files[0]);
                // 下面函数执行的效果是一样的，只是需要针对不同的浏览器执行不同的 js 函数而已
                if (window.createObjectURL!=undefined) { // basic
                    urls = window.createObjectURL(urls) ;
                } else if (window.URL!=undefined) { // mozilla(firefox)
                    urls = window.URL.createObjectURL(urls) ;
                } else if (window.webkitURL!=undefined) { // webkit or chrome
                    urls = window.webkitURL.createObjectURL(urls) ;
                }
                console.log(urls)
                // var imageurl = document.getElementById("pic").value;
                console.log(this.files);
                document.getElementById('shows').src=urls;
                // console.log(imageurl)
            },
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    ul {
        list-style-type: none;
        padding: 0;
    }
    li {
        display: inline-block;
        margin: 0 10px;
    }
    a {
        color: #42b983;
    }
    .el-row {
        margin-bottom: 20px;
    &:last-child {
         margin-bottom: 0;
     }
    }
    .avatar-uploader .el-upload {
                            border: 1px dashed #d9d9d9;
                            border-radius: 6px;
                            cursor: pointer;
                            position: relative;
                            overflow: hidden;
                        }
    .avatar-uploader .el-upload:hover {
        border-color: #409EFF;
    }.box-cards{
         width:1000px;
         height:600px;
         background-color:#F0F8FF;
     }
    .divcs{
        width:1000px;
        height:600px;
        margin:0 auto;
        background-color: aliceblue;
    }.divps{
         font-family: 'Avenir', Helvetica, Arial, sans-serif;
         -webkit-font-smoothing: antialiased;
         -moz-osx-font-smoothing: grayscale;
         text-align: center;
         color: #2c3e50;
         margin-top: 60px;
     }

 .jj{
            display: inline-block;
            vertical-align: middle;
            box-shadow: inset 0px 1px 20px 5px #ddd;
            text-align: left;
            width: 200px;
            height: 200px;
        background:url("../assets/images/up.jpg");
        }

</style>



<style scoped>

</style>
