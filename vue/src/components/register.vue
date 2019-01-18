<template>
<div>
  <div class="divp">
  <div class="divc">
    <el-card class="box-card">
    <el-row>
      <el-col :span="24"><div><h1>{{msg}}</h1></div></el-col>
    </el-row>
    <el-row>
      <el-input type="text" style="width:350px;" v-model="form.username" placeholder="学号"></el-input>
    </el-row>
      <el-row>
      <el-input type="text" style="width:350px;" v-model="form.nickname" placeholder="姓名"></el-input>
    </el-row>
    <el-row>
      <el-input type="text" style="width:350px;" v-model="form.email" placeholder="邮箱"></el-input>
    </el-row>
    <el-row>
      <el-input type="password" style="width:350px;" v-model="form.userpass" placeholder="密码"></el-input>
      </el-row>
    <el-row>
        <el-input type="password" style="width:350px;" v-model="form.userpass2" placeholder="确认密码"></el-input>
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
        <el-button type="primary" style="width:350px;" @click="huoqu()">注册</el-button>
    </el-row>
      <router-link to="/school_register">注册学校管理员</router-link>
    </el-card>
  </div>
  </div>
</div>
</template>

<script>
export default {
  name: 'register',
  data () {
    return {
        school_name:[],
            msg: '分布式文件管理系统',
        form: {
            username: '',
            email:'',
            userpass: '',
            userpass2:'',
            schoolname:'',
            nickname:''
        },
    }

  },
    mounted(){
        this.$store.commit('set_token', '1')
        http.apiget('php/public/api/user/public/schools').then(res=>{
            console.log(res.data.data[0])
            this.school_name = [...res.data.data];
        })
        },
  methods:{
      huoqu(){
          let formData = new FormData();
          formData.append('username',this.form.username)
          formData.append('useremail',this.form.email)
          formData.append('password',this.form.userpass)
          formData.append('password2',this.form.userpass2)
          formData.append('schoolname',this.form.schoolname)
          formData.append('nickname',this.form.nickname)
           http.apipost('php/public/api/user/public/register',formData).then(res=>{console.log(res)
               if(res.code == 1){
                   this.$message.success(res.msg);
                   this.$router.push({path:'/login'});
               }else {
                   this.$message.error('注册失败:'+res.msg);
               }
           })
  }
}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .el-row {
    margin-bottom: 15px;
  &:last-child {
     margin-bottom: 0;
   }
  }
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 8px;
}
a {
  color: #42b983;
}
.divc{
    width:500px;
    height:540px;
  margin:0 auto;
  :center;
  }.divp{
     font-family: 'Avenir', Helvetica, Arial, sans-serif;
     -webkit-font-smoothing: antialiased;
     -moz-osx-font-smoothing: grayscale;
     text-align: center;
     margin-top: 60px;
   }.box-card{
      width:540px;
      height:600px;
    }
</style>
