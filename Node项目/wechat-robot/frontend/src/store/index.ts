
import { createStore } from 'vuex'
import app from './modules/app'
import user from './modules/user'
export default createStore({
  modules: {
    app,
    user
  }
})
