import _ from 'lodash'
import './style.css';
import img from './bg.png'

function component() {
  const element = document.createElement('div');

  // Lodash（目前通过一个 script 脚本引入）对于执行这一行是必需的
  element.innerHTML = _.join(['Hello', 'webpack'], ' ');
  element.classList.add('hello');

  var _img = new Image()
  _img.src = img;
  element.appendChild(_img)
  return element;
}

document.body.appendChild(component());