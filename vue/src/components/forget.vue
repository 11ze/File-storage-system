<template>
    <div class="divp">
    <div class="divc">
        <el-card class="box-card">
       <el-row> <h1>{{msg}}</h1></el-row>
        <el-row>
            <el-input type="text" style="width:350px;" v-model="form.useremail" placeholder="邮箱"></el-input>
        </el-row>
        <el-row>
            <el-input type="text" style="width:230px;" v-model="form.code" placeholder="输入验证码"></el-input>
            <el-button v-if="setnow==false" @click="getverifi()">{{count}}</el-button>
            <el-button v-else="setnow==true" disabled>{{count}}</el-button>
        </el-row>
        <el-row>
            <el-input type="password" style="width:350px;" v-model="form.newpassword" placeholder="新密码"></el-input>
        </el-row>
            <el-row>
            <el-input type="password" style="width:350px;" v-model="form.newpasswords" placeholder="确定新密码"></el-input>
        </el-row>
        <el-row>
            <el-button style="width:350px;"  type="primary" @click="updatakey()">确定</el-button>
        </el-row>
        </el-card>
    </div>
    </div>
</template>

<script>
    export default {
        name: "forget",
        data(){
            return{
                setnow:false,
                count:"发送验证码",
                thetime:60,
                form:{
                    useremail:'',
                    code:'',
                    newpassword:'',
                    newpasswords:''
                },
              msg:'分布式文件管理系统'
            }
        },
        methods:{
            getverifi(){
                let formData = new FormData();
                formData.append('username',this.form.useremail);
                console.log('获取验证码',formData)
                http.apipost('php/public/api/user/verification_code/send',formData).then(res=>{console.log(res)
                    if(res.code == 1){
                        this.$message.success(res.msg);
                        this.setnow = true
                        let clock = window.setInterval(() => {
                            this.thetime--
                            this.count = this.thetime + 's后重新发送'
                            if (this.thetime < 0) {
                                window.clearInterval(clock)
                                this.count = '重新发送验证码'
                                this.thetime = 60
                                this.setnow = false //这里重新开启
                            }
                        }, 1000)

                    }else {
                        this.$message.error(res.msg)
                    }
                })
},
            updatakey() {
                if (this.form.newpassword == this.form.newpasswords) {
                    let forData = new FormData();
                    forData.append('useremail', this.form.useremail)
                    forData.append('password', this.form.password)
                    forData.append('code', this.form.code)
                    // data.useremail = this.form.useremail
                    // data.password = this.form.newpassword
                    // data.code = this.form.code
                    // console.log(data)
                    http.apipost('php/public/api/user/public/passwordReset', forData).then(res => {
                        console.log(res)
                        if (res.code == 1) {
                            this.$message.success(res.msg)
                            this.$router.replace('/login');
                        } else {
                            this.$message.error(res.msg)
                        }
                    })
                }else {
                    this.$message.warning("密码不一致！")
                }
            }
        }
    }
</script>

<style scoped>
    .el-row {
        margin-bottom: 20px;
    &:last-child {
         margin-bottom: 0;
     }
    }
    .divc{
        overflow:auto;
        width:520px;
        height:500px;
        margin:0 auto;
    }.divp{
         font-family: 'Avenir', Helvetica, Arial, sans-serif;
         -webkit-font-smoothing: antialiased;
         -moz-osx-font-smoothing: grayscale;
         text-align: center;
         margin-top: 60px;
     }.box-card{
          width:500px;
          height:450px;
      }
</style>
