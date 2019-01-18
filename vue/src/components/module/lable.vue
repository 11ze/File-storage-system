<template>
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
        <el-footer>
            <el-button type="primary" size="medium" @click="save_label" plain>保存</el-button>
            <el-button type="primary" size="medium" @click="del_lable" plain>取消</el-button>
        </el-footer>
    </el-container>





</template>

<script>
    export default {
        name: "lable",
        data() {
            return {
                dynamicTags: [],
                inputVisible: false,
                inputValue: ''
            };
        },
        methods: {
            save_label(){    //保存书签
                let formdata = new FormData()
                formdata.append('tags',this.dynamicTags)
                http.apipost('/php/public/api/file/tags/edit_all',formdata).then(res=>{
                    console.log(res)
                    if(res.code == 1) {
                        this.$message.success(res.msg)
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
            }
        },
        mounted(){
            http.apipost('php/public/api/file/tags/read_all').then(res=>{
                console.log(res)
                if(res.code == 1) {
                    this.dynamicTags=res.data
                }else {

                }
            })
        }
    }
</script>

<style scoped>
    .el-tag + .el-tag {
        margin-left: 10px;
    }
    .button-new-tag {
        margin-left: 10px;
        height: 32px;
        line-height: 30px;
        padding-top: 0;
        padding-bottom: 0;
    }
    .input-new-tag {
        width: 90px;
        margin-left: 10px;
        vertical-align: bottom;
    }
    .el-header, .el-footer {

        text-align: center;
        line-height: 60px;
    }


    .el-main {
        background-color: #E9EEF3;
        color: #333;
        text-align: center;
        line-height: 60px;
    }

    body > .el-container {
        margin-bottom: 40px;
    }

    .el-container:nth-child(5) .el-aside,
    .el-container:nth-child(6) .el-aside {
        line-height: 260px;
    }

    .el-container:nth-child(7) .el-aside {
        line-height: 320px;
    }
</style>
