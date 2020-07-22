import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height*0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _tarjetas(_screenSize, context),
      ),
    );
  }

  List<Widget>_tarjetas(Size _screenSize, BuildContext context) {
    return peliculas.map((e) {
      return GestureDetector(
        onTap: () => print(e.title),
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(e.getPosterImage()),
                  placeholder: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                  height:  _screenSize.height*0.18,
                ),
              ),
              Text(e.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.subtitle1,),
            ],
          ),
        ),
      );
    }).toList();
  }
}