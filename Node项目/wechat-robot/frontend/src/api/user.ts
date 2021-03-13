/*
 * @Author: your name
 * @Date: 2020-12-17 13:39:59
 * @LastEditTime: 2020-12-17 16:14:28
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\api\user.ts
 */
import request from '@/utils/request'
import { LoginRequestProps, modifyRequestPsw } from './requestProps'
export function Login(params: LoginRequestProps) {
	return request({
		url: '/api/user/access/login',
		method: 'POST',
		data: params
	})
}
// 注册
export function Register(params: LoginRequestProps) {
	return request({
		url: '/api/user/access/register',
		method: 'POST',
		data: params
	})
}

// 修改密码
export function ModifyPswApi(params: modifyRequestPsw) {
	return request({
		url: '/api/user/access/modifyPsw',
		method: 'POST',
		data: params
	})
}
