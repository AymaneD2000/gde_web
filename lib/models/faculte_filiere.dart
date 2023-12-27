class FaculteFiliere {
  int faculte_id;
  int filiere_id;
  FaculteFiliere({required this.faculte_id, required this.filiere_id});
  factory FaculteFiliere.fromJson(Map<String, dynamic> json) {
    return FaculteFiliere(
        faculte_id: json["faculte_id"], filiere_id: json["filiere_id"]);
  }
}
