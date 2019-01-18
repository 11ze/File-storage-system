<template>
    <div>
        <div v-if="type=='audio'">
        <VueAudio :theUrl="this.audios[0].url" :theControlList="this.audios[0].controlList"/>
        </div>
        <div v-else-if="type=='video'">
        <my-video :sources="video.sources" :options="video.options"></my-video>
        </div>
        <div v-else-if="type=='picture'">
        <img :src="this.audios[0].url" style="width: 80%;height: 80%"/>
        </div>
    </div>
</template>

<script>
    import VueAudio from './VueAudio'
    import myVideo from './video'
    export default {
        name: "preview",
        data(){
          return{
              type:'',
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
              audios: [
                  {
                      url: '',
                      controlList: 'onlyOnePlaying'
                  },

              ]
          }
        },
        components:{
            VueAudio,
            myVideo
        },
        methods:{

        },
        mounted(){
            let ids = this.$route.query.file
            let type = this.$route.query.type
            if(!type){
                alert("文件格式参数错误")
            }
            if(!ids){
                alert("文件参数错误")
            }
            console.log(ids+type)
            if( type== "video"){
                this.type = 'video'
                this.video.sources[0].src = ids
                console.log('sp')
            }
            if( type== "music"){
                this.type = 'audio'
                this.audios[0].url = ids
                console.log('music')
            }
            if(type == "picture"){
                this.type = "picture"
                this.audios[0].url = ids
            }
            if( type== "word"){
                window.open("https://view.officeapps.live.com/op/view.aspx?src="+ids)
            }
            if( type== "其他"){

            }
        }
    }
</script>

<style scoped>

</style>
