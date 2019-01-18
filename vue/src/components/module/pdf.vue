<template>
    <div style="float: bottom;text-align: center">

        <input v-model.number="page" style="width: 5em"> /{{numPages}}
        <el-button type="primary" round @click="page -=1">上一页</el-button>
        <el-button type="primary" round @click="page +=1">下一页</el-button>
        <button @click="rotate += 90">&#x27F3;</button>
        <button @click="rotate -= 90">&#x27F2;</button>
        <button @click="$refs.pdf.print()">请等待，如果长久没显示，请点我</button>
        <button @click="gobacks" type="info" round>回主页</button>
        <button @click="gobackss" type="info" round>回主页</button>
        <div style="width: 80%;margin-left: 100px">
            <div v-if="loadedRatio > 0 && loadedRatio < 1" style="background-color: green; color: white; text-align: center" :style="{ width: loadedRatio * 100 + '%' }">{{ Math.floor(loadedRatio * 100) }}%</div>
            <pdf ref="pdf" style="border: 1px solid #3366b7" :src="src" :page="page" :rotate="rotate"  @progress="loadedRatio = $event" @error="error" @num-pages="numPages = $event" @link-clicked="page = $event"></pdf>
        </div>
    </div>
</template>
<script>
    import pdf from 'vue-pdf'

    export default {

        components: {
            pdf: pdf
        },
        data () {
            return {
                src:this.$store.state.pdf_file,
                loadedRatio: 0,
                page: 1,
                numPages: 0,
                rotate: 0,
            }
        },
        methods: {
            gobacks(){
                this.$router.push('/')
            },
            gobackss(){
              var a = 'a/b/c'
              var  arr=a.split("/");
              console.log(arr)

                var b = arr.join('/')
                console.log(b)
            },
            error: function(err) {

                console.log(err);
            }
        },
        mounted(){

        }
    }
</script>


<style scoped>

</style>
