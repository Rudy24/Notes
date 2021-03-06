<!--
 * @Author: your name
 * @Date: 2020-12-15 11:09:39
 * @LastEditTime: 2020-12-16 11:22:07
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\layout\components\AppMain.vue
-->

<template>
    <div class="main-content scrollbar-bar" :style="{'height':Mheight}">
        <router-view/>
    </div>
</template>
<script lang="ts">
import { defineComponent, Ref } from 'vue'
import ResizeHandler from '@/hooks/ResizeHandler'
export default defineComponent({
  name: 'appmain',
  setup () {
    const Mheight: Ref<string> = ResizeHandler()
    return {
      Mheight
    }
  }
})
</script>
<style lang="scss" scoped>
  .main-content{
    box-sizing: border-box;
    padding: 10px;
    overflow-y: auto;
    overflow-x: hidden;
  }
</style>
