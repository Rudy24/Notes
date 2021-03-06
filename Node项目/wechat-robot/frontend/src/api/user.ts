/*
 * @Author: your name
 * @Date: 2020-12-17 13:39:59
 * @LastEditTime: 2020-12-17 16:14:28
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\api\user.ts
 */
import request from '@/utils/request'
import { LoginRequestProps } from './requestProps'
export function Login (params: LoginRequestProps) {
  return request({
    url: '/login',
    method: 'GET',
    params
  })
}
