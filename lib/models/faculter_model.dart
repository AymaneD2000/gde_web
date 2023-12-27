class Faculter {
  int idfaculter;
  String nom;
  String sigle;
  String email;
  String description;
  String image;
  String localisation;
  int idUniv;
  Faculter(
      {required this.description,
      required this.email,
      required this.idUniv,
      required this.idfaculter,
      required this.image,
      required this.localisation,
      required this.nom,
      required this.sigle});
  factory Faculter.fromJson(Map<String, dynamic> json) {
    return Faculter(
        description: json["description"],
        email: json["email"],
        idUniv: json["id_univ"],
        idfaculter: json["id_faculte"],
        image: json["image"],
        localisation: json["localisation"],
        nom: json["nom"],
        sigle: json["sigle"]);
  }
}
