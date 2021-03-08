const Subscription = require('egg').Subscription

class UpdateCache extends Subscription {
  static get schedule () {
    const isSun = new Date().getDay()
    // 每天八点定时提醒,周日除外
    return {
      cron: '0 30 08 * * *',
      type: 'all',
      disable: isSun === 7
    }
  }

  async subscribe () {
    //  https://www.kancloud.cn/ccjin/yingq/603579 免费天气id
    const appid = 85638949
    const appsecret = 'Ydjhj3Tx'
    const version = 'v9'
    const _city = '南昌'
    const url = `https://www.tianqiapi.com/api?appid=${appid}&appsecret=${appsecret}&version=${version}&city=${_city}`
    try {
      const { data } = await this.ctx.curl(url, { dataType: 'json' })
      const { city, data: info } = data
      const { week, wea, air_tips } = info[0]
      const content = `今天是${week}, ${city}今天的天气是${wea}, ${air_tips}`
      this.postMsg(content)
    } catch (e) {
      console.log('e', e)
    }
  }

  // 执行定时推送任务
  async postMsg (content) {
    const url = 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=aeab8f24-194f-4889-a4c4-8945e1bd38c6&debug=1'
    const ctx = this.ctx
    try {
      const result = await ctx.curl(url, {
        method: 'POST',
        contentType: 'json',
        // 明确告诉 HttpClient 以 JSON 格式处理返回的响应 body
        dataType: 'json',
        data: { 
          "msgtype": "text",
          "text": {
            "content": content,
            "mentioned_list":["@all"]
          }
        }
      })
      console.log('result', result)
    } catch (e) {
      console.log('e', e)
    }
  }
}

module.exports = UpdateCache