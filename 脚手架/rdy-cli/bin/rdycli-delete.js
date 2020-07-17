#!/usr/bin/env node

// const inquirer = require('inquirer')
const fs = require('fs')
const tpls = require(`${__dirname}/../template`)
const tip = require('../lib/tip')
const program = require('commander')

program.parse(process.argv)
const templateName = program.args[0]
if (program.args[0] === undefined) {
  tip.fail('请输入要删除的模板名称')
  process.exit()
} else {
  if (!tpls[templateName]) {
    tip.fail('要删除的模板不存在')
    process.exit()
  } else {
    delete tpls[templateName]
    fs.writeFile(`${__dirname}/../template.json`, JSON.stringify(tpls), 'utf-8', err => {
      if (err) console.log(err)
      tip.suc('Deleted successfully!')
      tip.info(`The lasest template list is: ${JSON.stringify(tpls)}`)
      process.exit()
    })
  }
}

// let question = [
//   {
//     name: 'name',
//     message: '请输入要删除的模板名称',
//     validate (val) {
//       if (val === '') {
//         return 'Name is required'
//       } else if (!tpls[val]) {
//         tip.fail('Template does not exist')
//         process.exit()
//       } else {
//         return true
//       }
//     }
//   }
// ]

// inquirer
//   .prompt(question).then(answers => {
//     let { name } = answers
//     delete tpls[name]
//     fs.writeFile(`${__dirname}/../template.json`, JSON.stringify(tpls), 'utf-8', err => {
//       if (err) console.log(err)
//       tip.suc('Deleted successfully!')
//       tip.info('The lasest template list is:')
//       console.log(tpls)
//       console.log('\n')
//       process.exit()
//     })
//   })
