const fs = require('fs')

// fs.rename('demo1.json', 'demo111.json', (err) => {
//   if(err) throw err
//   console.log('重命名完成')
// })

fs.stat('demo111.json', (err, stats) => {
  if (err) throw err;
  console.log(`文件属性: ${JSON.stringify(stats)}`);
});