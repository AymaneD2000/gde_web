class Photo {
  int idPhoto;
  String photo;

  Photo({
    required this.idPhoto,
    required this.photo,
  });

  // toJson method to convert Photo object to a Map
  Map<String, dynamic> toJson() {
    return {
      'idPhoto': idPhoto,
      'photo': photo,
    };
  }

  // fromJson method to create a Photo object from a Map
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      idPhoto: json['idPhoto'],
      photo: json['photo'],
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Photo(idPhoto: $idPhoto, photo: $photo)';
  }
}
