/*
 * @Author: your name
 * @Date: 2020-12-15 17:22:34
 * @LastEditTime: 2020-12-16 15:40:25
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\hooks\ResizeHandler.ts
 */

import { onMounted, onUnmounted, ref, Ref } from 'vue'

const ResizeHandler = (): Ref<string> => {
  const _h = ref('100%')
  const setHeight = (): void => { _h.value = document.documentElement.clientHeight - 110 + 'px' }
  setHeight()
  onMounted(() => window.addEventListener('resize', setHeight))
  onUnmounted(() => window.removeEventListener('resize', setHeight))
  return _h
}
export default ResizeHandler
