class FiliereStructure {
  int idFiliere;
  int idStructure;
  FiliereStructure({required this.idFiliere, required this.idStructure});
  factory FiliereStructure.fromJson(Map<String, dynamic> json) {
    return FiliereStructure(
        idFiliere: json['filiere_id'], idStructure: json['structure_id']);
  }
}
