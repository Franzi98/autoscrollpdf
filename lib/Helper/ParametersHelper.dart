import 'package:shared_preferences/shared_preferences.dart';

class ParametersHelper {
  static late SharedPreferences _pref;

  static Future init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future setDuration(int duration) async {
    await _pref.setInt("Duration", duration);
  }

  static int? getDuration() {
    return _pref.getInt("Duration");
  }

  static Future setOffset(double offset) async {
    await _pref.setDouble("Offset", offset);
  }

  static double? getOffset() {
    return _pref.getDouble("Offset");
  }

  static Future setStringList(String path) async {
    List<String>? temp = getStringList();
    List<String> giusta = temp!;
    giusta.add(path);
    await _pref.setStringList("Cronologia", giusta);
  }

  static List<String>? getStringList() {
    return _pref.getStringList("Cronologia");
  }

  static Future setListLength(int length) async {
    await _pref.setInt("Lunghezza", length);
  }
}
