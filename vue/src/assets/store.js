import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state:{
        pdf_file:'',
        avatar:'',
        filename:'',
        list_class:'全部',
        token:'',//存放登录令牌
        uploaderview:false,  //是否显示新建文件框
        user_type:'a',//用户类型
        user_say:'',//用户类型
        over:false,
        upnum:{},//上传数据
        user_cata:'',//存放用户根目录
        catalogid:'',//存放当前目录id
        get_nav:[], //面包屑导航
        share_get_nav:[], //分享面包屑导航
        sex:'',
        last_login_time:'',//用户上次登录时间
        last_login_ip:'',//用户最后一次登录IP
        user_email:'',//用户email
        user_login:'',//用户名
        user_nickname:'',//用户昵称
        user_birthday:'',
        school_name:'',
        public_file:[],
        filelist:[],
        share:[],
        files:[
            // 每一个对象就是一个文件夹、文件信息

        ],//存放文件夹列表
    },

    mutations:{
        set_token(state, token) {
            state.token = token
            sessionStorage.token = token
        },
        set_pdf_file(state, pdf_file) {
            state.pdf_file = pdf_file
            sessionStorage.pdf_file = pdf_file
        },
        set_birthday(state, user_birthday) {
            state.user_birthday = user_birthday
            sessionStorage.user_birthday = user_birthday
        },
        set_over(state, over) {
            state.over = over
        },
        set_user_say(state, user_say) {
            state.user_say = user_say
            sessionStorage.user_say = user_say
        },
        set_filename(state, filename) {
            state.filename = filename
        },
        set_share(state, share) {
            state.share = share
        },
        set_list_class(state, list_class) {
            state.list_class = list_class
        },
        set_user_cata(state, a) {
            state.user_cata = a
            sessionStorage.user_cata = a
        },
        set_upnum(state, a) {
            state.upnum = a
            sessionStorage.upnum = a
        }, set_user_type(state, a) {
            state.user_type = a
            localStorage.user_type = a
        },
        set_catalogid(state, a) {
            state.catalogid = a
            sessionStorage.catalogid = a
        },
        del_token(state) {
            state.token = ''
            sessionStorage.removeItem('token')
        },
        set_filed(state, a){
            state.filed = a
            sessionStorage.setItem('filed',a)
        },
        del_filed(state){
            state.filed = ''
            sessionStorage.removeItem('filed')
        },
        set_last_login_time(state,a){
            state.last_login_time = a
            sessionStorage.last_login_time = a
        },
        set_last_login_ip(state,last_login_ip){
            state.last_login_ip = last_login_ip
            sessionStorage.setItem('last_login_ip',last_login_ip)
        },
        set_user_email(state,user_email){
            state.user_email = user_email
            sessionStorage.user_email = user_email
        },
        set_user_login(state,user_login){
            state.user_login = user_login
            sessionStorage.user_login = user_login
        },
        set_user_nickname(state,user_nickname){
            state.user_nickname = user_nickname
            sessionStorage.user_nickname = user_nickname
        },
        set_school_name(state,school_name){
            state.school_name = school_name
            sessionStorage.school_name = school_name
        },
        set_files(state,files){
            state.files = files
            sessionStorage.files = files
        },
        set_get_nav(state,get_nav){
            state.get_nav = get_nav
        },
        set_share_get_nav(state,share_get_nav){
            state.share_get_nav = share_get_nav
        },
        set_filelist(state,filelist){
            state.filelist = filelist
            sessionStorage.filelist = filelist
        },
        set_uploaderview(state,uploaderview){
            state.uploaderview = uploaderview
        },
        set_avatar(state,avatar){
            state.avatar = avatar
            sessionStorage.avatar = avatar
        },
        set_public_file(state,public_file){
            state.public_file = public_file
        },
        set_sex(state,sex){
            state.sex = sex
            sessionStorage.sex = sex

        },
    }
})
