class Actores{
  List<Actor> actores = new List();

  Actores.fromJsonList(List<dynamic> json){
    if (json == null) return;
    
    json.forEach((element) { 
      final actor = Actor.fromJson(element);
      actores.add(actor);
    });
  }
}

class Actor {
  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    gender: json["gender"],
    id: json["id"],
    name: json["name"],
    order: json["order"],
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
  );

  Map<String, dynamic> toJson() => {
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "gender": gender,
    "id": id,
    "name": name,
    "order": order,
    "profile_path": profilePath == null ? null : profilePath,
  };

  String getFoto(){
    if(profilePath == null){
      return null;
    }else{
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
