import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_movies/src/models/movie_model.dart';

class MovieProvider {
  String _apikey = '808767908eacee8a687bd487d957e2a8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularPage = 0;
  bool _load = false;

  List<Movie> _populars = new List<Movie>();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularsStream => _popularStreamController.stream;

  void disposeScreams() {
    _popularStreamController?.close();
  }

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

  Future<List<Movie>> getPopularMovies() async {
    if (_load) return [];
    _load = true;
    _popularPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString(),
    });
    final resp = await _processResponse(url);
    _populars.addAll(resp);
    popularsSink(_populars);
    _load = false;
    return resp;
  }
}
