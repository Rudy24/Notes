<template>
	<div class="login-container">
		<el-form
			ref="loginFormRef"
			:model="loginForm"
			:rules="loginRules"
			class="login-form"
			auto-complete="on"
			label-position="left"
		>
			<div class="title-container">
				<h3 class="title">登录</h3>
			</div>
			<el-form-item prop="mobile">
				<el-input
					ref="mobile"
					v-model.trim="loginForm.mobile"
					placeholder="请输入手机号码"
					name="mobile"
					type="text"
					tabindex="1"
					auto-complete="on"
				/>
			</el-form-item>

			<el-form-item prop="password">
				<el-input
					:key="passwordType"
					ref="password"
					v-model.trim="loginForm.password"
					:type="passwordType"
					placeholder="请输入密码"
					name="password"
					tabindex="2"
					auto-complete="on"
				/>
			</el-form-item>
			<el-form-item prop="realName" v-show="!isReg">
				<el-input
					v-model.trim="loginForm.realName"
					placeholder="请输入真实姓名"
					name="realName"
					tabindex="2"
					auto-complete="on"
				/>
			</el-form-item>

			<el-button
				:loading="loading"
				type="primary"
				style="width: 100%; margin-bottom: 30px"
				@click.prevent="handleLogin"
				>{{ isReg ? '登陆' : '注册' }}</el-button
			>
			<el-button @click="isReg = !isReg"
				>切换{{ isReg ? '注册' : '登陆' }}</el-button
			>
			{{ isReg }}
		</el-form>
	</div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { Register, Login } from '@/api/user'
import { LoginRequestProps } from '@/api/requestProps'
import { use } from 'echarts'
type passwordTypeProps = 'password' | 'text'
type pwdOrUname = string | number
export default defineComponent({
	name: 'login',
	setup() {
		const router = useRouter()
		const store = useStore()
		const loading = ref<boolean>(false)
		const loginFormRef = ref<HTMLElement | null>(null)
		const passwordType = ref<passwordTypeProps>('password')
		const validatemobile = (
			rule: any,
			value: pwdOrUname,
			callback: Function
		) => {
			if (!value) {
				callback(new Error('用户名不能为空'))
			}
			if (value.toString().includes('yyy')) {
				callback(new Error('用户名格式不正确'))
			}
			callback()
		}
		const validatePassword = (
			rule: any,
			value: pwdOrUname,
			callback: Function
		) => {
			if (!value) callback(new Error('密码不能为空'))
			callback()
		}
		const loginForm: LoginRequestProps = reactive({
			mobile: '',
			password: '',
			realName: ''
		})
		let isReg = ref<boolean>(false)
		const loginRules = {
			mobile: [{ required: true, trigger: 'blur', validator: validatemobile }],
			password: [
				{ required: true, trigger: 'blur', validator: validatePassword }
			]
		}
		const handleLogin = (): void => {
			;(loginFormRef.value as any).validate(async (valid: boolean) => {
				if (valid) {
					const { mobile, password, realName } = loginForm
					console.log(isReg, 'isReg')
					const request = isReg.value ? Login : Register
					const params = {
						mobile,
						password,
						realName
					}

					if (!isReg) delete params.realName
					try {
						const { data } = await request(params)
						console.log(data, 'res')
						if (isReg.value) {
							store.commit('user/setToken', data.token)
							store.commit('user/setUserInfo', data.userInfo)
							router.push('/')
						} else {
							isReg.value = !isReg.value
						}
					} catch (e) {}
				}
			})
		}

		const showPwd = () => {
			if (passwordType.value === 'password') {
				passwordType.value = 'text'
			} else {
				passwordType.value = 'password'
			}
		}
		return {
			isReg,
			loading,
			loginRules,
			loginForm,
			loginFormRef,
			passwordType,
			showPwd,
			handleLogin
		}
	},
	components: {}
})
</script>
<style lang="scss" scoped>
$bg: #2d3a4b;
$dark_gray: #889aa4;
$light_gray: #eee;

.login-container {
	min-height: 100vh;
	width: 100%;
	background-color: $bg;
	overflow: hidden;

	.login-form {
		position: relative;
		width: 520px;
		max-width: 100%;
		padding: 160px 35px 0;
		margin: 0 auto;
		overflow: hidden;
	}

	.title-container {
		position: relative;

		.title {
			font-size: 26px;
			color: $light_gray;
			margin: 0px auto 40px auto;
			text-align: center;
			font-weight: bold;
		}
	}

	.show-pwd {
		position: absolute;
		right: 10px;
		top: 7px;
		font-size: 16px;
		color: $dark_gray;
		cursor: pointer;
		user-select: none;
	}
}
</style>
