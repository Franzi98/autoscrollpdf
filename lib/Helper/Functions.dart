import 'dart:io';

class Functions {
  /*
  input: link
  output: true se 
  */
  static bool checkLink(String link) {
    String extension = link.substring(link.length - 4);
    if (extension == '.pdf') {
      return true;
    } else {
      return false;
    }
  }

  /*
  input: set di Strighe, Chiave
  Output: true se la chiave esiste già 
  */
  static bool existsKey(String key, Set<String> keys) {
    bool isDuplicate = false;
    Iterator it = keys.iterator;
    while (it.moveNext()) {
      if (it.current == key) {
        isDuplicate = true;
        break;
      }
    }
    return isDuplicate;
  }

  /*
  input: path
  output: ultima stringa dopo '/'
  */
  static String makeTitle(String path) {
    List<String> list = path.split('/');
    return list.last;
  }
}
