import "dart:io";
import 'dart:convert';

import 'package:autoscrollpdf/Helper/Functions.dart';
import 'package:autoscrollpdf/utily/tags.dart';

class Song {
  //non è necessario convertire la classe file, basta la stringa path

  //title è anche la chiave dell'oggetto salvato in shared preferences,
  //ogni volta che si cambia il titolo viene creato una nuova istanza di song con key = title;
  late String title;
  String path;
  late int duration;
  late double offset;
  late List<String> tags;

  Song({required this.path}) {
    title = Functions.makeTitle(path);
    duration = 10;
    offset = 0.2;
    tags = ["notag"];
  }

  /*
    Crea un oggetto Song da un file json
  */
  Song.fromJson(Map<dynamic, dynamic> json)
      : path = json['path'],
        title = json['title'],
        duration = json['duration'],
        offset = json['offset'],
        tags = List<String>.from(json['tags']);
  /*
  Trasforma l'oggetto in un file JSon
  */
  Map<String, dynamic> toJson() => {
        "path": path,
        "title": title,
        "duration": duration,
        "offset": offset,
        "tags": tags
      };

  /*
  Quando viene chiamato il costruttore da Json, bisogna usare questo metodo per creare il file
  */

  File get file {
    return File(path);
  }

  // Il titolo può essere cambiato dall'utente, per la key è necessario creare sempre il titolo originale
  String get getTitle {
    return title;
  }

  List<String> get getTagsAsString {
    List<String> tempTags = [];
    if (tags.isEmpty) {
      return ["noTags"];
    } else {
      tags.forEach((element) {
        List<String> path = element.split('.');
        tempTags.add(path.last);
      });
      return tempTags;
    }
  }

/*

  List<TAGS> get getTagsAsTags {
    if (tags.isEmpty) {
      return [TAGS.notag];
    } else {
      List<TAGS> tempTags = [];
      tags.forEach((element) {
        if(element == ""){
          
        }
      });
    }
  }
*/
  void addTitle(String title) {
    this.title = title;
  }

  void setOffset(double x) {
    offset = x;
  }

  void addTag(List<String> tag) {
    //quando inserisco un tag allora elimino il notag
    tags.clear();
    for (int i = 0; i <= tag.length - 1; i++) {
      print("tag aggiunto: ${tag[i]}");
      tags.add(tag[i]);
    }
    tags.remove("notag");
  }

  void removeTag(String tag) {
    //aggiunge notags se i tag sono vuoti dopo la cancellazione
    tags.remove(tag);
    if (tags.isEmpty) {
      tags.add("notags");
    }
  }

  void setDuration(int x) {
    duration = x;
  }
}
