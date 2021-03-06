/*
 * @Author: your name
 * @Date: 2020-12-15 09:21:26
 * @LastEditTime: 2020-12-17 17:09:51
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\router\index.ts
 */

import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import { useBeforeAuthen } from '@/hooks/usAuthen'
import Home from '@/views/home/index.vue'
import LayOut from '@/layout/index.vue'
import Login from '@/views/login/index.vue'
const _component = (file: string) => import(`@/views/${file}/index.vue`)

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    component: LayOut,
    redirect: '/',
    meta: {
      title: '模块一',
      icon: 'el-icon-location'
    },
    children: [
      {
        name: 'home',
        path: '/',
        component: Home,
        meta: {
          title: '首页',
          hidden: true
        }
      },
      {
        name: 'center',
        path: '/center',
        component: _component('center'),
        meta: {
          title: '个人中心'

        }
      }
    ]
  },
  {
    path: '/outher',
    component: LayOut,
    meta: {
      title: '模块二',
      icon: 'el-icon-platform-eleme',
      hidden: false,
      iconStyle: {
        color: 'yellow'
      }
    },
    redirect: 'outher/setting',
    children: [
      {
        name: 'setting',
        path: '/outher/setting',
        component: _component('setting'),
        meta: {
          title: '设置',
          hidden: false
        }
      },
      {
        name: 'about',
        path: '/outher/about',
        component: _component('about'),
        meta: {
          title: '关于',
          hiddenTag: true
        }
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    meta: {
      hidden: true,
      title: '登录'
    },
    component: Login// r => require.ensure([], () => r(require('@/views/login/index.vue')), 'login')//Login
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})
router.beforeEach((to, from, next) => useBeforeAuthen(to, from, next))
// router.afterEach((to, form) => usAfterAuthen(to, form))

export default router
