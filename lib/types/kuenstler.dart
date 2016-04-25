class kuenstler {

  var id;
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