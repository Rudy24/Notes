/*
 * @Author: your name
 * @Date: 2020-12-15 09:21:26
 * @LastEditTime: 2020-12-17 16:22:33
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\main.ts
 */

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus'
import globalComponents from '@/components/index'
import './assets/style/index.scss'
import 'element-plus/lib/theme-chalk/index.css'

createApp(App)
  .use(store)
  .use(router)
  .use(globalComponents)
  .use(ElementPlus)
  .mount('#app')
