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
                fadeInCurve: Curves.easeIn,
                fadeOutCurve: Curves.easeInQuart,
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
