class Filiere {
  int id;
  String nom;
  String description;
  String? image;
  List<dynamic>? listOption;
  Filiere(
      {this.image,
      required this.id,
      required this.description,
      required this.nom,
      this.listOption});

  factory Filiere.fromJson(Map<String, dynamic> json) {
    return Filiere(
        id: json['id_filiere'],
        description: json['description'],
        nom: json['nom'],
        image: json['image']);
  }
}
