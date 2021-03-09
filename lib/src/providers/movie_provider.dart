import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_movies/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '808767908eacee8a687bd487d957e2a8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _processResponse(Uri uri) async {
    final resp = await http.get(uri);
    final decodedDate = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedDate['results']);
    return movies.items;
  }

  Future<List<Movie>> getMoviesInTheaters() {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return _processResponse(url);
  }

  Future<List<Movie>> getPopularMovies() {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
    });
    return _processResponse(url);
  }
}
