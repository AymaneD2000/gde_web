class FaculteFiliere {
  int faculteId;
  int filiereId;
  FaculteFiliere({required this.faculteId, required this.filiereId});
  factory FaculteFiliere.fromJson(Map<String, dynamic> json) {
    return FaculteFiliere(
        faculteId: json["faculte_id"], filiereId: json["filiere_id"]);
  }
}
