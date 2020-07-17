#!/usr/bin/env node
const program = require('commander')

program
  .version(require('../package').version) // 当前版本
  .usage('<command> [options]') // 使用方法
  .command('add', 'add a new template')
  .command('delete', 'delete a template')
  .command('list', 'list all templates')
  .command('init', 'create a new project from a template')


program.parse(process.argv)