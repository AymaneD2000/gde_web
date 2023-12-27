import 'package:uuid/uuid.dart';

class Photo {
  String idPhoto;
  String photo;
  String id_pub;

  Photo({
    required this.idPhoto,
    required this.id_pub,
    required this.photo,
  });

  // toJson method to convert Photo object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id_pub': id_pub,
      'id': idPhoto,
      'image': photo,
    };
  }

  // fromJson method to create a Photo object from a Map
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id_pub: json['id_pub'],
      idPhoto: json['id'],
      photo: json['image'],
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Photo(idPhoto: $idPhoto, photo: $photo)';
  }
}
