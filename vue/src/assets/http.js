import store from './store'
const commonFn = {
    apiget(url) {
        return new Promise((resolve, reject) => {
            axios.get(url).then((response) => {
                resolve(response)
                return response
            }, (response) => {
                reject(response)
            })
        })
    },
    apipost(url, data) {
        return new Promise((resolve, reject) => {
            axios.post(url, data).then((response) => {
                resolve(response.data)
                return response
            }, (response) => {
                reject(response)
            })
        })
        },
  getfile(dir){
      let fi = ''
      let fis = ''
      async function listDir (dir) {
          let OSS = require('ali-oss');

          let client = new OSS({
              region: 'oss-cn-beijing',
              accessKeyId: 'LTAIHAtWDB5fIIht',//填入自己的id
              accessKeySecret: 'MsTWeU3SpQBOLmPISb7YuHO45pZrg0',//填入自己的id
              bucket: 'gdqy-bucket-2'
          });
          try {
              let result = await client.list({
                  prefix: dir,
                  delimiter: '/'
              });

              fi = result.prefixes
              fis = result.objects
          } catch (e) {
              console.log(e);
          }
          //fi.concat(fis);
          store.commit('set_filed', fi.concat(fis));
         fis = fi.concat(fis)
          return fis
      }
      fis =listDir();
      return fis

  }
}
export default commonFn
