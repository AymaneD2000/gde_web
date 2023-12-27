class FaculteOptions {
  int faculte_id;
  int options_id;
  FaculteOptions({required this.faculte_id, required this.options_id});
  factory FaculteOptions.fromJson(Map<String, dynamic> json) {
    return FaculteOptions(
        faculte_id: json["faculte_id"], options_id: json["option_id"]);
  }
}
