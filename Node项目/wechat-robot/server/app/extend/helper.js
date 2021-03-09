const moment = require('moment')

// 格式化时间
exports.formatTime = time => moment(time).format('YYYY-MM-DD HH:mm:ss')

// 处理成功响应
exports.success = ({ ctx, res = null, msg = '请求成功' })=> {
  ctx.body = {
    code: 0,
    data: res,
    msg
  }
  ctx.status = 200
}
// 处理失败
exports.error = ({ ctx, msg = '请求失败'}) => {
  ctx.throw(1, msg)
}
