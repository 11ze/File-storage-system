// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router/index'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import http from './assets/http'
import global from '@/assets/global'
import store from './assets/store'
import upload from './assets/uploads'
import module from './components/module/index'
import cookies from 'js-cookie'

import preview from 'vue-photo-preview'
import 'vue-photo-preview/dist/skin.css'
import 'element-ui/lib/theme-chalk/index.css'
import contentmenu from 'v-contextmenu'
import 'v-contextmenu/dist/index.css'
import VueClipboard from 'vue-clipboard2'
Vue.use(VueClipboard)
import Downloader from '@lassehaslev/vue-downloader';
Vue.use( 'downloader', Downloader );
import md5 from 'js-md5';
Vue.prototype.$md5 = md5;

Vue.use(contentmenu)

Vue.config.productionTip = false
Vue.use(store)
Vue.use(preview)
Vue.use(module)
Vue.prototype.global = global
Vue.use(ElementUI)
window.upload = upload
window.http = http
window.axios = axios
// 响应时间
Vue.config.productionTip = false
axios.defaults.timeout = 5 * 1000
// 配置cookie
// axios.defaults.withCredentials = true
// 配置请求头
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8'
// 静态资源
Vue.prototype.$static = ''
if(cookies.get('name')) {
    console.log("存在token，放进heard")
    axios.defaults.headers['XX-Token']=store.state.token;
    console.log(axios.defaults.headers['XX-Token'])
}
// 配置接口地址
//axios.defaults.baseURL = 'http://centos3.huangdf.com'
/* eslint-disable no-new */
// 添加请求拦截器
axios.interceptors.request.use(config => {

// 在发送请求之前做些什么
//判断是否存在token，如果存在将每个页面header都添加token
    if(sessionStorage.getItem("token")){
      console.log("拦截存在token："+sessionStorage.getItem("token"))
        config.headers.common['XX-Token'] = sessionStorage.getItem("token")
        console.log('success')
    }if(!sessionStorage.getItem("token")){
        console.log("未登录")
            router.replace({
                path: '/login',
                query: {redirect: router.currentRoute.fullPath}//登录成功后跳入浏览的当前页面
            })
    }

    return config;
}, error => {
// 对请求错误做些什么
    console.log('error')
    return Promise.reject(error);
});
// http response 拦截器
axios.interceptors.response.use(
    response => {
        return response;
    },
    error => {
        console.log('errorl')
        if (error.response) {
            switch (error.response.status) {
                case 401:
                    this.$store.commit('del_token');
                    router.replace({
                        path: '/login',
                        query: {redirect: router.currentRoute.fullPath}//登录成功后跳入浏览的当前页面
                    })
            }
        }
        return Promise.reject(error)
    });
new Vue({
  el: '#app',
  router,
   store,
  components: { App },
  template: '<App/>'
})
