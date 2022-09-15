import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Classes/Song.dart';

class ParametersHelper {
  static late SharedPreferences _pref;

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  /*
  input: Song
  output: salva in formato json l'input
  */
  static Future saveSong(Song song) async {
    String json = jsonEncode(song.toJson());
    return _pref.setString(song.title, json);
  }

  /*
  input: key
  output: instanza della classe song convertita da json
  */
  static Song getSong(String key) {
    Map json = jsonDecode(_pref.getString(key)!);
    return Song.fromJson(json);
  }

  static List<Song> getSongs() {
    List<Song> songs = [];
    ParametersHelper.getKeys().forEach((element) {
      songs.add(getSong(element));
    });
    return songs;
  }

  //ritorna tutte le chiavi salvate iin memoria
  static Set<String> getKeys() {
    return _pref.getKeys();
  }

  static void delete(String key) {
    _pref.remove(key);
  }

  static void deleteAll() {
    _pref.clear();
  }
}
