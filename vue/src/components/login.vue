<template>
    <div class="big">
    <div class="divp">
    <div class="divc">
        <el-card class="box-card">
     <el-row><h1>{{ msg }}</h1></el-row>
      <el-row>
          <el-tooltip content="学号或邮箱" placement="top">
          <el-input type="text" style="width:350px;" v-model="form.username" placeholder="账号" clearable></el-input>
          </el-tooltip>
      </el-row>
      <el-row>
          <el-tooltip content="密码不超过32个字符不少于6个字符" placement="top">
              <el-input type="password" style="width:350px;" v-model="form.password" placeholder="密码" clearable></el-input>
          </el-tooltip>

      </el-row>
            <el-row >
                <el-select v-model="form.schoolname" placeholder="请选择学校"
                           style="width:350px;">
                    <el-option
                            v-for="item in school_name"
                            :key="item"
                            :value="item"
                    >
                    </el-option>
                </el-select>
            </el-row>
      <el-row>
        <el-col :span="11">
            <el-checkbox v-model="checked">自动登录</el-checkbox>
        </el-col>
        <el-col :span="4">
<router-link to="/forget">忘记密码？
        </router-link>
        </el-col>
        <el-col :span="9">
 <router-link to="/register">注册
        </router-link>
        </el-col>
      </el-row>
      <el-button type="primary" style="width:350px;" @click="huoqu()">登录</el-button>
        </el-card>
    </div>
    </div>
    </div>
</template>
<script>
import cookies from 'js-cookie'
export default {
  name: 'login',
  data () {
    return {
        school_name:[],
        checked:true,
      msg: '分布式文件管理系统',
        form: {
            username: '',
            password: '',
            schoolname:'',
        },
    }
  },
  methods:{
      huoqu(){
          let formData = new FormData();
          formData.append('username',this.form.username);
          formData.append('password',this.form.password);
          formData.append('schoolname',this.form.schoolname)
          http.apipost('php/public/api/user/public/login',formData).then(res=>{console.log(res)
              if( res.code == 1) {
                  let token = res.data.token;
                  if(this.checked == true){
                      cookies.set('auto_login',token) //登录状态存进cookies
                  }
                  //根据store中set_token方法将token保存至localStorage/sessionStorage中，data["Authentication-Token"]，获取token的value值
                  try {
                      this.$store.commit('set_token', token["XX-Token"]);
                      this.$store.commit('set_last_login_time', res.data.user.last_login_time);
                      this.$store.commit('set_last_login_ip', res.data.user.last_login_ip);
                      this.$store.commit('set_user_email', res.data.user.user_email);
                      this.$store.commit('set_user_login', res.data.user.user_login);
                      this.$store.commit('set_user_nickname', res.data.user.user_nickname);
                      this.$store.commit('set_school_name', res.data.user.school_name);
                      this.$store.commit('set_sex', res.data.user.sex);
                      this.$store.commit('set_user_say', res.data.user.signature);
                      this.$store.commit('set_birthday', res.data.user.birthday);
                      this.$store.commit('set_token', token); //存token
                      this.$store.commit('set_user_type', res.data.user.user_type); //存token
                      let avatar = "http://centos3.huangdf.com/php/public/user/public/avatar/"
                      this.$store.commit('set_avatar', avatar+res.data.user.id);
                      if(this.$route.query.id){
                          this.$router.push('/share?id='+this.$route.query.id)
                      }else {
                          this.$router.push('/')
                      }
                  }catch (e) {
                      console.log("what happen"+e)
                  }
              }else{
                  this.$message.error('登录失败,'+res.msg);
              }
          })

  }
},    mounted(){
        /*
     * 进入页面加载数据
     * */if(cookies.get('auto_login') || sessionStorage.getItem('token')){   //检查用户所有状态
            this.$store.commit('set_token',cookies.get('auto_login'))
            this.$router.push('/')
        }else {
            this.$store.commit('set_token', '1')
            http.apiget('php/public/api/user/public/schools').then(res => {
                console.log(res.data.data[0])
                this.school_name = [...res.data.data];
            })
        }
    },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
  .el-row {
    margin-bottom: 30px;
  &:last-child {
     margin-bottom: 0;
   }
  }
  .divc{
    width:540px;
    height:470px;
    margin:0 auto;
      background-color: aliceblue;
  }.divp{
         font-family: 'Avenir', Helvetica, Arial, sans-serif;
         -webkit-font-smoothing: antialiased;
         -moz-osx-font-smoothing: grayscale;
         text-align: center;
         color: #2c3e50;
         margin-top: 60px;
     }.box-card{
       width:540px;
       height:470px;
               background-color:#F0F8FF;
          }
                      body{

                      }
</style>
