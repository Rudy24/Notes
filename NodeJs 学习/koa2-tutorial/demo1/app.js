const Koa = require('koa')
const app = new Koa()

// logger
app.use(async (ctx, next) => {
  await next();
  const rt = ctx.response.get('X-Response-Time')
  console.log(`${ctx.method} ${ctx.url} - ${rt}`);
});

// r-response-time
app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  ctx.set('X-Response-Time', `${ms}ms`);
});

app.keys = ['im a newer secret', 'i like turtle'];
// app.keys = new KeyGrip(['im a newer secret', 'i like turtle'], 'sha256');
 app.context.name = 'rudy'

app.use(async ctx => {
  ctx.cookies.set('name', 'tobi11', { signed: true });
  console.log('ctx.name', ctx.name)
  ctx.body = 'hello world';
});

app.listen(3000, () => {
  console.log('server is running at http://localhost:3000')
})