// import 'package:flutter/material.dart';

// class HeroAnimation extends StatelessWidget {
//   Widget build(BuildContext context) {
//     timeDilation = 5.0; // 1.0 means normal animation speed.

//     return new Scaffold(
//       appBar: new AppBar(
//         title: const Text('Basic Hero Animation'),
//       ),
//       body: new Center(
//         child: new PhotoHero(
//           photo: 'images/flippers-alpha.png',
//           width: 300.0,
//           onTap: () {
//             Navigator.of(context).push(new MaterialPageRoute<Null>(
//               builder: (BuildContext context) {
//                 return new Scaffold(
//                   appBar: new AppBar(
//                     title: const Text('Flippers Page'),
//                   ),
//                   body: new Container(
//                     // The blue background emphasizes that it's a new route.
//                     color: Colors.lightBlueAccent,
//                     padding: const EdgeInsets.all(16.0),
//                     alignment: Alignment.topLeft,
//                     child: new PhotoHero(
//                       photo: 'images/flippers-alpha.png',
//                       width: 100.0,
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ),
//                 );
//               }
//             ));
//           },
//         ),
//       ),
//     );
//   }
// }
