//import 'package:gde_web/main.dart';
import 'package:gde_web/models/Structure.dart';
import 'package:gde_web/models/faculter_model.dart';

class AdminStructure {
  String username;
  String nom;
  String prenom;
  String password;
  String email;
  String genre;
  String telephone;
  String? photo;
  int? structureId;
  int? idfaculte;
  Structure? structure;
  Faculter? faculter;
  AdminStructure(
      {this.structure,
      this.faculter,
      this.idfaculte,
      required this.username,
      required this.nom,
      required this.prenom,
      required this.password,
      required this.email,
      required this.genre,
      this.structureId,
      required this.telephone,
      this.photo});

  // toJson method to convert AdminStructure object to a Map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nom': nom,
      'prenom': prenom,
      'password': password,
      'email': email,
      'genre': genre,
      'telephone': telephone,
      'avatar_url': photo ?? "",
      'structure_id': structureId,
      //structure?.toJson(), // Assuming Structure has a toJson method
    };
  }

  // fromJson method to create an AdminStructure object from a Map
  factory AdminStructure.fromJson(Map<String, dynamic> json) {
    return AdminStructure(
        structureId: json['strucuture_id'],
        username: json['username'],
        nom: json['nom'],
        prenom: json['prenom'],
        password: json['password'],
        email: json['email'],
        genre: json['genre'],
        telephone: json['telephone'],
        photo: json['avatar_url'],
        idfaculte: json['faculter_id']
        //structure: Structure.fromJson(json['structure']),
        );
  }
}
