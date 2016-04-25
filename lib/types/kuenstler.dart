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
    return this.id.toString() + " " + this.name + " " + this.biographie + " " + this.herkunft;
  }

}