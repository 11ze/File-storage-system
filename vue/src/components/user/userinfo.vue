<template>

    <div >
        <div class="divpss">
            <div class="divcss">
            <el-card class="b">
                <div slot="header" class="clearfix" style="text-align: center">
                    <el-row ><img src="@/assets/logo.png" style="width:60px;hight:60px;"/>
                        </el-row>
                    <span>{{nickname}}</span>

                </div>
                <div class="infos">
                    <el-row >
                        <el-col :span="12">昵称：</el-col>
                        <el-col :span="12"><a v-if="input==false">{{username}}</a >
                            <el-input size="small" v-if="input==true" type="text" v-model="username"></el-input>
                        </el-col>
                    </el-row>
                    <el-row >
                        <el-col :span="12">性别：</el-col>
                        <el-col :span="12">
                            <a v-if="input==false">{{usersex}}</a>
                            <div  v-if="input==true">
                            <el-radio v-model="radio" label="1">男</el-radio>
                            <el-radio v-model="radio" label="0">女</el-radio>
                            </div>
                           </el-col>
                    </el-row>

                    <el-row >
                        <el-col :span="12">个性签名：</el-col>
                        <el-col :span="12"><a v-if="input==false">{{user_say}}</a >
                            <el-input size="small" v-if="input==true" type="text" v-model="user_say"></el-input>
                        </el-col>
                    </el-row>
                    <el-row >
                        <el-col :span="12">生日：</el-col>
                        <el-col :span="12"><a v-if="input==false">{{user_birthday}}</a>
                            <el-date-picker
                                    v-if="input==true"
                                v-model="date1"
                                type="date"
                                value-format="yyyy-MM-dd"
                                placeholder="选择日期">
                        </el-date-picker></el-col>
                    </el-row>
                    <el-row >
                        <el-col :span="12">邮箱：</el-col>
                        <el-col :span="12"><a >{{user_email}}</a ></el-col>
                    </el-row>
                    <el-row >
                        <el-col :span="12">学校名称：</el-col>
                        <el-col :span="12">{{school_name}}</el-col>
                    </el-row>
                    <el-row >
                        <el-col :span="12">最后登录时间：</el-col>
                        <el-col :span="12">{{last_login_time}}</el-col>
                    </el-row>
                    <el-row >
                        <el-col :span="12">最后登录IP：</el-col>
                        <el-col :span="12">{{last_login_ip}}</el-col>
                    </el-row>
                </div>
                <div style="text-align:center">
                    <el-button v-if="input==false" @click="input=true">编辑</el-button>
                    <el-button v-if="input==true" @click="save">保存</el-button>

                    <el-button v-if="input==true" @click="input=false">取消</el-button>
                    <el-button v-if="input==false" @click="gohome">我的网盘</el-button>
                </div>
            </el-card>
        </div>
            </div>
        </div>

</template>

<script>
    export default {
        name: "userinfo",
        data(){
            return{
                radio:'1',
                usersex:'',
                username:'',
                date1:'',
                nickname:'',
                sex:'',
                user_email:'',
                user_birthday:'',
                school_name:'',
                last_login_time:'',
                last_login_ip:'',
                user_say:'',
                input:false,
                pickerOptions1: {
                    disabledDate(time) {
                        return time.getTime() > Date.now();
                    },

                },

        }
        },
        methods:{
            gohome(){
                this.$router.push('/')
            },
            /*
          * 时间戳转换成正常时间的函数
          * */
            formatDateTime(timeStamp) {
                var date = new Date();
                date.setTime(timeStamp * 1000);
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                m = m < 10 ? ('0' + m) : m;
                var d = date.getDate();
                d = d < 10 ? ('0' + d) : d;
                var h = date.getHours();
                h = h < 10 ? ('0' + h) : h;
                var minute = date.getMinutes();
                var second = date.getSeconds();
                minute = minute < 10 ? ('0' + minute) : minute;
                second = second < 10 ? ('0' + second) : second;
                return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
            },
            save(){
                console.log(this.date1)
                let user_info = new FormData()
                user_info.append('user_nickname',this.nickname)
                user_info.append('sex',this.radio)
                user_info.append('birthday',this.date1)
                user_info.append('signature',this.user_say)
                console.log(this.date1)
                http.apipost('/php/public/api/user/profile/change_info',user_info).then( res => {
                    console.log(res)
                    if(res.code ==1){
                        this.$message.success(res.msg)
                        this.input=false
                        this.user_birthday = this.formatDateTime(res.data.birthday)
                        this.sex = res.data.sex
                        if(this.sex==1){
                            this.usersex = '男'


                        }else {
                            this.usersex = '女'
                        }
                        this.username = res.data.user_nickname

                    }
                })
            }
        },
        mounted(){
            //直接用 new Date(时间戳) 格式转化获得当前时间
            console.log(localStorage.getItem("user_type"))
            this.nickname = sessionStorage.getItem("user_login")
            this.username = sessionStorage.getItem("user_nickname")
            this.user_say = sessionStorage.getItem("user_say")
            this.sex = sessionStorage.getItem("sex")
            this.user_email = sessionStorage.getItem("user_email")
            this.user_birthday = sessionStorage.getItem("user_birthday")
            this.school_name = sessionStorage.getItem("school_name")
            this.last_login_time = sessionStorage.getItem("last_login_time")
            this.last_login_ip = sessionStorage.getItem("last_login_ip")
            // var timestamp4 = new Date(this.last_login_time);
            // timestamp4 = timestamp4.toLocaleDateString().replace(/\//g, "-") + " " + timestamp4.toTimeString().substr(0, 8)

            if(this.sex==1){
                this.usersex = '男'


            }else {
                this.sex = '女'
            }
            this.last_login_time = this.formatDateTime(this.last_login_time)
            this.user_birthday = this.formatDateTime(this.user_birthday)
            //console.log(timestamp4)
           //再利用拼接正则等手段转化为yyyy-MM-dd hh:mm:ss 格式

            console.log('begins:'+this.username)

        }
    }
</script>

<style>
    body{
    }
    .infos{
        text-align: left;
        margin-left: 60px;
    }
    .b{
        width: 700px;
        height: 80%;
    }
 .divcss{
           width:80%;
           height:80%;
           margin-left:20%;
       }.divpss{
            font-family: 'Avenir', Helvetica, Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            text-align: center;
            color: #2c3e50;
        }
</style>
