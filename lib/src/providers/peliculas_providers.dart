
import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apiKey = "9f1edf4c85f59a4a5e76d5d8296df130";
  String _host = "api.themoviedb.org";
  String _laguage = "es-ES";
  int _popularesPage = 1;
  bool _cargando = false;


  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async{
    final _url = Uri.https(_host,"3/movie/now_playing", {
      "api_key": _apiKey,
      "language": _laguage
    });

    return await peticionHTTP(_url);

  }

  Future<List<Pelicula>> getPopularCines() async{
    if(_cargando) return[];
    _cargando = true;

    final _url = Uri.https(_host,"3/movie/popular", {
      "api_key": _apiKey,
      "language": _laguage,
      "page"    : (_popularesPage++).toString()
    });

    final response = await peticionHTTP(_url);

    _populares.addAll(response);
    popularesSink(_populares);
    _cargando = false;
    return response;

  }

  Future<List<Pelicula>> peticionHTTP(Uri _url) async {
    final response = await http.get(_url);
    final decodedData = json.decode(response.body);
    final peliculas = new Peliculas.fromJsonList(decodedData["results"]);

    return peliculas.items;
  }
}