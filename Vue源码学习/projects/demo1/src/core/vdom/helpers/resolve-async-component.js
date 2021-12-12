/* @flow */

import {
  warn,
  once,
  isDef,
  isUndef,
  isTrue,
  isObject,
  hasSymbol
} from 'core/util/index'

import { createEmptyVNode } from 'core/vdom/vnode'

function ensureCtor (comp: any, base) {
  if (comp.__esModule || (hasSymbol && comp[Symbol.toStringTag] === 'Module')) {
    comp = comp.default
  }
  return isObject(comp) ? base.extend(comp) : comp
}

export function createAsyncPlaceholder (
  factory: Function,
  data: ?VNodeData,
  context: Component,
  children: ?Array<VNode>,
  tag: ?string
): VNode {
  const node = createEmptyVNode()
  node.asyncFactory = factory
  node.asyncMeta = { data, context, children, tag }
  return node
}

export function resolveAsyncComponent (
  factory: Function,
  baseCtor: Class<Component>,
  context: Component
): Class<Component> | void {
  // 如果error 为true并且errorComp 组件存在，则渲染加载失败组件
  if (isTrue(factory.error) && isDef(factory.errorComp)) {
    return factory.errorComp
  }
  // 如果显示加载成功状态，则直接返回
  if (isDef(factory.resolved)) {
    return factory.resolved
  }

  // 如果组件loading存在 并且loading 组件存在，则直接加载loading 组件
  if (isTrue(factory.loading) && isDef(factory.loadingComp)) {
    return factory.loadingComp
  }

  // 如果contexts存在，就加入队列里面
  if (isDef(factory.contexts)) {
    // already pending
    factory.contexts.push(context)
  } else {
    const contexts = (factory.contexts = [context])
    let sync = true

    // 强制更新组件
    const forceRender = () => {
      for (let i = 0, l = contexts.length; i < l; i++) {
        contexts[i].$forceUpdate()
      }
    }

    // 加载组件成功
    const resolve = once((res: Object | Class<Component>) => {
      // cache resolved
      factory.resolved = ensureCtor(res, baseCtor)
      // invoke callbacks only if this is not a synchronous resolve
      // (async resolves are shimmed as synchronous during SSR)
      if (!sync) {
        forceRender()
      }
    })

    // 加载组件失败后，强制渲染失败组件
    const reject = once((reason) => {
      process.env.NODE_ENV !== 'production' &&
        warn(
          `Failed to resolve async component: ${String(factory)}` +
            (reason ? `\nReason: ${reason}` : '')
        )
      if (isDef(factory.errorComp)) {
        factory.error = true
        forceRender()
      }
    })

    const res = factory(resolve, reject)

    if (isObject(res)) {
      if (typeof res.then === 'function') {
        // () => Promise
        if (isUndef(factory.resolved)) {
          res.then(resolve, reject)
        }
      } else if (
        isDef(res.component) &&
        typeof res.component.then === 'function'
      ) {
        // 这里处理高级异步组件
        /**
         * const AsyncComp = () => ({
        // 需要加载的组件。应当是一个 Promise
        component: import('./MyComp.vue'),
        // 加载中应当渲染的组件
        loading: LoadingComp,
        // 出错时渲染的组件
        error: ErrorComp,
        // 渲染加载中组件前的等待时间。默认：200ms。
        delay: 200,
        // 最长等待时间。超出此时间则渲染错误组件。默认：Infinity
        timeout: 3000
      })
      Vue.component('async-example', AsyncComp)
         */

        // 这里异步加载组件，传入resolve，reject
        res.component.then(resolve, reject)

        /**
         * 接下来是加载异步组件时的一些效果，例如加载失败，加载中loading、或延时执行。
         */
        if (isDef(res.error)) {
          factory.errorComp = ensureCtor(res.error, baseCtor)
        }

        // 如果loading存在，pending状态，需要加载loading组件
        if (isDef(res.loading)) {
          factory.loadingComp = ensureCtor(res.loading, baseCtor)
          if (res.delay === 0) {
            factory.loading = true
          } else {
            setTimeout(() => {
              if (isUndef(factory.resolved) && isUndef(factory.error)) {
                factory.loading = true
                forceRender()
              }
            }, res.delay || 200)
          }
        }

        if (isDef(res.timeout)) {
          setTimeout(() => {
            if (isUndef(factory.resolved)) {
              reject(
                process.env.NODE_ENV !== 'production'
                  ? `timeout (${res.timeout}ms)`
                  : null
              )
            }
          }, res.timeout)
        }
      }
    }

    sync = false
    // return in case resolved synchronously
    return factory.loading ? factory.loadingComp : factory.resolved
  }
}
