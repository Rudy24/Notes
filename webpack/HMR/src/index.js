import _ from 'lodash'
import printMe from './print.js';
import './styles.css'

function component() {
  const element = document.createElement('div');
  var btn = document.createElement('button');

  // Lodash（目前通过一个 script 脚本引入）对于执行这一行是必需的
  element.innerHTML = _.join(['Hello', 'webpack'], ' ');
  btn.innerHTML = 'Click me and check the console11111111111!';
  btn.onclick = printMe;
  element.appendChild(btn);

  return element;
}

if (module.hot) {
  module.hot.accept('./print.js', () => {
    console.log('Accepting the updated printMe module')
    printMe();
  })
}

document.body.appendChild(component());