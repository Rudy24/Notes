// import _ from 'lodash'

function component() {
  const element = document.createElement('div');

  // Lodash（目前通过一个 script 脚本引入）对于执行这一行是必需的
  element.innerHTML = join.join(['Hello', 'webpack'], ' ');

  return element;
}

document.body.appendChild(component());