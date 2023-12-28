class Formation {
  int? id;
  String nom;
  String description;
  String image;
  int idCtf;
  String duree;

  Formation(
      {this.id,
      required this.idCtf,
      required this.description,
      required this.nom,
      required this.image,
      required this.duree});

  // fromJson method to create a Formation object from a Map
  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
      idCtf: json['id_ctf'],
      duree: json["duree"],
      id: json['id_module'],
      nom: json['nom_module'],
      description: json['description'],
      image: json['image'],
    );
  }
}
