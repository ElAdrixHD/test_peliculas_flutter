import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/delegates/search_delegate.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final _peliculas = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    _peliculas.getPopularCines();
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: PeliculasSearch());
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _swiperCard(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCard() {

    return FutureBuilder(
      future: _peliculas.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(peliculas: snapshot.data,);
        }else{
          return Container(
            height: 400.0,
            child: Center(
                child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(padding: EdgeInsets.only(left: 20.0),child: Text("Populares", style: Theme.of(context).textTheme.headline5,)),
          SizedBox(height: 20.0,),
          StreamBuilder(
            stream: _peliculas.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(peliculas: snapshot.data,siguientePagina: _peliculas.getPopularCines,);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
