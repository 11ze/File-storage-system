<template>
    <div>
<div style="width: 1200px;height: 60px">
            <el-button type="primary" style="margin-top:10px;" @click="gotoindex" plain>我的网盘</el-button>
            <el-button type="primary" style="margin-top:10px;" @click="isdialogsave_file()" plain>保存到网盘</el-button>
            <el-button type="primary" @click="download_this" plain>下载</el-button>

                <a href="javascript:void(0)" @click="goto_nav('0')" >全部文件></a>
            <a class="item all" v-for="list in this.$store.state.share_get_nav">
                <a href="javascript:void(0)" @click="goto_nav(list.id)"> {{list.filename}}> </a>
            </a>

            <div style="float: right;margin-right: 200px;">
                <a style="float: right;margin-top:20px;">浏览次数：{{view_count}}</a>
                <a>分享用户：</a>
                <img :src="avatar" style="width:23px; height:23px;margin-top:20px;"/>
                <a>{{user_nickname}} </a>
           </div>
</div>

        <!--主体内容-->

        <el-card  style="width: 1200px">
            <el-table
                    ref="multipleTable"
                    :data=$store.state.share
                    tooltip-effect="dark"
                    height="600"
                    style="width: 100%"
                    :row-class-name="tableRowClassName"
                    @row-click="click_this"
                    @selection-change="have_change"
                    @row-dblclick="dbclick"
                    @row-contextmenu="click_this" v-contextmenu:contextmenu>
                <el-table-column
                        type="selection"
                        width="50">
                </el-table-column>
                <el-table-column
                        prop="type"
                        label="文件类型"
                        width="150">

                </el-table-column>
                <el-table-column
                        prop="filename"
                        label="文件名"
                        width="300">
                </el-table-column>
                <el-table-column
                        prop="file_size"
                        label="大小"
                        width="300">
                </el-table-column>
                <el-table-column
                        prop="create_time"
                        label="修改日期"
                        show-overflow-tooltip>
                </el-table-column>

            </el-table>

            <v-contextmenu ref="contextmenu" >

                <v-contextmenu-item @click="look_thefile">打开</v-contextmenu-item>
                <v-contextmenu-item @click="download_oss">下载</v-contextmenu-item>

            </v-contextmenu>
        </el-card>
        <el-dialog title="保存到" :visible.sync="dialogsave_file">
            <div class="block">
                <span class="demonstration">要保存到的文件夹</span>
                <el-cascader
                        :options="options"
                        change-on-select
                        v-model="selectedOptions"
                        @change="handleChange">
                </el-cascader>
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="save_file()">确 定</el-button>
            </div>
        </el-dialog>
</div>
</template>

<script>
    export default {
        name: "share_file",
        data(){
            return{
                check_id:[],
                check_ids:[],
                check_all_id:'',
                showIndexArr:[],
                share_list_id:'',
                dialogsave_file:false,
                options:[],
                selectedOptions:[],
                chose_list:[],
                chose:[],
                view_count:'',//浏览次数
                avatar:','

            }
        },
        methods:{
            download_oss(){
                let files = new FormData()
                console.log(this.check_id)
                files.append('files',this.thefile.id)
                http.apipost('/php/public/api/file/files/download',files).then(res=>{
                    if(res.code == 1){
                        console.log(res)
                        console.log(res.data.region)
                        console.log(res.data.accessKeyId)
                        console.log(res.data.accessKeySecret)
                        console.log(res.data.bucket)

                        let OSS = require('ali-oss');

                        let client = new OSS({
                            region: res.data.region,
                            accessKeyId: res.data.accessKeyId,
                            accessKeySecret: res.data.accessKeySecret,
                            bucket: res.data.bucket
                        });

                        let url = client.signatureUrl(this.thefile.oss_file,{expires: 3600});
                        console.log(url);
                        let download = require("downloadjs")
                        download(url);
                    }
                })
            },
            gotoindex(){
              this.$router.push('/')
            },
            save_file(){
                for(let i=0;i<this.check_id.length;i++){
                    console.log(this.check_id[i].id)
                    this.chose.push(this.check_id[i].id)
                }
                let file_list = new FormData();
                console.log("已选择的文件："+this.chose)
                console.log("保存的地方："+this.chose_list[this.chose_list.length-1])
                file_list.append('files',this.chose)
                file_list.append('new_dir_id',this.chose_list[this.chose_list.length-1])
                http.apipost('/php/public/api/file/files/copy_file',file_list).then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('保存失败');
                    }else {
                        this.dialogsave_file  = false
                        this.$message.success('保存成功');
                        this.chose = []
                    }
                })
            },
            handleChange(value) {
                console.log(value);
                this.chose_list = value
            },
            isdialogsave_file(){
                if(this.chose_list ){
                    console.log(this.chose_list)
                http.apipost('/php/public/api/file/files/get_folder').then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取目录失败');
                    }else {
                       console.log(res.data)
                       this.options = res.data

                       this.dialogsave_file = true
                    }
                })
                }else {
                    this.$message.warning("请选择保存的文件或文件夹")
                }
            },
            download_this(){


                for(let i=0;i<this.check_id.length;i++){
                    console.log(this.check_id[i])
                    window.open(this.check_id[i].oss_host+'/'+this.check_id[i].oss_file);
                }
            },
            tableRowClassName ({row, rowIndex}) {
                //把每一行的索引放进row
                row.index = rowIndex;
            },
            onRowClick (row) {
                //行点击消除new标记
                var index = row.index;
                this.toggleSelection([this.$store.state.share[index]])

            },

            goto_nav(dir_id){
                console.log("传过来的文件夹id:"+dir_id)
                let get_nav = new FormData();
                get_nav.append('dir_id',dir_id);
                get_nav.append('share_id',this.share_list_id)
                http.apipost('php/public/api/file/share/get_share_nav',get_nav).then(res=>{
                    console.log(res)
                    if(res.code ==1){
                        this.$store.commit('set_share_get_nav',res.data)
                        console.log(res.data)
                    }
                })

                let formData = new  FormData()
                if(dir_id =='0') {  //导航选择全部文件
                    console.log("选择全部")
                    this.nav_all_file()
                }else{
                    formData.append('dir_id',dir_id)
                    http.apipost('/php/public/api/file/share/read', formData).then(res => {
                        console.log(res)
                        if (res.code != 1) {
                            this.$message.error(res.msg)
                        } else {
                            this.$message.success("获取数据成功")
                            this.$store.commit('set_share',res.data)

                        }
                    })
                }
            },
            nav_all_file(){
                this.share_all_file()
            },
            share_all_file(){
                let formData = new  FormData()
                console.log("收到："+this.$route.query.id)
                let ids = this.$route.query.id

                formData.append('id',ids)
                http.apipost('/php/public/api/file/share/get_share_file', formData).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error(res.msg)
                    } else {
                        this.$message.success("获取数据成功")
                        this.view_count = res.data.view_count
                        this.$store.commit('set_share',res.data.files)
                        this.avatar = res.data.user_info.avatar
                        this.user_nickname = res.data.user_info.user_nickname
                        this.share_list_id = res.data.id

                    }
                })
            },


            have_change(val){
                this.check_id = val
                console.log(this.check_id)
            },
            goto_list(row){
                console.log(row.type)
                    let get_nav = new FormData();
                    console.log("ss"+row)
                    get_nav.append('share_id',this.share_list_id)
                    get_nav.append('dir_id', row.id);
                    http.apipost('php/public/api/file/share/get_share_nav', get_nav).then(res => {
                        console.log(res)
                        if (res.code == 1) {
                            this.$store.commit('set_share_get_nav', res.data)
                            console.log(res.data)
                        }
                    })
                    let formData = new FormData();
                    formData.append('dir_id', row.id);
                    console.log("要进入文件夹的id:" + row.id)
                    http.apipost('/php/public/api/file/share/read', formData).then(res => {
                        console.log(res)
                        this.$store.commit('set_share', res.data)
                    })

                },
            dbclick(row){
                this.goto_list(row)
            },
            click_this(row){
                this.toggleSelection()
                    this.onRowClick(row)

            },
            toggleSelection(rows) {
                if (rows) {
                    rows.forEach(row => {
                        this.$refs.multipleTable.toggleRowSelection(row);
                    });
                } else {
                    this.$refs.multipleTable.clearSelection();
                }
            },

            // check_all(selection){
            //     if(selection !='') {
            //         this.check_id = selection
            //         console.log(this.check_id)
            //     }else {
            //         console.log("取消全选")
            //     }
            // },

            look_thefile() {//图片查看

                console.log(this.check_id[0].type)
                // if(row.type=='/'){
                //     let list = this.thefile
                //     list = '/'+this.thefile.filename
                //     this.nowpage(list)
                // }else {
                //     if(this.thefile.type == '图片') {
                //         var thefile = this.thefile.oss_host + '/' + this.thefile.oss_file
                //         console.log(thefile)
                //         this.$alert('<div style="width: 390px;height: 390px"><img style="width: 100%;height: 100%" src="' + thefile + '" preview="0" preview-text="666"></div>', '查看图片', {
                //             dangerouslyUseHTMLString: true
                //         });
                //     }
                //     if (this.thefile.type == '音乐'){
                //         this.audios[0].url = this.thefile.oss_host + '/' + this.thefile.oss_file
                //         console.log(this.audios)
                //         this.beginaudio = true
                //     }
                //     if (this.thefile.type == '视频'){
                //         this.video.sources[0].src = this.thefile.oss_host + '/' + this.thefile.ossfile
                //         console.log(this.video.sources[0])
                //         this.beginvideo = true
                //     }
                //     if (this.thefile.suffix=='pdf'){
                //         this.$store.state.pdf_file = this.thefile.oss_host + '/' + this.oss_file
                //         this.$router.push('/pdf')
                //
                //     }
                //     if (this.thefile.suffix=='xlsx' ||this.thefile.suffix=='doc'||this.thefile.suffix=='docx'|| this.thefile.suffix=='ppt'||this.thefile.suffix=='pptx'){
                //         var fileurl = this.thefile.oss_host + '/' + this.thefile.oss_file
                //         window.open("https://view.officeapps.live.com/op/view.aspx?src="+fileurl)
                //
                //     }
                // }
                    },
            /*
* 用户退出登录的函数
* */
            logout(){       //退出登录
                http.apiget('php/public/api/user/public/logout').then(res=>{console.log(res)
                    if(res.data.code == 1) {
                        cookies.set('name','')
                        cookies.set('auto_login','')
                        this.$store.commit('del_token');
                        this.$message.success(res.data.msg);
                        this.$router.push('/login')
                    }else {
                        this.$message.error("退出失败");
                    }
                })
            },
            /**
             *个人信息入口
             */
            aboutme(){
                this.$router.push('/userinfo')
            },
            /**
             *修改密码入口
             */
            forgets(){
                this.$router.push('/forget')
            },
        },
        mounted(){

            if(!sessionStorage.getItem("token")){   //检查用户所有状态
                this.$message.error('请登录');
                this.$router.push('/login')
            }else {
              this.share_all_file()
            }
        }
    }
</script>

<style scoped>

</style>
