class titel {

  var id;
  var name;
  int laenge;
  var kuenstler_id;

  titel(id, name, laenge, kuenstler_id) {
    this.id = id;
    this.name = name;
    this.laenge = laenge;
    this.kuenstler_id = kuenstler_id;
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["laenge"] = this.laenge;
    map["kuenstler_id"] = this.kuenstler_id;
    return map;
  }

}