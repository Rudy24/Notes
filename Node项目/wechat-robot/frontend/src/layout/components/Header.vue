<!--
 * @Author: your name
 * @Date: 2020-12-15 11:15:38
 * @LastEditTime: 2020-12-17 17:03:59
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\layout\components\Header.vue
-->

<template>
  <header class="header-content theme_bg flex f-col-center flex-between">
    <div class="log">
      <h2 style="color: #fff">道路运输车辆动态监控平台</h2>
    </div>
    <div class="user flex f-col-center f-row-center">
      <el-avatar
        size="large"
        src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
      />

      <el-dropdown>
        <span class="el-dropdown-link">
          <span>admin</span>
          <i class="el-icon-arrow-down el-icon--right" />
        </span>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click="signOut">退出</el-dropdown-item>
            <el-dropdown-item>修改密码</el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </header>
</template>
<script lang="ts">
import { defineComponent } from 'vue'
import { useStore } from 'vuex'
export default defineComponent({
  name: 'header',
  setup () {
    const store = useStore()
    const signOut = () => {
      store.commit('user/signOut')
    }
    return {
      signOut
    }
  }
})
</script>
<style lang="scss" scoped>
.header-content {
  height: 60px;
  width: 100vw;
  box-sizing: border-box;
  padding: 0 20px;
  background-image: url("../../assets/images/header_img.png");
}
.el-dropdown-link {
  cursor: pointer;
  color: #409eff;
}
.el-icon-arrow-down {
  font-size: 12px;
}
.demonstration {
  display: block;
  color: #8492a6;
  font-size: 14px;
  margin-bottom: 20px;
}
</style>
