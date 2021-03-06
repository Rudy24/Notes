<!--
 * @Author: your name
 * @Date: 2020-12-15 11:09:04
 * @LastEditTime: 2020-12-17 11:43:40
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\layout\components\Navbar.vue
-->
<template>
    <div class="navbar-container cursor flex f-col-center">
      <!-- 折叠按钮 -->
      <div class="fold-btn" @click="handelOpenMenu">
        <i  class="el-icon-s-fold" v-show="isOpen"></i>
        <i  class="el-icon-s-unfold" v-show="!isOpen"></i>
      </div>
      <!--  Tag列表-->
      <div class="tag-list">
        <el-tag
          class="tag theme_color"
          :class="{'active-tag': tag.path === activeRoute}"
          v-for="tag in tags"
          :key="tag.path"
          @click="handelTag(tag)"
          @close="closeTag(tag)"
          size="medium"
          :closable="showTagColse(tag.path)"
          >
          {{tag.title}}
        </el-tag>
      </div>
    </div>
</template>
<script lang="ts">
import { defineComponent, computed } from 'vue'
import { useStore } from 'vuex'
import { useRoute, useRouter } from 'vue-router'
import { tagsProps } from '@/store/storeTypeProps'

export default defineComponent({
  name: 'navBar',
  setup () {
    const store = useStore()
    const route = useRoute()
    const router = useRouter()
    const isOpen = computed(() => store.state.app.isOpen)
    const activeRoute = computed((): string => route.path)
    const handelOpenMenu = () => { store.commit('app/SET_OPEN') }
    const tags = computed(() => store.state.app.tags)
    const closeTag = (tag: tagsProps): void => {
      const routerIndex: number = tags.value.findIndex((r: tagsProps) => r.path === tag.path)
      if (routerIndex - 1 > -1) {
        router.replace(tags.value[routerIndex - 1].path)
      }
      store.commit('app/DELETE_TAG', tag)
    }
    const showTagColse = (path: string): boolean => {
      let showColse = true
      if (path === '/home' || path === '/') {
        showColse = false
      }
      return showColse
    }
    const handelTag = (tag: tagsProps): void => {
      // 防止重复点击
      if (activeRoute.value === tag.path) return
      router.replace(tag.path)
    }
    return {
      isOpen,
      handelOpenMenu,
      tags,
      closeTag,
      showTagColse,
      handelTag,
      activeRoute
    }
  }
})
</script>
<style lang="scss" scoped>
  .navbar-container{
    box-sizing: border-box;
    height: 50px;
    width: 100%;
    padding: 10px;
    box-shadow: 0 4px 20px 0 rgba(0,26,79,.14)
  }
  .fold-btn{
    width: 30px;
    i{
      font-size: 24px;
    }
  }
  .tag-list{
    box-sizing: border-box;
    padding-left: 30px;
    flex-wrap: nowrap;
    flex-shrink: 1;
    overflow-x: auto;
    overflow-y: hidden;
    max-height: 50px;
    .tag{
      margin: 0 10px;
    }
  }

</style>
