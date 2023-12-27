import 'package:gde_web/models/Options.dart';

class Filiere {
  int id;
  String nom;
  String description;
  String? image;
  List<dynamic>? list_option;
  Filiere(
      {this.image,
      required this.id,
      required this.description,
      required this.nom,
      this.list_option});

  factory Filiere.fromJson(Map<String, dynamic> json) {
    print(json);
    return Filiere(
        id: json['id_filiere'],
        description: json['description'],
        nom: json['nom'],
        image: json['image']);
  }
}
