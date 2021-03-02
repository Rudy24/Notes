import _ from 'lodash'
import printMe from './print.js';

function component() {
  const element = document.createElement('div');
  var btn = document.createElement('button');

  // Lodash（目前通过一个 script 脚本引入）对于执行这一行是必需的
  element.innerHTML = _.join(['Hello', 'webpack'], ' ');
  // btn.innerHTML = 'Click me and check the console!';
  // btn.onclick = printMe;
  element.onclick = printMe.bind(null, 'Hello webpack')
  element.appendChild(btn);
  return element;
}

document.body.appendChild(component());