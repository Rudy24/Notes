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
			<el-form-item prop="username">
				<el-input
					ref="username"
					v-model.trim="loginForm.username"
					placeholder="请输入用户名"
					name="username"
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
					@keyup.enter="handleLogin"
				/>
				<!-- <span class="show-pwd" @click="showPwd">
          <svg-icon :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'" />
        </span> -->
			</el-form-item>

			<el-button
				:loading="loading"
				type="primary"
				style="width: 100%; margin-bottom: 30px"
				@click.prevent="handleLogin"
				>登录</el-button
			>
		</el-form>
	</div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { Login } from '@/api/user'
type passwordTypeProps = 'password' | 'text'
type pwdOrUname = string | number
interface LoginFormProps {
	username: string
	password: string | number
}
export default defineComponent({
	name: 'login',
	setup() {
		const router = useRouter()
		const store = useStore()
		const loading = ref<boolean>(false)
		const loginFormRef = ref<HTMLElement | null>(null)
		const passwordType = ref<passwordTypeProps>('password')
		const validateUsername = (
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
		const loginForm: LoginFormProps = reactive({
			username: '',
			password: ''
		})
		const loginRules = {
			username: [
				{ required: true, trigger: 'blur', validator: validateUsername }
			],
			password: [
				{ required: true, trigger: 'blur', validator: validatePassword }
			]
		}
		const handleLogin = (): void => {
			;(loginFormRef.value as any).validate(async (valid: boolean) => {
				if (valid) {
					const { username, password } = loginForm
					if (username === 'admin' && password.toString() === '123456') {
						store.commit('user/setToken', 'test')
						router.push('/')
					} else {
						const res = await Login(loginForm)
						console.log('res-data:', res)
					}
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
