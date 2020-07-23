import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return  Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uuid = "${peliculas[index].id}-tarjeta";

          return Hero(
            tag: peliculas[index].uuid,
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/detalle", arguments: peliculas[index]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImage()),
                  placeholder: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );


        },
        itemCount: peliculas.length,
        itemWidth: _size.width * 0.7,
        itemHeight: _size.height * 0.5,
        // pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
