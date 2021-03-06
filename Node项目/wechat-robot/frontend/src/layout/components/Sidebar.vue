<!--
 * @Author: your name
 * @Date: 2020-12-15 11:09:27
 * @LastEditTime: 2020-12-16 15:19:42
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\layout\components\Sidebar.vue
-->
<template>
  <div class="sidebar-content theme_bg scrollbar-bar" :class="{ w240: !isCollapse, w80: isCollapse }">
    <el-menu
      default-active="1"
      router
      :collapse="isCollapse"
      :collapse-transition="isCollapse"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      :background-color="variables.theme_bg"
      :text-color="variables.textColor"
      :active-text-color="variables.menuActiveTextColor"
    >
      <template v-for="route in routes" >
        <template v-if="route.children && !route.meta.hidden">
          <el-submenu :index="route.path" :key="route.path">
            <template #title>
              <i :class="route.meta.icon" :style="route.meta && route.meta.iconStyle" class="menu-left-icon-coloe"></i>
              <span>{{ route.meta.title }}</span>
            </template>
            <el-menu-item-group v-for="croute in route.children" :key='croute.path'>
              <template v-if="!croute.meta.hidden">
                <el-menu-item :index="croute.path">{{ croute.meta && croute.meta.title || '' }}</el-menu-item>
              </template>

            </el-menu-item-group>
          </el-submenu>
        </template>
      </template>
    </el-menu>
  </div>
</template>
<script lang="ts">
import { defineComponent, computed, DefineComponent } from 'vue'
import { useStore } from 'vuex'
import { useRouter, Router } from 'vue-router'
const variables = require('@/assets/style/variables.scss')

export default defineComponent({
  name: 'sidebar',
  setup () {
    const routers = useRouter()
    const store = useStore()
    const routes = computed(() => routers.options.routes)
    const isCollapse = computed((): boolean => !store.state.app.isOpen)
    return {
      variables,
      isCollapse,
      routes
    }
  }
})
</script>
<style lang="scss" scoped>
.sidebar-content {
  height: calc(100vh - 60px);
  box-sizing: border-box;
  padding: 0 0 20px;
  overflow-y: auto;
  overflow-x: hidden;
}
.w240 {
  width: 240px;
  transition: width 0.3s linear;
}
.w80 {
  width: 80px;
  transition: width 0.3s linear;
}
.menu-left-icon-coloe{
  color: #fff;
}
</style>
