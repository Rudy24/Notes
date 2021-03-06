const path = require('path')
const resolve = dir => path.join(__dirname, dir)

module.exports = {
  lintOnSave: process.env.NODE_ENV === 'development',
  productionSourceMap: false,
  devServer: {
    open: true
    // proxy: {

    // }
  },
  css: {
    extract: true
  },
  configureWebpack: {
    resolve: {
      alias: {
        '@': resolve('src')
      }
    }
  },
  chainWebpack (config) {
    // 预加载
    // config.plugin('preload').tap(() => [
    //   {
    //     rel: 'preload',
    //     fileBlacklist: [/\.map$/, /hot-update\.ts$/, /runtime\..*\.ts$/],
    //     include: 'initial'
    //   }
    // ])
    config.plugins.delete('prefetch')
      .end()

    config
      .when(process.env.NODE_ENV !== 'development',
        // 代码切割 资源分块
        config => {
          config
            .optimization.splitChunks({
              chunks: 'all', // async异步代码分割 initial同步代码分割 all同步异步分割都开启
              cacheGroups: {
                libs: {
                  name: 'chunk-libs',
                  test: /[\\/]node_modules[\\/]/,
                  priority: 10, // 优先级，先打包到哪个组里面，值越大，优先级越高
                  chunks: 'initial' // async异步代码分割 initial同步代码分割 all同步异步分割都开启
                },
                elementPlus: {
                  name: 'chunk-elementPlus',
                  priority: 20, // 优先级，先打包到哪个组里面，值越大，优先级越高
                  test: /[\\/]node_modules[\\/]_?element-plus(.*)/
                },
                commons: {
                  name: 'chunk-commons',
                  test: resolve('src/components'),
                  minChunks: 3, // 模块至少使用次数
                  priority: 5, // 优先级
                  reuseExistingChunk: true // 模块嵌套引入时，判断是否复用已经被打包的模块
                }
              }
            })
          config.optimization.runtimeChunk('single')
        }
      )
  }
}
