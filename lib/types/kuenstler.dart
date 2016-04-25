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

}