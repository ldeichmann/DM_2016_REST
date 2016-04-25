class kuenstler {

  static List<kuenstler> kuenstlerList = new List();

  static kuenstler findKuenstler(String searchID) {
    for (kuenstler a in kuenstlerList) {
      if (a.id.toString() == searchID) {
        return a;
      }
    }
    return null;
  }

  static bool addKuenstler(kuenstler k) {
    kuenstlerList.add(k);
    return true;
  }

  static bool deleteKuenstler(String searchID) {
    kuenstler al = findKuenstler(searchID);
    if (al != null) {
      return kuenstlerList.remove(al);
    }
    return false;
  }

  static String nextKuenstlerID() {
    if (kuenstlerList.length == 0) {
      return "k0";
    } else {
      return "k" + ((int.parse(kuenstlerList.last.id.substring(1))) + 1).toString();
    }
  }

  String id;
  var name;
  var biographie;
  var herkunft;

  kuenstler(id, name, biographie, herkunft) {
    this.id = id;
    this.name = name;
    this.biographie = biographie;
    this.herkunft = herkunft;
  }

  String toString() {
    return "id: " + this.id.toString() + " name: " + this.name + " bio: " + this.biographie + " herkunft: " + this.herkunft;
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["biographie"] = this.biographie;
    map["herkunft"] = this.herkunft;
    return map;
  }

}