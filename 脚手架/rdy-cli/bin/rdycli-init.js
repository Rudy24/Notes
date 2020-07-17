#!/usr/bin/env node

const program = require('commander')
const ora = require('ora')
const tpls = require(`${__dirname}/../template`)
const tip = require('../lib/tip')
const exec = require('child_process').exec

program
  .usage('<template-name> [project-name]')

  program.parse(process.argv)

  if (program.args.length < 1) return program.help()

let templateName = program.args[0]
let projectName = program.args[1]

if (!tpls[templateName]) {
  tip.fail('Template should not be empty!')
  return
}

if (!projectName) {
  tip.fail('Project should not be empty!')
  return
}

url = tpls[templateName]

tip.suc('Start generating...')

const spinner = ora('Download...')

const execRm = (err, projectName) => {
  spinner.stop()
  if (err) {
    console.log(err)
    tip.fail('请重新运行!')
    process.exit()
  }

  tip.suc('初始化完成!')
  tip.info(`cd ${projectName} && npm install`)
  process.exit()
}

const download = (err, projectName) => {
  if (err) {
    console.log(err)
    tip.fail('请重新运行')
    process.exit()
  }

  exec(`cd ${projectName} && rm -rf .git`, (err, out) => {
    execRm(err, projectName)
  })
}

const cmdStr = `git clone ${url} ${projectName} && cd ${projectName}`

spinner.start()

console.log('正在下载中...')

exec(cmdStr, (err) => {
  download(err, projectName)
})