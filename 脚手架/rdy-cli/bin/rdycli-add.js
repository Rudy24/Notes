#!/usr/bin/env node

const inquirer = require('inquirer')
const tip = require('../lib/tip')
const fs = require('fs')
const tpls = require(`${__dirname}/../template`)

let question = [
  {
    name: 'name',
    type: 'input',
    message: '请输入模板名称',
    validate (val) {
      if (val === '') {
        return '请输入模板名称'
      } else if (tpls[val]) {
        return '模板已存在'
      } else {
        return true
      }
    }
  },
  {
    name: 'url',
    type: 'input',
    message: '请输入模板地址',
    validate (val) {
      if (val === '') return '请输入模板地址!'
      return true
    }
  }
]

inquirer
  .prompt(question).then(answers => {
    let { name, url } = answers
    tpls[name] = url.replace(/[\u0000-\u0019]/g, '')
    fs.writeFile(`${__dirname}/../template.json`, JSON.stringify(tpls), 'utf-8', err => {
      if (err) console.log(err)
      tip.suc('新增模板成功')
      tip.info(`最新的模板列表: ${JSON.stringify(tpls)}`)
    })
  })