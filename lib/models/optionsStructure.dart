class OptionsStructure {
  int id_structure;
  int id_options;
  OptionsStructure({required this.id_options, required this.id_structure});
  factory OptionsStructure.fromJson(Map<String, dynamic> json) {
    return OptionsStructure(
        id_options: json['id_option'], id_structure: json['id_structure']);
  }
}
