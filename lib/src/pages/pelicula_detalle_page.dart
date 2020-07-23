import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crarAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context,pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearElenco(pelicula),
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _crarAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(pelicula.title, style: TextStyle(color: Colors.white,fontSize: 16.0),),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImage()),
          placeholder: AssetImage("assets/loading.gif"),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 200),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _posterTitulo(BuildContext context,Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImage()),
              height: 150,
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.headline3, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis,),
                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.headline5,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Text(pelicula.overview, textAlign: TextAlign.justify,),
    );
  }

  Widget _crearElenco(Pelicula pelicula) {
    final provider = new PeliculasProvider();

    return FutureBuilder(
      future: provider.getElenco(pelicula.id), builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
    },

    );

  }

  Widget _crearActoresPageView(List<Actor> data) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemBuilder: (context, i){
          return Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: (data[i].getFoto() == null) ? AssetImage("assets/no-image.jpg"): NetworkImage(data[i].getFoto()),
                  placeholder: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
              Text(data[i].name, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.subtitle1,),
            ],
          );
        },
        itemCount: data.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
      ),
    );
  }
}
