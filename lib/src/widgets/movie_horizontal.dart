import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,);

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height*0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index) => _crearTarjeta(_screenSize, context, peliculas[index]),
      ),
    );
  }

  Widget _crearTarjeta(Size _screenSize,BuildContext context, Pelicula e){

    e.uuid = "${e.id}-poster";

    final _card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: e.uuid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: (e.getPosterImage() == null) ? AssetImage("assets/no-image.jpg"): NetworkImage(e.getPosterImage()),
                placeholder: AssetImage("assets/loading.gif"),
                fit: BoxFit.cover,
                height:  _screenSize.height*0.18,
              ),
            ),
          ),
          Text(e.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.subtitle1,),
        ],
      ),
    );

    return GestureDetector(
      child: _card,
      onTap: (){
        Navigator.pushNamed(context, "/detalle", arguments: e);
      },
    );
  }

  /*List<Widget>_tarjetas(Size _screenSize, BuildContext context) {
    return peliculas.map((e) {

    }).toList();
  }*/
}
