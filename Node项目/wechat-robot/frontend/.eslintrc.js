module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: [
    'plugin:vue/vue3-essential',
    '@vue/standard',
    '@vue/typescript/recommended'
  ],
  parserOptions: {
    ecmaVersion: 2020
  },
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    '@typescript-eslint/no-var-requires': 'off',
    'no-var': 'error',
    'no-dupe-args': 2,
    'no-dupe-keys': 2,
    'no-duplicate-case': 2,
    'no-empty': 2,
    'no-func-assign': 2,
    // 'valid-jsdoc': 1,
    // 数组和对象键值对最后一个逗号， never参数：不能带末尾的逗号, always参数：必须带末尾的逗号
    'comma-dangle': [2, 'never'],
    'no-unused-vars': 'error',
    eqeqeq: ['error', 'always'],
    // 强制使用单引号
    quotes: ['error', 'single'],
    // 强制不使用分号结尾
    semi: ['error', 'never'],
    camelcase: 2,
    'no-multi-spaces': ['error'],
    'no-use-before-define': ['error'],
    '@typescript-eslint/consistent-type-definitions': ['error', 'interface'],
    '@typescript-eslint/no-unused-vars': ['error'],
    'no-tabs': 0,
    indent: ['off', 2],
    // 'prettier/prettier': ['error', {
    //   endOfLine: 'crlf'
    // }]
  }
}
