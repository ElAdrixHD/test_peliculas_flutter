import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class PeliculasSearch extends SearchDelegate{

  final provider =  PeliculasProvider();

  final peliculas = [
    "Spiderman",
    "Pokemon",
    "Boku no Hero",
    "Antman",
    "Ironman",
    "Capitan America",
    "Scooby",
    "Rambo",
    "Batman",
  ];

  String seleccion = "";

  final peliculasRecientes =[
    "Spiderman",
    "Pokemon",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones del appbar (cancelar, limpiar...)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,
      ), onPressed: () {
        close(context, null);
    },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder de los resultados
    /*return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Son las sugerencias

   if(query.isEmpty){
     return Container();
   }else{
     return FutureBuilder(
       future:provider.buscarPelicula(query), builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
         if(snapshot.hasData){
           return ListView(
             children: snapshot.data.map((e) => ListTile(
               leading: FadeInImage(
                 image:(e.getPosterImage()== null)? AssetImage("assets/no-image.jpg") : NetworkImage(e.getPosterImage()), placeholder: AssetImage("assets/loading.gif"), width: 50.0, fit: BoxFit.contain,
               ),
               title: Text(e.title),
               subtitle: Text(e.originalTitle),
               onTap: (){
                 close(context,null);
                 Navigator.pushNamed(context, "/detalle", arguments: e);
               },
             )).toList(),
           );
         }else{
           return Center(child: CircularProgressIndicator(),);
         }
     },
     );
   }



    /*
     final listaSugerida = (query.isEmpty) ? peliculas: peliculas.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, i){
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[i]),
            onTap: (){
              seleccion = listaSugerida[i];
              showResults(context);
            },
          );
        }
    );*/
  }

}