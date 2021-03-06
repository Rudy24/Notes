<!--
 * @Author: your name
 * @Date: 2020-12-15 10:55:56
 * @LastEditTime: 2020-12-16 11:20:14
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\layout\index.vue
-->
<template>
  <div class="app-wrapper">
    <nav-header />
    <div class="main-box flex">
      <sidebar class="sidebar-container" />
      <div class="main-container">
        <navbar />
        <app-main />
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import { defineComponent, reactive, toRefs } from 'vue'
import { Navbar, Sidebar, AppMain, NavHeader } from './components'

export default defineComponent({
  name: 'layout',
  setup () {
    return {}
  },
  components: {
    Navbar,
    Sidebar,
    AppMain,
    NavHeader
  }
})
</script>
<style lang="scss" scoped>
.main-box {
  overflow: hidden;
  width: 100%;
}
.main-container {
  flex: 1;
}
</style>
