import Vue from 'vue'
import Router from 'vue-router'
import share_file from '../components/module/share_file'
import forget from '../components/forget'
import store from '../assets/store'
import register from '@/components/register'
import public_file from '../components/module/public_file'
import share from '../components/module/share'
import pdf from '../components/module/pdf'
import preview from '../components/module/preview'
import xlsx from '../components/module/xlsx'
import school_register from '@/components/school_register'
const index =() => import('@/components/index')
const login =() => import('@/components/login')
import userinfo from '../components/user/userinfo'
Vue.use(Router)
import cookies from 'js-cookie'
console.log(store.state.token)
// 页面刷新时，重新赋值token
if (sessionStorage.getItem('token')) {
    console.log('存在token')
   store.commit('set_token', sessionStorage.getItem('token'))
}

const router = new Router({
    mode: "history",
    router
});

const guardRoute = (to, from, next) => {
    console.log('检测页面')
    console.log(sessionStorage.getItem('token'))
    if (!sessionStorage.getItem('token')) {
        next('/login')
    }
    next()
}
export default new Router({

  routes: [
    {
      path: '/',
      name: 'indexpage',
      component: index,
      beforeEnter: guardRoute
    },
      {
          path: '/login',
          name: 'loginpage',
          component: login
      },
      {
          path:'/register',
          name:'register',
          component:register
      },
      {
          path:'/forget',
          name:'forget',
          component:forget
      },
      {
          path:'/public_file',
          name:'public_file',
          component: public_file
      },{
          path:'/school_register',
          name:'school_register',
          component:school_register
      },{
          path:'/pdf',
          name:'pdf',
          component:pdf
      },{
          path:'/share',
          name:'share',
          component:share
      },{
          path:'/xlsx',
          name:'xlsx',
          component:xlsx
      },{
          path:'/share_file',
          name:'share_file',
          component:share_file
      },{
          path:'/userinfo',
          name:'userinfo',
          component:userinfo
      },
      {
          path:'/preview',
          name:'preview',
          component:preview
      },

  ]
})
