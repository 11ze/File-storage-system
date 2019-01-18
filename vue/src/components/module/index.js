import mountComponent from "./Upload.vue";
import upfolder from  './upfolder'
import lable from './lable'
export default {
    install: function (Vue) {
        Vue.component("plupload", mountComponent)
        Vue.component("lables", lable)
        Vue.component("upfolder", upfolder)
    }
}
