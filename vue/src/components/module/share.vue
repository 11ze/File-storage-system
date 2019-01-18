<template>
    <div>
    <div>
        <el-card class="cards">
            <image :src="avatars"></image>
            <a>用户：{{user_nickname}} 分享</a>
          <div style="text-align: center;line-height: 200px">
              提取码：
                <el-input
                        style="width: 200px"
                        placeholder="请输入提取码"
                        v-model="input_code"
                        clearable>
                </el-input>
            <el-button type="primary" @click="code_function()" plain>提 取</el-button>
          </div>
        </el-card>
    </div>
    </div>
</template>

<script>
    export default {
        name: "share",
        data(){
            return{
                input_code:'',
                code_url:'',
                user_nickname:'',//分享用户
                avatars:"",//用户头像

            }
        },
        computed: {

        },
        methods:{
            code_function(){
                if(this.input_code == this.code_url){
                    this.$message.success("提取码正确！")
                    this.$router.push({
                        path: '/share_file',
                        query: {
                            id: this.$route.query.id
                        }
                    })

                }else {
                    this.$message.error("提取码错误！")
                }

            },

        },
        mounted(){
                let formData = new  FormData()
                console.log("收到："+this.$route.query.id)
                let ids = this.$route.query.id

                formData.append('id',ids)
                http.apipost('/php/public/api/file/share/get_share_file', formData).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error(res.msg)
                    } else {
                        if(res.data.code =='') {
                            this.$router.push({
                                path: '/share_file',
                                query: {
                                    id: this.$route.query.id
                                }
                            })
                             //提取码
                        }else {
                            this.$message.success("获取数据成功" )
                            this.user_nickname = res.data.user_info.user_nickname
                            this.avatars = res.data.user_info.avatar
                            this.code_url = res.data.code
                            this.$store.commit('set_share',res.data.files)
                        }

                    }
                })
    //进入页面时从后台获取用户所有文件
        }
    }
</script>

<style scoped>
    .el-header, .el-footer {
        background-color: #B3C0D1;
        color: #333;
        text-align: center;
        line-height: 60px;
    }



    .el-main {
        background-color: #E9EEF3;
        color: #333;
        text-align: center;
        line-height: 600px;
    }



    .el-container:nth-child(5) .el-aside,
    .el-container:nth-child(6) .el-aside {
        line-height: 260px;
    }

    .el-container:nth-child(7) .el-aside {
        line-height: 320px;
    } .cards {
         margin-top:150px;
        margin-left: 100px;
        text-align: center;
          height: 300px;
        width: 800px;
      }

</style>
