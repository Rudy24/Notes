const crypto = require('crypto')

module.exports = {
  // 创建token
  createToken(data, expires, strTimer) {
    const { app } = this
    return app.jwt.sign(data, app.config.jwt.secret, {
      expiresIn: `${expires} ${strTimer}`
    })
  },
  // 获取头部token
  getAccessToken() {
    const bearerToken = this.ctx.request.header.authorization
    return !!bearerToken && bearerToken.replace('Bearer', '');
  },
  // 校验token
  async verifyToken() {
    let backResult = false
    const token = this.getAccessToken()
    const verify = await function (token) {
      const result = {}
      const { app } = this.app
      app.jwt.verify(token, app.config.jwt.secret, (err, decoded) => {
        if (err) {
          result.verify = false
          result.message = err.message
        } else {
          result.verify = true
          result.message = decoded
        }
      })
      return result
    }
    const verifyResult = verify(token)
    const tokenInfo = await this.ctx.service.admin.login.findToken(token)
    // token验证失效了
    if (!verifyResult.verify) {
      // 查询7days 的refresh_token
      if (tokenInfo) {
        if (!verify(tokenInfo.refresh_token).verify) {
          await this.error(401, 200, 'token身份认证失效，请重新登陆')
        } else {
          // 2小时的 token 验证失败了,但是能查到对应的 refresh_token 并且在有效期内就重新生成新的 token
          const refresh_token = await this.createToken({ id: tokenInfo.uid }, "7", "days")
          const access_token = await this.createToken({ id: tokenInfo.uid }, "2", "hours")
          const { id, uid } = { id: tokenInfo.id, uid: tokenInfo.uid }
          await this.ctx.service.admin.login.saveToken({ id, uid, access_token, refresh_token })
          await this.error(200, 11000, access_token)
        }
      } else {
        // 2小时的 token 验证失败了并且查不到对应的 refresh_token
        await this.error(401, 200, "token身份认证失效,请重新登录")
      }
    } else {
      if (tokenInfo) {
        // 2小时的 token 验证通过了并且可以查到对应的 refresh_token
        backResult = true
      } else {
        // 2小时的 token 验证通过了但是查不到对应的 refresh_token
        this.error(401, 200, "该账号已在其他地方登陆,请重新登录")
      }
    }

    return backResult
  },
  // MD5对密码和密钥进行混合双重加密
  async cryptoMd5(password, key) {
    const hash1 = await crypto.createHash('md5').update(password).digest('hex')
    const hash2 = await crypto.createHash('md5').update(hash1 + key).digest('hex')
    return hash2
  }
}