/*
 * @Author: your name
 * @Date: 2020-12-16 09:47:33
 * @LastEditTime: 2020-12-17 17:12:07
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\hooks\usAuthen.ts
 */
import store from '@/store'
import { RouteLocation } from 'vue-router'

// 路由跳转前鉴权
export const useBeforeAuthen = (to: RouteLocation, from: RouteLocation, next: any) => {
  const { path, meta = {} } = to
  const { hiddenTag = false, hidden = false, title } = meta
  const token = store.state && (store.state as any).user.token

  // 登录 跳转非登录页面
  if (token && path !== '/login') {
    // 判断是否需要添加Tag
    if (!(hiddenTag || hidden)) store.commit('app/PUSH_TAG', { path, title })
    next()
  } else
  // 登录状态跳转登录页面，重定向到首页
  if (token && path === '/login') {
    next('/')
  } else
  // 非登录页面跳转非login页面，重定向到登录页面
  if (!token && path !== '/login') {
    console.log('token:', token, path)
    next({ path: '/login' })
  } else { next() }
  // 非登录页面跳转login页面
}

// 路由跳转后鉴权
// export const usAfterAuthen = (to: RouteRecordRaw, from: RouteRecordRaw) => {

// }
