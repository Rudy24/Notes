#!/usr/bin/env node

const program = require('commander')
const ora = require('ora')
const tpls = require(`${__dirname}/../template`)
const tip = require('../lib/tip')
const exec = require('child_process').exec
const download = require('download-git-repo')
const inquirer = require('inquirer')


program
  .usage('<template-name> [project-name]')

let question = [
  {
    name: 'templateName',
    type: 'input',
    message: '请输入模板名称',
    validate(val) {
      if (val === '') {
        return '请输入模板名称'
      } else if (!tpls[val]) {
        return '模板不存在'
      } else {
        return true
      }
    }
  },
  {
    name: 'projectName',
    type: 'input',
    message: '请输入新建文件夹名称',
    validate(val) {
      if (val === '') {
        return '文件夹不能为空'
      } else {
        return true
      }
    }
  },
  {
    name: 'type',
    type: 'list',
    message: '请输入仓库地址类型',
    choices: ['github', 'gitlab'],
    validate(val) {
      type = val
    }
  }
]

inquirer
  .prompt(question).then(answers => {
    let { templateName, type, projectName } = answers
    let url = tpls[templateName]
    tip.suc('Start generating...')

    const spinner = ora('Download...')

    if (type === 'gitlab' && url.indexOf('gitlab') === -1) {
      const execRm = (err, projectName) => {
        spinner.stop()
        if (err) {
          console.log(err)
          tip.fail('请重新运行!')
          process.exit()
        }

        tip.suc('初始化完成!')
        tip.suc(`cd ${projectName} && npm install`)
        process.exit()
      }

      const downloadProject = (err, projectName) => {
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

      exec(cmdStr, (err) => {
        downloadProject(err, projectName)
      })
    } else {
      const prefix = type === 'gitlab' ? 'gitlab' : 'direct'
      url = `${prefix}:${url}`
      spinner.start()
      // 执行下载方法并传入参数
      download(
        url,
        projectName,
        {
          clone: true
        },
        err => {
          if (err) {
            spinner.fail();
            tip.fail(`Generation failed. ${err}`)
            return
          }
          // 结束加载图标
          spinner.succeed();
          tip.suc('Generation completed!')
          tip.suc('To get started')
          tip.suc(`cd ${projectName}`)
        }
      )
    }
  })