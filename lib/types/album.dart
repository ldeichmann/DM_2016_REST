import 'package:dm_rest/types/kuenstler.dart';
import 'package:dm_rest/types/titel.dart';

class album {

  String id;
  String name;
  String k;
  List<titel> titelList;
  double preis;

  album(id, name, k, preis) {
    this.id = id;
    this.name = name;
    this.k = k;
    this.preis = preis;
    titelList = new List();
  }

  void addTitel(titel t) {
    this.titelList.add(t);
  }

  void removeTitel(titel t) {
    this.titelList.remove(t);
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["kuenstler"] = this.k;
    map["titel"] = this.titelList;
    map["preis"] = this.preis;
    return map;
  }

}