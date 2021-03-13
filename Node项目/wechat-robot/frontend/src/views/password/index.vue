<template>
	<div class="login-container">
		<el-form
			ref="loginFormRef"
			:model="form"
			:rules="loginRules"
			class="login-form"
			auto-complete="on"
			label-position="left"
		>
			<div class="title-container">
				<h3 class="title">修改密码</h3>
			</div>
			<el-form-item prop="originPassword">
				<el-input
					:key="passwordType"
					:type="passwordType"
					v-model.trim="form.originPassword"
					placeholder="请输入原始密码"
					tabindex="1"
					auto-complete="on"
				/>
			</el-form-item>

			<el-form-item prop="newPassword1">
				<el-input
					:key="passwordType"
					v-model.trim="form.newPassword1"
					:type="passwordType"
					placeholder="请输入密码"
					tabindex="2"
					auto-complete="on"
				/>
			</el-form-item>
			<el-form-item prop="newPassword2">
				<el-input
					:key="passwordType"
					:type="passwordType"
					v-model.trim="form.newPassword2"
					placeholder="请再次输入密码"
					tabindex="2"
					auto-complete="on"
				/>
			</el-form-item>

			<el-button
				:loading="loading"
				type="primary"
				style="width: 100%; margin-bottom: 30px"
				@click.prevent="handleLogin"
				>提交</el-button
			>
		</el-form>
	</div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { ModifyPswApi } from '@/api/user'
import { modifyRequestPsw } from '@/api/requestProps'
import { ElMessage } from 'element-plus'
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
		const validatePassword = (
			rule: any,
			value: pwdOrUname,
			callback: Function
		) => {
			if (!value) callback(new Error('密码不能为空'))
			callback()
		}
		const validatePassword1 = (
			rule: any,
			value: pwdOrUname,
			callback: Function
		) => {
			if (!value) callback(new Error('密码不能为空'))
			callback()
		}
		const validatePassword2 = (
			rule: any,
			value: pwdOrUname,
			callback: Function
		) => {
			const { newPassword1, newPassword2 } = form
			if (!value) callback(new Error('密码不能为空'))
			else if (newPassword1 !== newPassword2)
				callback(new Error('两次密码不一致'))
			callback()
		}

		const form: modifyRequestPsw = reactive({
			originPassword: '',
			newPassword1: '',
			newPassword2: ''
		})

		let isReg = ref<boolean>(false)
		const loginRules = {
			originPassword: [
				{ required: true, trigger: 'blur', validator: validatePassword }
			],
			newPassword1: [
				{ required: true, trigger: 'blur', validator: validatePassword1 }
			],
			newPassword2: [
				{ required: true, trigger: 'blur', validator: validatePassword2 }
			]
		}
		const handleLogin = (): void => {
			;(loginFormRef.value as any).validate(async (valid: boolean) => {
				if (valid) {
					try {
						console.log('ASDFADSF')
						await ModifyPswApi({ ...form })
						ElMessage({
							message: '修改密码成功',
							type: 'success',
							duration: 5 * 1000
						})
						setTimeout(() => {
							router.push('/')
						}, 1000)
					} catch (e) {
						console.log(e, 'e')
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
			isReg,
			loading,
			loginRules,
			form,
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
