const Service = require('egg').Service

class UserService extends Service {
  // create======================================================================================================>
  // async create(payload) {
  //   const { ctx, service } = this
  //   const user = await service.user.register(payload)
  //   if (!user) {
  //     // ctx.throw(404, 'role is not found')
  //     ctx.helper.error({ ctx, msg: '用户已存在' })
  //   }
  //   // genHash 加密
  //   // ctx.compare 解密
  //   payload.password = await this.ctx.genHash(payload.password)
  //   return await ctx.model.User.create(payload)
  // }

  // 注册
  async register(payload) {
    const { ctx } = this
    let { realName, mobile, password } = payload
    const res = await ctx.model.User.findOne({ mobile })
    console.log(res, 'res')
    if (res) {
      ctx.helper.error({ ctx, msg: '该账号已存在' })
    }
    password = await ctx.genHash(password)
    return await ctx.model.User.create({ realName, mobile, password })
  }

  // destroy======================================================================================================>  
  async destroy(_id) {
    const { ctx } = this
    const user = await ctx.service.user.find(_id)
    if (!user) {
      ctx.throw(404, 'user not found')
    }
    return ctx.model.User.findByIdAndRemove(_id)
  }

  // update======================================================================================================>
  async update(_id, payload) {
    const { ctx, service } = this
    const user = await ctx.service.user.find(_id)
    if (!user) {
      ctx.throw(404, 'user not found')
    }
    return ctx.model.User.findByIdAndUpdate(_id, payload)
  }

  // show======================================================================================================>
  async show(_id) {
    // 查找用户id
    const user = await this.ctx.service.user.find(_id)
    if (!user) {
      this.ctx.throw(404, 'user not found')
    }
    // 查找用户id，返回关联role的数据
    return this.ctx.model.User.findById(_id).populate('role')
  }

  // index======================================================================================================>
  async index(payload) {
    const { currentPage, pageSize, isPaging, search } = payload
    let res = []
    let count = 0
    let skip = ((Number(currentPage)) - 1) * Number(pageSize || 10)
    if (isPaging) {
      if (search) {
        res = await this.ctx.model.User.find({ mobile: { $regex: search } }).populate('role').skip(skip).limit(Number(pageSize)).sort({ createdAt: -1 }).exec()
        count = res.length
      } else {
        res = await this.ctx.model.User.find({}).populate('role').skip(skip).limit(Number(pageSize)).sort({ createdAt: -1 }).exec()
        count = await this.ctx.model.User.count({}).exec()
      }
    } else {
      if (search) {
        res = await this.ctx.model.User.find({ mobile: { $regex: search } }).populate('role').sort({ createdAt: -1 }).exec()
        count = res.length
      } else {
        res = await this.ctx.model.User.find({}).populate('role').sort({ createdAt: -1 }).exec()
        count = await this.ctx.model.User.count({}).exec()
      }
    }
    // 整理数据源 -> Ant Design Pro
    let data = res.map((e, i) => {
      const jsonObject = Object.assign({}, e._doc)
      jsonObject.key = i
      jsonObject.password = 'Are you ok?'
      jsonObject.createdAt = this.ctx.helper.formatTime(e.createdAt)
      return jsonObject
    })

    return { count: count, list: data, pageSize: Number(pageSize), currentPage: Number(currentPage) }
  }

  async removes(payload) {
    return this.ctx.model.User.remove({ _id: { $in: payload } })
  }

  // Commons======================================================================================================>
  async findByMobile(mobile) {
    return this.ctx.model.User.findOne({ mobile: mobile })
  }
  // 查找用户
  async find(id) {
    return this.ctx.model.User.findById(id)
  }

  async findByIdAndUpdate(id, values) {
    return this.ctx.model.User.findByIdAndUpdate(id, values)
  }
}


module.exports = UserService