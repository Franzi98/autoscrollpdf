import 'dart:io';

import 'package:autoscrollpdf/utily/tags.dart';

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

  /*
  input: TAGS
  output: tag as String
  */
  static tagToString(TAGS tag) {
    return tag.toString().split('.').last;
  }

  static listTagsToListString(List<TAGS> tags) {
    List<String> res = [];
    tags.forEach((element) {
      res.add(element.toString().split('.').last);
    });
    return res;
  }

  /*
  input: two String list
  output: list1-list2
  */
  List<String> differentTwoList(List<String> list1, List<String> list2) {
    int len1 = list1.length - 1;
    int len2 = list2.length - 1;

    if (len1 >= len2) {
      for (int i = 0; i <= len1 - 1; i++) {
        for (int j = 0; j <= len2; j++) {
          if (list1[i] == list2[j]) {
            list1.removeAt(i);
            len1--;
            list2.removeAt(j);
            len2--;
          }
        }
      }
      return list1;
    } else {
      for (int i = 0; i < len2; i++) {
        for (int j = 0; j < len1; j++) {
          if (list1[i] == list2[j]) {
            list1.removeAt(i);
            len1--;
            list2.removeAt(j);
            len2--;
          }
        }
      }
      return list2;
    }
  }
}
