class FiliereStructure {
  int id_filiere;
  int id_structure;
  FiliereStructure({required this.id_filiere, required this.id_structure});
  factory FiliereStructure.fromJson(Map<String, dynamic> json) {
    return FiliereStructure(
        id_filiere: json['filiere_id'], id_structure: json['structure_id']);
  }
}
