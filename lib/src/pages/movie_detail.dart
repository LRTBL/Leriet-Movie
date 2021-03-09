import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("TITULO"),
        ),
        body: Center(
          child: Text("${movie.title}"),
        ),
      ),
    );
  }
}
