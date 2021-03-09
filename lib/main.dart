import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_movies/src/pages/home_page.dart';
import 'package:flutter_movies/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      // routes: {
      //   '/': (BuildContext context) => HomePage(),
      //   'detail': (BuildContext context) => MovieDetail(),
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'detail':
            return PageTransition(
              child: MovieDetail(),
              // duration: Duration(seconds: 1),
              // alignment: Alignment.center,
              type: PageTransitionType.rightToLeft,
              settings: settings,
            );
            break;
          case '/':
            return PageTransition(
              child: HomePage(),
              // duration: Duration(seconds: 1),
              // alignment: Alignment.center,
              type: PageTransitionType.rightToLeft,
              settings: settings,
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
