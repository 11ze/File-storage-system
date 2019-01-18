<template>
    <div class="container" id="app">
        <!--左侧边栏-->
        <div class="aside">
            <h2 class="header">
                <a href="javascript:;">{{appName}}</a>
            </h2>
            <el-row >
                <el-menu
                        default-active="1"
                        class="el-menu-vertical-demo"
                >

                    <el-menu-item index="1" @click="index_public(0,false,false)">
                        <i class="el-icon-info"></i>
                        <span slot="title">公共文件</span>
                    </el-menu-item>
                    <el-menu-item index="2" @click="to_audit">
                        <i class="el-icon-question"></i>
                        <span slot="title">待审核</span>
                    </el-menu-item>
                    <el-menu-item index="3" @click="pass_file">
                        <i class="el-icon-success"></i>
                        <span slot="title">已通过</span>
                    </el-menu-item>
                    <el-menu-item index="4" @click="my_index">
                        <i class="el-icon-refresh"></i>
                        <span slot="title">我的网盘</span>
                    </el-menu-item>
                </el-menu>
            </el-row>
            <el-button v-if="this.user_type==1" type="success" style="margin-left: 30px" @click="goback()">管理员入口</el-button>
        </div>
        <!--右侧主区域内容-->
        <div >
            <div class="main">

                <!--顶部工具栏-->
                <div class="toolbar">
                    <div class="layout clearfix">

                        <div style="float: right;margin-right: 100px"><el-dropdown>
                            <img :src="this.avatar" style="width:35px; height:35px;margin-top:12px;border-radius: 8px"/>
                            <el-dropdown-menu slot="dropdown">
                                <el-dropdown-item ><el-button type="text" @click="aboutme()">个人资料</el-button></el-dropdown-item>
                                <el-dropdown-item ><el-button type="text" @click="forgets()">更改密码</el-button></el-dropdown-item>
                                <el-dropdown-item ><el-button type="text" @click="logout()">退出</el-button></el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown></div>
                    </div>

                </div>

                <!--主体内容-->
                <div class="main-body">

                    <div class="hd">

                        <div class="right clearfix">

                            <div class="action-wrap">
                                <div class="action-item" >
                                    <el-dropdown v-if="search_type =='all'">
                                        <el-button type="text">
                                            排序：{{sorting}}<i class="el-icon-arrow-down el-icon--right"></i>
                                        </el-button>
                                        <el-dropdown-menu slot="dropdown" >
                                            <el-dropdown-item><el-button type="text"  @click="changes('name')">名称</el-button></el-dropdown-item>
                                            <el-dropdown-item> <el-button type="text" @click="changes('size')">大小</el-button></el-dropdown-item>
                                            <el-dropdown-item><el-button type="text" @click="changes('time')">时间</el-button></el-dropdown-item>
                                        </el-dropdown-menu>
                                    </el-dropdown>
                                </div>
                            </div>

                            <div class="action-wrap">
                                <div @click="changeShowMode('list')" class="action-item" :class="{act:showMode=='list'}">
                                    <i class="icon icon-mod-list"></i>
                                    <span class="act-txt">列表</span>
                                </div>
                            </div>

                            <div class="action-wrap">
                                <div @click="changeShowMode('thumb')" class="action-item" :class="{act:showMode=='thumb'}">
                                    <i class="icon icon-mode-thumb"></i>
                                    <span class="act-txt">缩略图</span>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="list-wrap">


                        <!--列表头部-->
                        <div class="list-header clearfix">

                            <div class="col checkbox">
                                <i class="el-icon-refresh" @click=""></i>
                            </div>

                            <div class="col col-border name" style="display: block;">
                                <strong @click="updateto">刷新</strong>
                                <el-input placeholder="请输入搜索的标签" v-model="searchlable" style="width: 300px; float: right" class="input-with-select">
                                    <el-button slot="append" icon="el-icon-search" @click="search_file()"></el-button></el-input>
                                <el-input placeholder="请输入搜索的文件名" v-model="searchfile" style="width: 300px;float: right;text-align: right" class="input-with-select">

                                </el-input>
                            </div>



                        </div>
                        <!--列表头部end-->

                        <!--正文，缩略图-->
                        <el-card id="box" class="box">

                            <div v-if="showMode == 'thumb'" class="list-item-wrap list-item-wrap-thumb">


                                <ul class="list-item clearfix">
                                    <li v-for="file of otherFiles" class="item" >
                                        <div class="inner" @click="look_file(file)" @contextmenu="context(file)" v-contextmenu:contextmenu>


                                            <i class="icon-wrapper">

                                                <i v-if="file.type=='音乐'" class="icon icon-music"></i>
                                                <i v-else-if="file.type=='视频'" class="icon icon-video"></i>
                                                <i v-else-if="file.type=='文档'" class="icon icon-doc"></i>
                                                <i v-else-if="file.type=='图片'" class="icon icon-pic"></i>
                                                <i v-else class="icon icon-alls"></i>

                                            </i>
                                            <span  class="txt td">{{file.filename}}</span>
                                        </div>
                                        <i class="icon checkbox ":class="ischanges?'icon-checkbox-cur':'icon-checkbox'"></i>
                                        <i class="icon checkbox ":class="file.choose?'icon-checkbox-cur':'icon-checkbox'" @click="chooses(file)"></i>
                                    </li>
                                </ul>


                            </div>

                            <!--列表模式-->
                            <div v-else class="list-item-wrap list-item-wrap-list clearfix">
                                <el-table
                                        ref="multipleTable"
                                        :data=$store.state.public_file.slice((currentPage-1)*pagesize,currentPage*pagesize)
                                        tooltip-effect="dark"
                                        height="600"
                                        style="width: 100%"
                                        :row-class-name="tableRowClassName"
                                        @row-dblclick="look_file"
                                        @row-click="click_this"
                                        @selection-change="have_change"
                                        @row-contextmenu="click_this" v-contextmenu:contextmenu>
                                    <el-table-column
                                            type="selection"
                                            width="30">
                                    </el-table-column>
                                    <el-table-column
                                            prop="type"
                                            label="文件类型"
                                            width="100">

                                    </el-table-column>
                                    <el-table-column
                                            prop="filename"
                                            label="文件名"
                                            width="280">
                                    </el-table-column>
                                    <el-table-column
                                            prop="file_size"
                                            label="大小kb"
                                            width="280">
                                    </el-table-column>
                                    <el-table-column
                                            prop="create_time"
                                            label="修改日期"
                                            show-overflow-tooltip>
                                    </el-table-column>
                                </el-table>
                                <el-pagination
                                        background
                                        style="text-align: center"
                                        layout="prev, pager, next"
                                        @current-change="current_change"
                                        :total="1000">
                                </el-pagination>
                            </div>

                        </el-card>
                    </div>

                </div>
            </div>
        </div>

        <v-contextmenu ref="contextmenu" >
            <div >
                <v-contextmenu-item @click="look_thefile()">打开</v-contextmenu-item>
                <v-contextmenu-item @click="download_oss()">下载</v-contextmenu-item>
                <v-contextmenu-item @click="get_index()">保存</v-contextmenu-item>
                <v-contextmenu-item v-if="this.search_type==pass" @click="del_share()">取消分享到公有</v-contextmenu-item>

            </div>

        </v-contextmenu>

        <el-dialog title="保存文件" :visible.sync="dialogcopy_file">
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
                <el-button type="primary" @click="copy_file()">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import store from "../../assets/store";
    export default {
        name: "public_file",
        data(){
            return{
                ispublic:'',
                sorting:'',
                chosefile:[], //选择文件夹的存放数组
                chosefiles:[], //选择文件的存放数组
                ischange:false,  //显示是否选择
                ischanges:false, //显示是否选择
                searchfile:'',   //查找文件
                searchlable:'',
                search_type:'all',//处于那个分类
                input_rename:'',
                dialogmove_file:false,
                avatar:'',
                renameview:false,
                thefile:'',
                dialogcopy_file:false,
                chose_public_file:'',
                chose_list:[],
                the_share:false,
                the_share_ok:false,
                filename:'',
                selectedOptions:[],
                options:[],
                allcatalogid:[],
                allcatalogname:[],
                pagesize:10,//每页的数据条数
                currentPage:1,//默认开始页面
                dialogFormVisible: false,
                user_type:'',
                newfolder:'',
                appName: '分布式文件系统',
                showMode: 'thumb',
                // 显示的文件类型
                showType: 'all',
                // 类型与MIME的映射关系

            }
        },
        computed: {
            // 每一个计算属性都是一个函数，函数的返回值就是这个函数对应的属性的值，计算属性使用的时候，使用的是方法对应的属性

            otherFiles() {
                // console.log('全局文件'+store.state.files)
                let otherFiles = store.state.public_file.filter( file => file.type != '/' );
                if (this.showType == 'all') {
                    return otherFiles;
                } else {
                    return otherFiles.filter(file => this.MIMEMAPS[this.showType].includes(file.type));
                }
            }
        },
        methods:{
            download_oss(){
                let files = new FormData()
                console.log(this.thefile)
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
            updateto(){
              this.$router.go(0)
            },
            look_file(){

            },
            look_thefile() {//图片查看
                if(this.thefile.type=='/'){
                    let list = this.thefile
                    list = '/'+this.thefile.filename
                    this.nowpage(list)
                }else {
                    if(this.thefile.type == '图片') {
                        var thefile = this.thefile.oss_host + '/' + this.thefile.oss_file
                        console.log(thefile)
                        this.$alert('<div style="width: 390px;height: 390px"><img style="width: 100%;height: 100%" src="' + thefile + '" preview="0" preview-text="666"></div>', '查看图片', {
                            dangerouslyUseHTMLString: true
                        });
                    }
                    if (this.thefile.type == '音乐'){
                        this.audios[0].url = this.thefile.oss_host + '/' + this.thefile.oss_file
                        console.log(this.audios)
                        this.beginaudio = true
                    }
                    if (this.thefile.type == '视频'){
                        this.video.sources[0].src = this.thefile.oss_host + '/' + this.thefile.ossfile
                        console.log(this.video.sources[0])
                        this.beginvideo = true
                    }
                    if (this.thefile.suffix=='pdf'){
                        this.$store.state.pdf_file = this.thefile.oss_host + '/' + this.oss_file
                        this.$router.push('/pdf')

                    }
                    if (this.thefile.suffix=='xlsx' ||this.thefile.suffix=='doc'||this.thefile.suffix=='docx'|| this.thefile.suffix=='ppt'||this.thefile.suffix=='pptx'){
                        var fileurl = this.thefile.oss_host + '/' + this.thefile.oss_file
                        window.open("https://view.officeapps.live.com/op/view.aspx?src="+fileurl)

                    }
                }
            },
            del_share(){
              if(this.search_type = "pass"){
                  let file = new FormData()
                  file.append('files',this.thefile.id)
                  http.apipost('/php/public/api/file/public/to_private',file).then(res=>{
                      console.log(res)
                      if (res.code!=1){
                          this.$message.error('失败');
                      }else {
                          this.$message.success(res.msg)
                      }
                  })
              }else {
                  this.$message.error("错误")
              }
            },
            get_index(){
                http.apipost('/php/public/api/file/files/get_folder').then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取目录失败');
                    }else {
                        console.log(res.data)
                        this.options = res.data
                        this.dialogcopy_file  = true
                    }
                })

            },
            handleChange(value) {
                console.log(value);
                this.chose_list = value
            },
            copy_file(){
                let formdata = new FormData()
                if(this.thefile) {
                    console.log("已选择要保存到的文件"+this.thefile.id)
                    console.log("已选择要保存到的文件夹："+this.chose_list[this.chose_list.length-1])
                    formdata.append('files', this.thefile.id)
                    formdata.append('new_dir_id',this.chose_list[this.chose_list.length-1])
                    http.apipost('/php/public/api/file/files/copy_file',formdata).then(res=>{
                        console.log(res)
                        if (res.code!=1){
                            this.$message.error('失败');
                        }else {
                            this.$message.success(res.msg)
                            this.dialogcopy_file = false

                        }
                    })
                }else {
                    this.$message.warning("请选择文件!")
                }

            },
            context(file){
                this.filename = file.filename
                this.thefile = file
                console.log("已选："+this.thefile.create_time)
                this.chosefiles = []
                console.log(file)
                console.log(this.$store.state.public_file)
                this.$store.commit('set_filename',file.filename)

                for (let j=0;j<this.$store.state.public_file.length;j++){
                    this.$store.state.public_file[j].choose = false
                }
                file.choose = true
                var name = file.id
                this.chosefiles.push(name)
                console.log('已选择s：'+this.chosefiles)

            },
            goback(){
                window.open('http://centos3.huangdf.com/php/public/admin');
            },
            to_audit(){
                this.search_type = "no_pass"
                let formdata = new FormData()
                formdata.append('keyword',this.searchfile)
                http.apipost('/php/public/api/file/public/wait',formdata).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error(res.msg)
                    } else {
                        this.$store.commit('set_public_file', res.data)
                        this.$message.success("获取数据成功")
                    }
                })
            },
            pass_file(){
                this.search_type = "pass"
                let formdata = new FormData()
                formdata.append('keyword',this.searchfile)
                http.apipost('/php/public/api/file/public/me',formdata).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error(res.msg)
                    } else {
                        this.$store.commit('set_public_file', res.data)
                        for(let i=0;i<this.$store.state.public_file.length;i++){
                            this.$store.state.public_file[i].create_time = this.formatDateTime(this.$store.state.public_file[i].create_time)
                        }

                        this.$message.success("获取数据成功")
                    }
                })
            },
            tableRowClassName ({row, rowIndex}) {
                row.index = rowIndex;

            },
            current_change(currentPage){
                this.currentPage = currentPage;
            },
            click_this(row){   //表选择后的数据
                this.toggleSelection()
                this.onRowClick(row)
            },
            have_change(val){   //表选择变化触发
                this.chose_public_file = val
                console.log(this.chose_public_file)

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
            onRowClick (row) {
                //行点击消除new标记
                var index = row.index;
                this.toggleSelection([this.$store.state.public_file[index]])

            },
            /*
           * 检测处理用户选择了那些文件
           * */
            chooses(file){
                console.log(file)
                file.choose = !file.choose;
                if(file.choose==true){
                    this.$store.commit('set_filename',file.filename)
                    var name = file.id
                    this.chosefiles.push(name)
                }else{
                    for(let i in this.chosefiles) {
                        if(this.chosefiles[i]==file.id) {
                            this.chosefiles.splice(i, 1)
                        }
                    }
                }
                this.ischanges = !this.ischanges
                console.log('choose:'+file.choose+'ischange:'+this.ischanges)
                console.log('已选择：'+this.chosefiles)
            },
            index_public(key,order,tag){
                this.search_type = 'all'
                let formdata = new FormData()
                if(key){
                    formdata.append('keyword',key)
                }
                if(tag){
                    formdata.append('tagFind',tag)
                }
                if(order){
                    formdata.append('order',order)
                }
                http.apipost('/php/public/api/file/public/index',formdata).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error(res.msg)
                    } else {
                        this.$message.success("获取数据成功")
                        this.$store.commit('set_public_file', res.data)
                        for(let i=0;i<this.$store.state.public_file.length;i++){
                            this.$store.state.public_file[i].create_time = this.formatDateTime(this.$store.state.public_file[i].create_time)
                        }


                    }
                })
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
            search_file(){

                if(this.search_type == 'all'){
                    this.index_public(this.searchfile,false,false)
                }
                if(this.search_type == 'pass'){
                    this.pass_file()
                }
                if(this.search_type == 'no_pass'){
                    this.to_audit()
                }

            },
            changes(type){
                 this.index_public(false,type,false)

            },
            changeShowMode(type) {   //显示类型
                if(type=='thumb'){
                    this.index_public()
                }

                this.showMode = type;
            },
            my_index(){
                this.$router.push('/')
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
        },
        mounted(){
            /*
   * 进入页面加载数据
   * */if(!sessionStorage.getItem("token")){   //检查用户所有状态
                this.$message.error('请登录');
                this.$store.commit('del_token')
                this.$router.push('/login')
            }else {
                this.user_type = localStorage.getItem('user_type')
                this.avatar = sessionStorage.getItem("avatar")
                this.index_public(0)
            }
        }
    }
</script>

<style scoped>
    @import "../../assets/css/index.css";
    body {
        margin: 0;
        padding: 0;
    }    .clearfix:before,
         .clearfix:after {
             display: table;
             content: "";
             width: auto;
         }
    .clearfix:after {
        clear: both
    }.newfo{
         position: relative;
         float: left;
         margin: 14px 16px 0 0;
         padding: 0 20px;
         border-radius: 2px;
         cursor: pointer;
         height: 34px;
         line-height: 34px;
     }.box{
          height: 700px;
      }  .el-row {
             margin-bottom: 30px;
    &:last-child {
         margin-bottom: 0;
     }
    }
</style>
