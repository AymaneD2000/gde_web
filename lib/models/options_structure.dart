class OptionsStructure {
  int idStructure;
  int idOptions;
  OptionsStructure({required this.idOptions, required this.idStructure});
  factory OptionsStructure.fromJson(Map<String, dynamic> json) {
    return OptionsStructure(
        idOptions: json['id_option'], idStructure: json['id_structure']);
  }
}
