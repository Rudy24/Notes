### path.join()和path.resolve()区别

path.join(): 使用平台特定的分隔符把所有 path 片段连接到一起，并规范化生成的路径。
空字符串的 path 片段会被忽略。 如果连接后的路径是一个空字符串，则返回 '.'，表示当前工作目录。

    path.join('/foo/', 'bar', 'baz/asdf', 'qqqq', '...')

    \\foo\\bar\\baz\\asdf\\qqqq\\...

path.resolve(): 将路径或路径片段处理成绝对路径。
path 从右到左依次处理，直到构造出绝对路径
例如，指定的路径片段是：/foo、/bar、baz，则调用 path.resolve('/foo', '/bar', 'baz') 会返回 /bar/baz。
如果处理完全部 path 片段后还未产生绝对路径，则加上当前工作目录。
生成的路径会进行规范化，并且删除末尾的斜杠，除非路径是根目录。

空字符串的 path 片段会被忽略。
如果没有指定 path，则返回当前工作目录的绝对路径。

    path.resolve('/foo/bar', './baz');
    // 返回: '/foo/bar/baz'

    path.resolve('/foo/bar', '/tmp/file/');
    // 返回: '/tmp/file'

    path.resolve('wwwroot', 'static_files/png/', '../gif/image.gif');
    // 如果当前工作目录是 /home/myself/node，则返回 '/home/myself/node/wwwroot/static_files/gif/image.gif'