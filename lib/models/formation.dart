import 'package:gde_web/models/photos.dart';

class Formation {
  String id;
  String nom;
  String description;
  List<Photo>? photo;

  Formation({
    required this.id,
    required this.description,
    required this.nom,
    this.photo,
  });

  // toJson method to convert Formation object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'photo': photo?.map((photo) => photo.toJson()).toList(),
    };
  }

  // fromJson method to create a Formation object from a Map
  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      photo: (json['photo'] as List<dynamic>?)
          ?.map((photoJson) => Photo.fromJson(photoJson))
          .toList(),
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Formation(nom: $nom, description: $description, photo: $photo)';
  }
}
