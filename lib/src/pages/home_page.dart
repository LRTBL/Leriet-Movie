import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie_model.dart';
import 'package:flutter_movies/src/providers/movie_provider.dart';
import 'package:flutter_movies/src/widgets/card_swiper_widget.dart';
import 'package:flutter_movies/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MovieProvider();

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movieProvider.getPopularMovies();

    return Scaffold(
        appBar: AppBar(
          title: Text("Peliculas en cines"),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("CLick");
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: movieProvider.getMoviesInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) return CardSwiper(movies: snapshot.data);
        return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 10.0),
          StreamBuilder(
            stream: movieProvider.popularsStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData)
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: movieProvider.getPopularMovies,
                );
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
