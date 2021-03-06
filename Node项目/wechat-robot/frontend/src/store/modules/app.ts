/*
 * @Author: your name
 * @Date: 2020-12-15 11:01:46
 * @LastEditTime: 2020-12-17 11:45:46
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vehicle-mp\src\store\modules\app.ts
 */
import { tagsProps, stateProps } from '../storeTypeProps'
const sessionTags = window.sessionStorage.getItem('tags')

export default {
  namespaced: true,
  state: {
    isOpen: true,
    tags: sessionTags ? [...JSON.parse(sessionTags)] : [{ title: '首页', path: '/' }]
  },
  mutations: {
    SET_OPEN (state: stateProps) {
      state.isOpen = !state.isOpen
    },
    PUSH_TAG (state: stateProps, tag: tagsProps) {
      const isTag = state.tags.findIndex((t: tagsProps) => t.path === tag.path) > -1
      if (isTag || tag.path === '/home') return
      state.tags.push(tag)
      window.sessionStorage.setItem('tags', JSON.stringify(state.tags))
    },
    DELETE_TAG (state: stateProps, tag: tagsProps) {
      const dTagIndex = state.tags.findIndex((t: tagsProps) => t.path === tag.path)
      if (dTagIndex > -1) state.tags.splice(dTagIndex, 1)
    }
  },
  actions: {
  }
}
