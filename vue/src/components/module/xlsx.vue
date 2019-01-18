<template>
    <div>
        <!--<downloader-->
                <!--url="http://gdqy-bucket-2.oss-cn-beijing.aliyuncs.com/50/get_pic.py"-->
                <!--name="my-cat.jpg"-->
                <!--ref="downloader"></downloader>-->
        <!--<button @click.prevent="$refs.downloader.download();">download</button>-->
<input type="file" id="upload" @change="handle($event)"/>

    </div>
</template>

<script>
    import BMF from 'browser-md5-file';
  //  const el = document.getElementById('uploads');
    const bmf = new BMF();

    //el.addEventListener('change', handle, false);

    export default {
        name: "xlsx",
methods: {

    handle(event) {



        //console.log(this.$md5(z))
        const file  = event.target.files[0];
        //console.log(this.$md5(file))
        console.log(file)
        bmf.md5(
            file,
            (err, md5) => {
                console.log('错误:', err);
                console.log('md5 string:', md5);
            },
            progress => {
                console.log('progress number:', progress);
            },
        );
    }
        }
    }
</script>

<style scoped>

</style>
