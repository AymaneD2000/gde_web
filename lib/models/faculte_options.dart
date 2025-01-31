class FaculteOptions {
  int faculteId;
  int optionsId;
  FaculteOptions({required this.faculteId, required this.optionsId});
  factory FaculteOptions.fromJson(Map<String, dynamic> json) {
    return FaculteOptions(
        faculteId: json["faculte_id"], optionsId: json["option_id"]);
  }
}
