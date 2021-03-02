# FadeInImage --- 带有占位符图片显示器

加载网络图片时候，因为网络或图片大小的原因，不能第一时间展示出图片，而显示空白位置，
给用户带来不好的体验，Flutter 为我们提供了带有占位符的图片显示器。

```javascript

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadeInImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FadeInImage demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Image.network(
                  'http://n.sinaimg.cn/sinacn20111/600/w1920h1080/20190902/2e86-ieaiqii0276354.jpg'),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 200,
              child: FadeInImage.assetNetwork(
                fadeInDuration: Duration(seconds: 1),
                fadeInCurve: Curves.easeIn, // 网络图片显示动画
                fadeOutCurve: Curves.easeInQuart, // 占位符图片小时动画
                fadeOutDuration: Duration(seconds: 1),
                image:
                    'http://n.sinaimg.cn/sinacn20111/600/w1920h1080/20190902/2e86-ieaiqii0276354.jpg',
                placeholder: 'assets/loading.gif',
              ),
            )
          ],
        ),
      ),
    );
  }
}

```

效果是不是好了很多呢？占位符图片可以自行更改。

![](flutter_fade_in_image1.0.gif)
