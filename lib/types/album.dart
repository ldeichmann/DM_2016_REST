import 'package:dm_rest/types/kuenstler.dart';
import 'package:dm_rest/types/titel.dart';

class album {

  static List<album> albumList = new List();

  static album findAlbum(String searchID) {
    for (album a in albumList) {
      if (a.id.toString() == searchID) {
        return a;
      }
    }
    return null;
  }

  static bool addAlbum(album a) {
    albumList.add(a);
    return true;
  }

  static bool deleteAlbum(String searchID) {
    album al = findAlbum(searchID);
    if (al != null) {
      return albumList.remove(al);
    }
    return false;
  }

  static String nextAlbumID() {
    if (albumList.length == 0) {
      return "a0";
    } else {
      return "a" + ((int.parse(albumList.last.id.substring(1))) + 1).toString();
    }
  }

  String id;
  String name;
  String kuenstler_id;
  List<titel> titelList;
  double preis;

  album(id, name, kuenstler_id, preis) {
    this.id = id;
    this.name = name;
    this.kuenstler_id = kuenstler_id;
    this.preis = preis;
    titelList = new List();

    albumList.add(this);
  }

  void addTitel(titel t) {
    this.titelList.add(t);
  }

  void removeTitel(titel t) {
    this.titelList.remove(t);
  }

  titel findTitel(String searchID) {
    for (titel a in titelList) {
      if (a.id.toString() == searchID) {
        return a;
      }
    }
    return null;
  }

  bool deleteTitel(String searchID) {
    titel t = findTitel(searchID);
    if (t != null) {
      return albumList.remove(t);
    }
    return false;
  }

  String nextTitelID() {
    if (titelList.length == 0) {
      return "t0";
    } else {
      return "t" + ((int.parse(titelList.last.id.substring(1))) + 1).toString();
    }
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["kuenstler"] = this.kuenstler_id;
    map["titel"] = this.titelList;
    map["preis"] = this.preis;
    return map;
  }

}