import 'package:gde_web/models/photos.dart';

class Publication {
  String idPublication;
  String information;
  List<Photo>? photo;

  Publication({
    required this.information,
    required this.idPublication,
    this.photo,
  });

  // toJson method to convert Publication object to a Map
  Map<String, dynamic> toJson() {
    return {
      'idPublication': idPublication,
      'information': information,
      'photo': photo?.map((photo) => photo.toJson()).toList(),
    };
  }

  // fromJson method to create a Publication object from a Map
  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      idPublication: json['idPublication'],
      information: json['information'],
      photo: (json['photo'] as List<dynamic>?)
          ?.map((photoJson) => Photo.fromJson(photoJson))
          .toList(),
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Publication(idPublication: $idPublication, information: $information, photo: $photo)';
  }
}
