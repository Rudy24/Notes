import router from '@/router/index'

export default {
  namespaced: true,
  state: {
    token: window.localStorage.getItem('token') || undefined
  },
  mutations: {
    signOut (state: any) {
      window.sessionStorage.removeItem('tags')
      window.localStorage.removeItem('token')
      state.token = ''
      location.reload()
      // router.replace('/login')
    },
    setToken (state: any, token: string) {
      state.token = token
      window.localStorage.setItem('token', token)
    }
  },
  actions: {
  }
}
