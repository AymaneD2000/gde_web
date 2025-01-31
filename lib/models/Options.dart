class Option {
  int id;
  String denomination;
  String description;
  int filiereId;
  String? image;

  Option({
    this.image,
    required this.id,
    required this.filiereId,
    required this.denomination,
    required this.description,
  });

  // toJson method to convert Option object to a Map
  Map<String, dynamic> toJson() {
    return {
      'denomination': denomination,
      'description': description,
      'filiere_id': filiereId,
      'image': image,
    };
  }

  // fromJson method to create an Option object from a Map
  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id_option'],
      denomination: json['denomination'],
      description: json['description'],
      filiereId: json['filiere_id'],
      image: json['image'],
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Option(id: $id, denomination: $denomination, description: $description, filiere_id: $filiereId, image: $image)';
  }
}
