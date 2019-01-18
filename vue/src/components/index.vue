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
                    <el-menu-item index="9" @click="public_file()">
                        <i class="el-icon-info"></i>
                        <span slot="title">公共文件</span>
                    </el-menu-item>
                    <el-menu-item index="1" @click="changeShowType('all')">
                        <i class="el-icon-menu"></i>
                        <span slot="title">全部</span>
                    </el-menu-item>

                    <el-menu-item index="2" @click="class_file('文档')">
                        <i class="el-icon-document"></i>
                        <span slot="title">文档</span>
                    </el-menu-item>
                    <el-menu-item index="3" @click="class_file('图片')">
                        <i class="el-icon-picture"></i>
                        <span slot="title"> 图片</span>
                    </el-menu-item>
                    <el-menu-item index="4" @click="class_file('视频')">
                        <i class="el-icon-view"></i>
                        <span slot="title"> 视频</span>
                    </el-menu-item>
                    <el-menu-item index="5" @click="class_file('音乐')">
                        <i class="el-icon-minus"></i>
                        <span slot="title">音乐</span>
                    </el-menu-item>
                    <el-menu-item index="6" @click="class_file('其他')">
                        <i class="el-icon-more"></i>
                        <span slot="title">其他</span>
                    </el-menu-item>
                    <el-menu-item index="7" @click="my_share()">
                        <i class="el-icon-share" ></i>
                        <span slot="title">我的分享</span>
                    </el-menu-item>
                    <el-menu-item index="8" @click="the_recycle()">
                        <i class="el-icon-delete" ></i>
                        <span slot="title">我的回收站</span>
                    </el-menu-item>

                </el-menu>
            </el-row>
            <el-button  type="primary" plain style="margin-left: 50px" @click="isopen_lable =true">标签管理</el-button>
            <el-button v-if="this.user_type==1" type="success" style="margin: 50px" @click="goback()">管理员入口</el-button>
        </div>
        <!--右侧主区域内容-->
        <div v-if="ismy_share ==false">
        <div class="main">

            <!--顶部工具栏-->
            <div class="toolbar">
                <div class="layout clearfix">

                    <label v-if="ismy_recycle == false">
                        <button id="files" @click="dialogFormVisible = true"   style="display:none"></button>
                        <div  class="action-wrap action-wrap-upload" >
                            <div class="action-item">
                                <i class="icon icon-upload-s"></i>
                                <span class="act-txt">上传</span>
                            </div>
                        </div>
                    </label>
                    <label v-if="ismy_recycle == false" >
                        <button @click="clicknew()" style="display:none"></button>
                        <div class="action-wrap">
                            <div class="action-item">
                                <i class="icon icon-add"></i>
                                <span class="act-txt"> 新建</span>
                            </div>
                        </div>
                    </label>

                    <div v-if="this.$store.state.uploaderview==true" class="newfo">
                        <div class="action-item">
                            <upfolder ></upfolder>
                        </div>
                    </div>
                    <div v-else class="newfo"  style="display:none">
                        <div class="action-item">
                            <upfolder></upfolder>
                        </div>
                    </div>


                    <div v-if="(this.chosefile!=''||this.chosefiles!='')&&this.ismy_recycle==false" class="action-wrap" @click="recycle_file()" >

                        <div class="action-item">
                            <i class="icon icon-trash"></i>
                            <span class="act-txt">回收站</span>
                        </div>
                    </div>

                    <div v-if="this.ismy_recycle==true&&(this.chosefile!=''||this.chosefiles!='')" class="action-wrap" @click="restore_file()" >

                        <div class="action-item">
                            <i class="icon icon-sort"></i>
                            <span class="act-txt">还原</span>
                        </div>
                    </div>
                    <div v-if="this.ismy_recycle==true&&(this.chosefile!=''||this.chosefiles!='')" class="action-wrap" @click="delect()" >

                        <div class="action-item">
                            <i class="icon icon-trash"></i>
                            <span class="act-txt">彻底删除</span>
                        </div>
                    </div>

                    <div v-if="(this.chosefile!=''||this.chosefiles!='')&&this.ismy_recycle==false" class="action-wrap" @click="the_share = true" >

                        <div class="action-item">
                            <i class="icon el-icon-share"></i>
                            <span class="act-txt">分享</span>
                        </div>
                    </div>
                    <div v-if="(this.chosefile!=''||this.chosefiles!='')&&this.ismy_recycle==false" class="action-wrap" @click="isdialogmove_file()" >

                        <div class="action-item">
                            <span class="act-txt">移动</span>
                        </div>
                    </div>
                    <div v-if="(this.chosefile!=''||this.chosefiles!='')&&this.ismy_recycle==false" class="action-wrap" @click="isdialogcopy_file()" >

                        <div class="action-item">
                            <span class="act-txt">复制</span>
                        </div>
                    </div>

                    <div style="float: right;margin-right: 100px"><el-dropdown>
                        <img :src="avatar" style="width:35px; height:35px;margin-top:12px;border-radius: 8px"/>
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

                        <div class="action-wrap" v-if="ismy_recycle == false">
                            <div class="action-item" >
                                <el-dropdown>
                                    <el-button type="text">
                                       排序：{{sorting}}<i class="el-icon-arrow-down el-icon--right"></i>
                                    </el-button>
                                    <el-dropdown-menu slot="dropdown" >
                                        <el-dropdown-item><el-button type="text"  @click="changes('filename')">名称</el-button></el-dropdown-item>
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

                    <ul class="breadcrumb clearfix" v-if="ismy_recycle == false">

                        <li class="item all">
                            <a href="javascript:void(0)" @click="goto_nav('0')" >全部文件</a>
                        </li>
                        <li class="item all" v-for="list in this.$store.state.get_nav">
                            <i class="icon icon-bread-next"></i>
                            <a href="javascript:void(0)" @click="goto_nav(list.id)">{{list.filename}} </a>
                        </li>

                    </ul>
                </div>

                <div class="list-wrap">


                    <!--列表头部-->
                    <div class="list-header clearfix" >

                        <div class="col checkbox">
                            <!--icon-checkbox,icon-checkbox-hover,icon-checkbox-cur-->
                            <i class="icon checkbox " :class="this.alls==true?'icon-checkbox-cur':'icon-checkbox'" @click="choose_all()"></i>
                            <!--<i class="icon checkbox ":class="ischange?'icon-checkbox-cur':'icon-checkbox'"></i>-->

                        </div>

                        <div class="col col-border name" style="display: block;">
                            <strong>全选文件</strong>
                            <a v-if="ismy_recycle == false">
                            <el-input placeholder="请输入搜索的标签" v-model="searchlable" style="width: 300px; float: right" class="input-with-select">
                                <el-button slot="append" icon="el-icon-search" @click="search_file()"></el-button></el-input>
                            <el-input placeholder="请输入搜索的文件名" v-model="searchfile" style="width: 300px;float: right;text-align: right" class="input-with-select">

                            </el-input>
                            </a>
                        </div>



                    </div>
                    <!--列表头部end-->

                    <!--正文，缩略图-->
                    <el-card id="box" class="box">

                        <div v-if="showMode == 'thumb'" class="list-item-wrap list-item-wrap-thumb">

                            <ul class="list-item clearfix">

                                <li class="item" v-for="file of folderFiles" >

                                    <div class="inner" @click="myfunction(file)" @contextmenu="context(file)" v-contextmenu:contextmenu>

                                        <i class="icon-wrapper">
                                            <i class="icon icon-file-l"></i>
                                            <!--文件夹的显示-->
                                        </i>
                                        <span title="a4" class="txt td">{{file.filename}}</span>
                                    </div>
                                    <i class="icon checkbox ":class="ischange?'icon-checkbox-cur':'icon-checkbox'"></i>
                                    <i class="icon checkbox " :class="file.choose?'icon-checkbox-cur':'icon-checkbox'" @click="choose(file)"></i>

                                </li>
                            </ul>

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
                                    :data=$store.state.files.slice((currentPage-1)*pagesize,currentPage*pagesize)
                                    tooltip-effect="dark"
                                    height="600"
                                    style="width: 100%"
                                    :row-class-name="tableRowClassName"
                                    @selection-change="have_change"
                                    @row-dblclick="dbclick"
                                    @row-click="click_this"
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
        <div v-else>

            <el-card>
                <el-table
                        ref="multipleTable"
                        :data="my_all_share"
                        tooltip-effect="dark"
                        style="width: 100%"
                        :row-class-name="tableRowClassName"
                        @row-click="click_this"
                        @selection-change="have_change"
                        @row-contextmenu="click_this" v-contextmenu:contextmenus>
                    <el-table-column
                            type="selection"
                            width="55">
                    </el-table-column>
                    <el-table-column
                            prop="name"
                            label="分享文件"
                            width="250">
                    </el-table-column>
                    <el-table-column
                            prop="view_count"
                            label="浏览次数"
                            width="150">
                    </el-table-column>
                    <el-table-column
                            prop="share_time"
                            label="分享时间"
                            width="250">
                    </el-table-column>
                    <el-table-column
                            prop="dead_time"
                            label="过期时间"
                            width="250">
                    </el-table-column>
                </el-table>
                <v-contextmenu ref="contextmenus" >

                    <v-contextmenu-item @click="look_share">查看</v-contextmenu-item>
                    <v-contextmenu-item @click="del_share">取消分享</v-contextmenu-item>

                </v-contextmenu>

            </el-card>
        </div>
        <el-dialog title="上传文件" :visible.sync="dialogFormVisible">
        <plupload></plupload>
        <div slot="footer" class="dialog-footer">
            <el-button  type="primary" @click="uploadwait()">关闭</el-button>
        </div>
    </el-dialog>

        <el-dialog title="标签管理" :close-on-click-modal="false"  :show-close="false" :visible.sync="isopen_lable">
            <lables></lables>

        </el-dialog>

        <el-dialog title="移动文件" :visible.sync="dialogmove_file">
            <div class="block">
                <span class="demonstration">要移动到的文件夹</span>
                <el-cascader
                        :options="options"
                        change-on-select
                        v-model="selectedOptions"
                        @change="handleChange">
                </el-cascader>
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="move_file()">确 定</el-button>
            </div>
        </el-dialog>

        <el-dialog title="复制文件" :visible.sync="dialogcopy_file">
            <div class="block">
                <span class="demonstration">要复制到的文件夹</span>
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

        <el-dialog title="文件标签管理"  :close-on-click-modal="false"  :show-close="false" :visible.sync="istable">


            <el-container>
                <el-main>   <el-tag
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
                    <el-button v-else class="button-new-tag" size="small" @click="showInput">增加标签</el-button></el-main>
            </el-container>


            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="save_table">确 定</el-button>
                <el-button type="primary" @click="del_lable">取 消</el-button>
            </div>
        </el-dialog>
        <el-dialog title="播放音频"  width="50%" :close-on-click-modal="false"  :show-close="false" :visible.sync="beginaudio">
            <VueAudio :theUrl="this.audios[0].url" :theControlList="this.audios[0].controlList"/>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="overfile()">关 闭</el-button>
            </div>
        </el-dialog>
        <el-dialog title="播放视频" width="65%" :close-on-click-modal="false"  :show-close="false" :visible.sync="beginvideo">
            <a>点击下方空白处下载</a>
            <my-video :sources="video.sources" :options="video.options"></my-video>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="overfile()">关 闭</el-button>
            </div>
        </el-dialog>

        <el-dialog title="重命名" :visible.sync="renameview">
            <el-input
                    placeholder="请输入内容"
                    v-model="input_rename"
                    clearable>
            </el-input>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="rename_file()">确 定</el-button>
            </div>
        </el-dialog>
        <el-dialog title="分享" :visible.sync="the_share">
            <a>分享的文件：{{$store.state.filename}}</a>
            <el-tabs v-model="activeName" >
                <el-tab-pane label="分享到私有" name="first">

                        <el-row>
                            <a>
                            有无提取码：
                            </a>
                            <el-radio v-model="the_code" label="1">有提取码</el-radio>
                            <el-radio v-model="the_code" label="2">无提取码</el-radio>
                        </el-row>
                    <el-row>
                        <a>有效期：</a>
                        <el-select v-model="value" placeholder="请选择">
                            <el-option
                                    v-for="item in the_data"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </el-row>

                    <el-button  type="primary" @click="to_share()">创建分享链接</el-button>
                    <el-button  type="primary" @click="the_share= false">取消</el-button>
                </el-tab-pane>
            </el-tabs>
        </el-dialog>

        <el-dialog title="分享成功" :visible.sync="the_share_ok">

            <div class="wxsmallcode-page publicCon">
                <div class="copyBox">
                    <el-row>
                        链接：
                    <el-input v-model="link_share" :disabled="true"></el-input>
                        <a v-if="this.link_share_code != ''">
                    提取码：<el-input  v-model="link_share_code" :disabled="true"></el-input></a>
                    </el-row>
                    <el-button class="ml10" type="primary" size="medium"
                               v-clipboard:copy="link_share_all"
                               v-clipboard:success="onCopy"
                               v-clipboard:error="onError">点击复制</el-button>
                </div>
                </div>
        </el-dialog>


        <v-contextmenu ref="contextmenu" >
            <div v-if="this.ismy_recycle==false">
            <v-contextmenu-item @click="look_thefile()">打开</v-contextmenu-item>
            <v-contextmenu-item @click="download_oss()">下载</v-contextmenu-item>
            <v-contextmenu-item @click="the_share = true">分享</v-contextmenu-item>
            <v-contextmenu-item @click="share_public">分享公共</v-contextmenu-item>
            <v-contextmenu-item @click="isdialogmove_file()">移动</v-contextmenu-item>
            <v-contextmenu-item @click="isdialogcopy_file()">复制</v-contextmenu-item>
            <v-contextmenu-item @click="table_set()">标签管理</v-contextmenu-item>
            <v-contextmenu-item @click="renameview = true">重命名</v-contextmenu-item>
            <v-contextmenu-item @click="recycle_file()">删除</v-contextmenu-item>
            </div>
            <div v-else>
                <v-contextmenu-item @click="restore_file()">还原</v-contextmenu-item>
                <v-contextmenu-item @click="delect">彻底删除</v-contextmenu-item>
            </div>
        </v-contextmenu>

    </div>
</template>
<script>
    import cookies from 'js-cookie'
    import store from "../assets/store";
    import VueAudio from './module/VueAudio'
    import myVideo from './module/video'
    export default {
        name: "index",
        components:{
            VueAudio,
            myVideo
        },
        inject: ['reload'],
        data(){
            return{
                sorting:'名称',
                dynamicTags: [],
                inputVisible: false,
                inputValue: '',
                istable:false,
                alls:false,
                check_share_file_index:[],  //分享文件的选择数组
                check_all_file_index:[],//我的所有文件的选择数组
                ismy_share:false,
                ismy_recycle:false,
                avatar:'',
                my_all_share:[],
                activeName: 'first',
                the_code:'2',
                link_share:'',
                link_share_all:'',
                link_share_code:'无',
                chosefile:[], //选择文件夹的存放数组
                chosefiles:[], //选择文件的存放数组
                ischange:false,  //显示是否选择
                ischanges:false, //显示是否选择
                searchfile:'',   //查找文件
                searchlable:'',
                calss_list:'',//处于那个分类
                input_rename:'',
                dialogmove_file:false,
                renameview:false,
                thefile:'',
                chose_list:[],
                isopen_lable:false,
                the_share:false,
                the_share_ok:false,
                filename:'',
                dialogcopy_file:false,
                allcatalogid:[],
                allcatalogname:[],
                pagesize:10,//每页的数据条数
                currentPage:1,//默认开始页面
                dialogFormVisible: false,
                beginaudio:false,
                beginvideo:false,
                recycle:false,
                user_type:'',
                newfolder:'',
                appName: '分布式文件系统',
                showMode: 'thumb',
                // 显示的文件类型
                showType: 'all',
                // 类型与MIME的映射关系
                the_data:[{
                    value: '0',
                    label: '永久有效'
                }, {
                    value: '7',
                    label: '7天'
                }, {
                    value: '1',
                    label: '1天'
                }],
                value: '0',
                MIMEMAPS: {
                    doc: ['text/html','text/css'],
                    pic: ['image/png', 'image/gif'],
                    music: ['audio/mp3'],
                    video: ['video/mp4']
                },
                audios: [
                    {
                        url: '',
                        controlList: 'onlyOnePlaying'
                    },

                ]
                ,
                video:{
                    sources: [{
                        src: '',
                        type: 'video/mp4'
                    }],
                    options: {
                        autoplay: true,
                        volume: 0.6, //音量
                    }
                },
                options: [],
                selectedOptions: [],
            }
        },
        computed: {
            // 每一个计算属性都是一个函数，函数的返回值就是这个函数对应的属性的值，计算属性使用的时候，使用的是方法对应的属性
            folderFiles() {
                if(store.state.files) {
                    //  console.log('全局文件夹:'+store.state.files)
                    return this.showType == 'all' ? store.state.files.filter(file => file.type == '/') : [];
                }
            },
            otherFiles() {
                // console.log('全局文件'+store.state.files)
                let otherFiles = store.state.files.filter( file => file.type != '/' );
                if (this.showType == 'all') {
                    return otherFiles;
                } else {
                    return otherFiles.filter(file => this.MIMEMAPS[this.showType].includes(file.type));
                }
            }
        },
        methods: {

            changes(type){
                    this.search_all(false,false,type,false)
            },
            table_set(){
                this.istable = true
                let data = new FormData()
                data.append('fid',this.thefile.id)
                http.apipost('/php/public/api/file/tags/read',data).then(res => {
                    console.log(res)
                    if (res.code != 1) {

                    } else {
                        console.log(res.data)
                        this.dynamicTags=res.data

                    }
                })
            },
            del_share(){
                let formdata = new FormData()
                formdata.append('share_id',this.check_share_file_index[0].id)
                console.log("取消分享的id:"+this.check_share_file_index[0].id)
                http.apipost('/php/public/api/file/share/cancel_share',formdata).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error('获取数据失败');
                    } else {
                        this.$message.success('取消分享成功');
                        this.my_share()
                    }
                })
            },
            look_share(){
                console.log(this.check_share_file_index[0].link)
                window.open(this.check_share_file_index[0].link)
            },
            tableRowClassName ({row, rowIndex}) {
                row.index = rowIndex;

            },
            have_change(val){   //表选择变化触发
                if(this.ismy_share == true ){
                    this.check_share_file_index = val
                    console.log(this.check_share_file_index)
                }else {
                    this.check_all_file_index = val
                    console.log(this.check_all_file_index)

                }

            },



            save_table(){    //保存书签
                let formdata = new FormData()
                console.log(this.dynamicTags)
                formdata.append('tags',this.dynamicTags)
                formdata.append('fid',this.thefile.id)
                http.apipost('/php/public/api/file/tags/edit',formdata).then(res=>{
                    console.log(res)
                    if(res.code == 1) {
                        this.$message.success(res.msg)
                        this.$router.go(0)
                    }else {
                        this.$message.error(res.msg)
                    }
                })

            },
            del_lable(){
                this.$router.go(0)
            },
            handleClose(tag) {
                console.log(this.dynamicTags)
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


            // check_all(selection){
            //     if(selection !='') {
            //         if(this.ismy_share==true){
            //             this.check_id = selection
            //             console.log(this.check_id)
            //         }else {
            //             this.chosefiles = selection
            //             console.log(this.chosefiles)
            //         }
            //
            //     }else {
            //         console.log("取消全选")
            //     }
            // },
            click_this(row){   //表选择后的数据
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
            onRowClick (row) {
                //行点击消除new标记
                var index = row.index;
                if(this.ismy_share ==true) {
                    this.toggleSelection([this.my_all_share[index]])
                }else {
                    this.toggleSelection([this.$store.state.files[index]])
                }

            },
            my_share(){
                this.ismy_share = true
                http.apipost('/php/public/api/file/share/index').then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error('获取数据失败');
                    } else {
                        this.$message.success('查询数据成功');
                        this.my_all_share =res.data
                        console.log(this.my_all_share)
                        for(let i=0;i<this.my_all_share.length;i++) {
                            this.my_all_share[i].share_time = this.formatDateTime(this.my_all_share[i].share_time)
                        }

                    }
                })

            },
            share_public(){
                let das = new FormData()
                if(this.chosefiles) {
                    das.append('files', this.chosefiles)
                }else{
                    das.append('files', this.chosefile)
                }
                http.apipost('/php/public/api/file/public/to_public',das).then(res =>{
                    console.log(res)
                    if(res.code == 1){
                        this.$message.success(res.msg)
                    }else{
                        this.$message.error(res.msg)
                    }

                })
            },
            onCopy(){
                this.$message.success("复制成功！")
                this.the_share_ok = false
            },
            // 复制失败
            onError(){
                this.$message.error("复制失败！")
            },
            to_share(){
                let formData = new FormData();


                this.chosefiles = this.chosefiles.concat(this.chosefile)
                console.log(this.chosefile)

                formData.append('files', this.chosefiles);
                formData.append('dead_time', this.value);
                formData.append('iscode', this.the_code);
                http.apipost('/php/public/api/file/share/share_file', formData).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error('分享链接失败');

                    } else {
                        this.$message.success('分享链接成功');
                        this.chosefile = []
                        this.chosefiles =[]
                        console.log(res.data )
                        this.link_share = res.data.link
                        if(res.data.code) {
                            this.link_share_code = res.data.code
                        }
                        this.link_share_all = "链接："+this.link_share +"  提取码："+ this.link_share_code
                        this.the_share = false
                        this.the_share_ok = true

                    }
                })

            },
            search_file(){
                if(this.$store.state.list_class =='文档' ||this.$store.state.list_class =='图片'||this.$store.state.list_class =='视频'||this.$store.state.list_class =='音乐'||this.$store.state.list_class =='其他') {
                    let formData = new FormData();
                    console.log(this.$store.state.list_class)
                    formData.append('type', this.$store.state.list_class);
                    formData.append('keyword', this.searchfile);
                    http.apipost('/php/public/api/file/files/class_files', formData).then(res => {
                        console.log(res)
                        if (res.code != 1) {
                            this.$message.error('获取数据失败');
                            //this.$router.push('/login')
                        } else {
                            this.$message.success('查询数据成功');
                            this.$store.commit('set_files', res.data)
                            for(let i=0;i<this.$store.state.files.length;i++) {
                                this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                            }
                        }
                    })
                }
                if(this.$store.state.list_class == '全部'){
                    this.search_all(false,this.searchfile,false,this.searchlable)
                }
            },

            copy_file(){
                let file_list = new FormData();
                console.log("已选择要复制到的文件夹："+this.chose_list[this.chose_list.length-1])
                let files = this.chosefiles.concat(this.chosefile)
                console.log("已选择的文件："+files)
                file_list.append('files',files)
                file_list.append('new_dir_id',this.chose_list[this.chose_list.length-1])
                http.apipost('/php/public/api/file/files/copy_file',file_list).then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('复制目录失败');
                    }else {

                        this.dialogcopy_file  = false
                        this.$message.success('复制目录成功');
                    }
                })
            },
            move_file(){
                let file_list = new FormData();
                console.log("已选择要移动到的文件夹："+this.chose_list[this.chose_list.length-1])
                let files = this.chosefiles.concat(this.chosefile)
                console.log("已选择的文件："+files)
                file_list.append('files',files)
                file_list.append('new_dir_id',this.chose_list[this.chose_list.length-1])
                http.apipost('/php/public/api/file/files/move_file',file_list).then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('移动目录失败');
                    }else {

                        this.dialogmove_file  = false
                        this.$message.success('移动目录成功');
                        this.allfile(0)
                    }
                })
            },
            isdialogcopy_file(){
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
            isdialogmove_file(){
                http.apipost('/php/public/api/file/files/get_folder').then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取目录失败');
                    }else {
                        console.log(res.data)
                        this.options = res.data
                        this.dialogmove_file  = true
                    }
                })


            },
            handleChange(value) {
                console.log(value);
                this.chose_list = value
            },
            get_folder(){
                http.apipost('/php/public/api/file/files/get_folder').then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取目录失败');
                    }else {

                        }
                })
            },
            allfile(page){
                this.ismy_recycle =false
                this.recycle = false
                this.alls = false
                this.chosefiles=[]
                this.chosefile = []
                this.ismy_share = false
                let formData = new FormData();
                formData.append('dir_id',page);
                http.apipost('/php/public/api/file/files/my_files',formData).then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取数据失败');
                        //this.$router.go(0)
                    }else {
                        this.$store.commit('set_files', res.data)
                        for(let i=0;i<this.$store.state.files.length;i++) {
                            this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                        }
                        this.$store.commit('set_get_nav', '')
                        this.$store.commit('set_catalogid', '0')
                        this.$store.commit('set_list_class', "全部")
                        this.chosefile = []
                        this.chosefiles = []
                    //    this.nowpage(0)
                    }
                })
            },
            search_all(id,keyword,order,tagFind){
                this.ismy_recycle =false
                this.recycle = false
                this.alls = false
                this.chosefiles=[]
                this.chosefile = []
                this.ismy_share = false
                console.log(keyword)
                console.log(order)
                console.log(tagFind)
                let formData = new FormData();
                formData.append('dir_id','0');
                if(keyword){
                    formData.append('keyword',keyword);
                }
                if(order){
                    formData.append('order',order);
                }
                if(tagFind){
                    formData.append('tagFind',tagFind);
                }

                http.apipost('/php/public/api/file/files/my_files',formData).then(res=>{
                    console.log(res)
                    if (res.code!=1){
                        this.$message.error('获取数据失败');
                    }else {
                        this.$store.commit('set_files', res.data)
                        for(let i=0;i<this.$store.state.files.length;i++) {
                            this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                        }
                        this.$store.commit('set_get_nav', '')
                        this.$store.commit('set_list_class', "全部")
                        this.chosefile = []
                        this.chosefiles = []
                    }
                })
            },
            goto_nav(dir_id){
                console.log("传过来的文件夹id:"+dir_id)
                let get_nav = new FormData();
                get_nav.append('dir_id',dir_id);
                http.apipost('php/public/api/file/files/get_nav',get_nav).then(res=>{
                    console.log(res)
                    if(res.code ==1){
                        this.$store.commit('set_get_nav',res.data)

                        console.log(res.data)
                    }
                })
                let formData = new FormData();
                formData.append('dir_id',dir_id);
                console.log("要进入文件夹的id:"+dir_id)
                http.apipost('/php/public/api/file/files/my_files',formData).then(res=>{
                    console.log(res)
                    if(res.code ==1) {
                        this.$store.commit('set_files', res.data)
                        for(let i=0;i<this.$store.state.files.length;i++){
                            this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                        }
                        this.chosefiles = []
                        this.chosefile = []
                    }else {
                        this.$message.error(res.msg)
                    }
                })
            },
            restore_file(){
                let formdata = new FormData();
                this.chosefiles = this.chosefiles.concat(this.chosefile)
                formdata.append('files',this.chosefiles)
                http.apipost('php/public/api/file/files/restore_file',formdata).then(res => {
                    console.log('传的是文件，返回的数据：')
                    console.log(res)
                    if (res.code!=1) {
                        this.$message.error('还原失败');
                        this.allfile('/')
                    }else {
                        this.$message.success('还原成功');
                        this.allfile('/')
                    }
                })
            },
            uploadwait(){
                this.dialogFormVisible=false

                this.goto_nav(this.$store.state.get_nav[this.$store.state.get_nav.length-1].id)
            },
            /*
            * 重命名文件或文件夹
            * */
            rename_file(){

                let formdata = new FormData();
                if(this.chosefiles !='') {
                    formdata.append('file_id', this.chosefiles)
                }
                if(this.chosefiles !='') {
                    formdata.append('file_id', this.chosefiles)
                }
                formdata.append('new_filename',this.input_rename)
                console.log("id:"+this.chosefiles+"name:"+this.input_rename)
                http.apipost('php/public/api/file/files/rename_file',formdata).then(res => {
                    console.log('传的是文件，返回的数据：')
                    console.log(res)
                    if (res.code!=1) {
                        this.$message.error('重命名失败');
                        this.renameview = false
                        this.allfile('/')
                    }else {
                        this.$message.success('重命名成功');
                        this.renameview = false
                        this.allfile('/')
                    }
                })
            },
            recycle_file(){
                this.alls = false
                let formdata = new FormData();
                this.chosefiles = this.chosefiles.concat(this.chosefile)
                console.log("wenjian:"+this.chosefiles)
                formdata.append('files',this.chosefiles)
                http.apipost('php/public/api/file/files/recycle_bin',formdata).then(res => {
                    console.log('传的是文件，返回的数据：')
                    console.log(res)
                    if (res.code!=1) {
                        this.$message.error('失败');
                    }else {
                        this.$message.success('成功');
                        this.allfile(0)
                    }
                })
            },
            clicknew(){
                this.$store.state.uploaderview = !this.$store.state.uploaderview
                this.allcatalogname = []
            },
            current_change(currentPage){
                this.currentPage = currentPage;
            },
            context(file){
                this.filename = file.filename
                this.thefile = file
                console.log("已选："+this.thefile.create_time)
                this.chosefiles = []
                console.log(file)
                console.log(this.$store.state.files)
                this.$store.commit('set_filename',file.filename)
               // this.ischanges = true

               for (let j=0;j<this.$store.state.files.length;j++){
                   this.$store.state.files[j].choose = false
               }
                file.choose = true
                    var name = file.id
                    this.chosefiles.push(name)
                console.log('choose:'+file.choose+'ischange:'+this.ischanges)
                console.log('已选择s：'+this.chosefiles)

            },
            the_recycle(){
                this.alls= false
                this.ismy_share = false
                this.ismy_recycle = true
                this.chosefiles=[]
                this.chosefile = []
                    http.apipost('php/public/api/file/files/read_recycle_bin').then(res => {
                        console.log('传的是文件，返回的数据：')
                        console.log(res)
                        if (res.code!=1) {
                            this.$message.error('获取数据失败');
                            //this.$router.push('/login')
                        }else {
                            this.$store.commit('set_files', res.data)
                            for(let i=0;i<this.$store.state.files.length;i++) {
                                this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                            }
                            this.recycle = true
                        }
                    })
            },
            /*
            * 选择全部文件函数
            * */
            choose_all(){
                this.alls = !this.alls

                if(this.chosefiles!='') {
                    this.chosefiles = []
                    for (let i = 0; i < this.$store.state.files.length; i++) {
                        if (this.$store.state.files[i].type != '/') {
                            this.$store.state.files[i].choose = false
                        }
                    }
                    if (this.alls == true) {
                        for (let i = 0; i < this.$store.state.files.length; i++) {
                            if (this.$store.state.files[i].type != '/') {
                                this.$store.state.files[i].choose = true
                                var fileture = true
                            }
                        }
                        if (fileture == true) {
                            for (let i = 0; i < this.$store.state.files.length; i++) {
                                if (this.$store.state.files[i].choose == true) {
                                    var name = this.$store.state.files[i].id
                                    this.chosefiles.push(name)
                                }
                            }
                        }
                    }
                }else if(this.alls == true) {
                    for (let i = 0; i < this.$store.state.files.length; i++) {
                        if (this.$store.state.files[i].type != '/') {
                            this.$store.state.files[i].choose = true
                            var fileture = true
                        }
                    }
                    if (fileture == true) {
                        for (let i = 0; i < this.$store.state.files.length; i++) {
                            if (this.$store.state.files[i].choose == true) {
                                var name = this.$store.state.files[i].id
                                this.chosefiles.push(name)
                            }
                        }
                    }
                }else {
                    this.chosefiles = []
                    for (let i = 0; i < this.$store.state.files.length; i++) {
                        if (this.$store.state.files[i].type != '/') {
                            this.$store.state.files[i].choose = false
                        }
                    }
                }
                console.log("全选文件"+this.chosefiles)
            },
            /*
            * 删除文件和文件夹的函数
            * */
            delect(){
                this.alls = false
                let formfile = new FormData();
                console.log('传的文件夹：'+this.chosefile)
                console.log('传的文件：'+this.chosefiles)
                this.chosefiles = this.chosefiles.concat(this.chosefile)
                formfile.append('files',this.chosefiles) //传文件数据
                if(this.chosefiles !='') {
                    http.apipost('php/public/api/file/files/delete_file', formfile).then(res => {
                        console.log(res)
                        if(res.code==1) {
                            this.$message.success('删除成功');
                            this.the_recycle()
                        }else {
                            this.$message.error('删除失败');
                        }
                    })
                }
            },
            /*
            * 查看图片的函数
            * */
            class_file(name){
                this.ismy_recycle =false
                this.ismy_share =false
                this.recycle = false
                this.$store.commit('set_list_class',name)
                this.alls = false
                this.chosefiles=[]
                this.chosefile = []
                let formData = new FormData();
                console.log(name)
                formData.append('type',name);
                http.apipost('/php/public/api/file/files/class_files',formData).then(res=>{
                    console.log(res)
                    if (res.code!=1) {
                        this.$message.error('获取数据失败');
                        //this.$router.push('/login')
                    }else {
                        this.$store.commit('set_files', res.data)
                        for(let i=0;i<this.$store.state.files.length;i++) {
                            this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                        }
                    }
                })
            },
            /*
            * 获取公共文件的函数
            * */
            public_file(){

                        this.$router.push('/public_file')

            },
            /*
            * 查看图片的函数
            * */
            look_thefile() {//图片查看
                console.log(this.thefile)
                if(this.thefile.type=='/'){
                    let list = this.thefile
                    list = '/'+this.thefile.filename
                 //   this.nowpage(list)
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
                    if(this.thefile.type == '其他'){
                        this.$message.warning("抱歉，目前系统并不支持打开这种格式的文件")
                    }
                }
            }, look_file(file) {//图片查看
                if(file.type=='/'){
                    let list = file
                    list = '/'+file.filename
                 //   this.nowpage(list)
                }else {
                    if(file.type == '图片') {
                        var thefile = file.oss_host + '/' + file.oss_file
                        console.log(thefile)
                        this.$alert('<div style="width: 390px;height: 390px"><img style="width: 100%;height: 100%" src="' + thefile + '" preview="0" preview-text="666"></div>', '查看图片', {
                            dangerouslyUseHTMLString: true
                        });
                    }
                    if (file.type == '音乐'){
                        this.audios[0].url = file.oss_host + '/' + file.oss_file
                        console.log(this.audios)
                        this.beginaudio = true
                    }
                    if (file.type == '视频'){
                        this.video.sources[0].src = file.oss_host + '/' + file.oss_file
                        console.log(this.video.sources[0])
                        this.beginvideo = true
                    }
                    if (file.suffix=='pdf'){
                       this.$store.state.pdf_file = file.oss_host + '/' + file.oss_file
                      this.$router.push('/pdf')

                    }
                    if (file.suffix=='xlsx' ||file.suffix=='doc'||file.suffix=='docx'|| file.suffix=='ppt'||file.suffix=='pptx'){
                       var fileurl = file.oss_host + '/' + file.oss_file
                      window.open("https://view.officeapps.live.com/op/view.aspx?src="+fileurl)

                    }
                    if(file.type == '其他'){
                        this.$message.warning("抱歉，目前系统并不支持打开这种格式的文件")
                    }
                }
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
            /*
            * 管理员入口的函数
            * */
            goback(){
                window.open('http://centos3.huangdf.com/php/public/admin');
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
            * 检测处理用户选择了那些文件夹
            * */
            choose(file){
                console.log(file.id)
                file.choose = !file.choose;
                if(file.choose==true) {
                    this.chosefile.push(file.id)
                }else {
                    for(let i in this.chosefile) {
                        if(this.chosefile[i]==file.id) {
                            this.chosefile.splice(i, 1)
                        }
                    }
                }
                this.ischange = !this.ischange
                console.log('choose:'+file.choose+'ischange:'+this.ischange)
                console.log('已选择：'+this.chosefile)
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
            /*
           * 用户上传文件后触发刷新页面的函数
           * */
            overfile(){    //上传完成后刷新页面
                this.$router.go(0)
                this.dialogFormVisible=false
                this.allfile(0)
            },
            /*
           * 双击进入文件夹，传入当前文件夹的名称获取当前文件夹内容的函数
           * */
            dbclick(row){
                console.log(row.id)
                this.myfunction(row)

            },
            myfunction(file){//双击进入文件夹，传入当前文件夹的名称
                this.alls = false
                this.chosefiles=[]
                this.chosefile = []
                this.$store.commit('set_catalogid',file.id)
                this.allcatalogid.push(file.id)
                this.allcatalogname.push(file.filename)
                console.log("当前文件目录:"+this.allcatalogname)
                console.log("当前文件目录id:"+file.id)
                if(this.recycle ==true){
                    this.$message.warning("回收站不可查看文件夹！")
                }else {
                    let get_nav = new FormData();
                    get_nav.append('dir_id', file.id);
                    http.apipost('php/public/api/file/files/get_nav', get_nav).then(res => {
                        console.log(res)
                        if (res.code == 1) {
                            this.$store.commit('set_get_nav', res.data)
                            console.log(res.data)
                        }
                    })
                    let formData = new FormData();
                    formData.append('dir_id', file.id);
                    console.log("要进入文件夹的id:" + file.id)
                    http.apipost('/php/public/api/file/files/my_files', formData).then(res => {
                        console.log(res)
                        if(res.code ==1){
                            this.$store.commit('set_files', res.data)
                            for(let i=0;i<this.$store.state.files.length;i++){
                                this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                            }
                        }else {
                            this.$message.error(res.msg)
                        }

                    })
                }
            },
            /*
         * 全部文件显示函数
         * */
            changeShowMode(type) {   //显示类型
               if(type=='thumb'){

               }

                this.showMode = type;
            },
            changeShowType(type) {
                this.get_folder()
                this.showType = type;
                this.allfile(0)

            },
            /*
         * 用户退出登录的函数
         * */
            logout(){       //退出登录
                http.apiget('/php/public/api/user/public/logout').then(res=>{console.log(res)
                    if(res.data.code == 1) {
                        cookies.set('name','')
                        cookies.set('auto_login','')
                        this.$store.commit('del_token');
                        this.$message.success(res.data.msg);
                        this.$router.push('/login')
                    }else {
                        this.$message.error("退出失败");
                        this.$router.push('/login')
                    }
                })
            },
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


        },

        mounted(){
            /*
         * 进入页面加载数据
         * */if(!sessionStorage.getItem("token") || sessionStorage.getItem("token") == '1'){   //检查用户所有状态
                this.$message.error('请登录');
                this.$store.commit('del_token')
                this.$router.push('/login')
            }else {
                this.user_type = localStorage.getItem('user_type')
                console.log('usertype' + this.user_type)
                let formData = new FormData();
                formData.append('dir_id', '0');
                http.apipost('/php/public/api/file/files/my_files', formData).then(res => {
                    console.log(res)
                    if (res.code != 1) {
                        this.$message.error(res.msg+"请重新登录！")
                        cookies.set('name','')
                        cookies.set('auto_login','')
                        this.$store.commit('del_token')
                    } else {
                        this.$store.commit('set_files', res.data)
                        for(let i=0;i<this.$store.state.files.length;i++) {
                            this.$store.state.files[i].create_time = this.formatDateTime(this.$store.state.files[i].create_time)
                        }
                        this.$message.success("获取数据成功")
                        this.$store.commit('set_get_nav','')
                        this.avatar = sessionStorage.getItem("avatar")
                    }
                })
            }
            //进入页面时从后台获取用户所有文件

        },
    }
</script>
<style>
    @import "../assets/css/index.css";
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
