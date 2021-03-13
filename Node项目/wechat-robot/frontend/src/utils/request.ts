import axios from 'axios'
import store from '@/store/index'
import { ElMessage } from 'element-plus'

const service = axios.create({
	baseURL: process.env.VUE_APP_BASE_API,
	timeout: 5000
})

// request interceptor
service.interceptors.request.use(
	(config: any) => {
		const { contentType = false } = config
		const token = (store.state as any).user.token
		config.headers['Content-Type'] = contentType || 'application/json'
		if (token) {
			config.headers['Authorization'] = `Bearer ${token}`
		}
		return config
	},
	error => Promise.reject(error)
)

// response interceptor
service.interceptors.response.use(
	response => {
		const res = response.data
		if (res.code !== 0) {
			ElMessage({
				message: res.error || '加载失败！',
				type: 'error',
				duration: 5 * 1000
			})

			return Promise.reject(new Error(res.error || '加载失败！'))
		} else {
			return res
		}
	},
	error => {
		const { data, status, statusText } = error.response
		ElMessage({
			message: error.error,
			type: 'error',
			duration: 5 * 1000
		})
		return Promise.reject(error)
	}
)

export default service
