import 'package:gde_web/models/Options.dart';
import 'package:gde_web/models/Poste.dart';
import 'package:gde_web/models/faculter_model.dart';
import 'package:gde_web/models/formation.dart';

class Structure {
  int id;
  String nom;
  String sigle;
  String email;
  String description;
  String typeStructure;
  String logo;
  String localisation;
  String accessCondition;
  List<Publication>? publications;
  List<Faculter>? faculter;
  List<Formation>? formations;
  List<Option>? options;

  Structure({
    required this.accessCondition,
    this.faculter,
    required this.email,
    required this.sigle,
    required this.id,
    this.publications,
    this.formations,
    this.options,
    required this.nom,
    required this.description,
    required this.logo,
    required this.localisation,
    required this.typeStructure,
  });

  // fromJson method to create a Structure object from a Map
  factory Structure.fromJson(Map<String, dynamic> json) {
    return Structure(
      accessCondition: json['critere_acces'],
      faculter: [],
      email: json['email'],
      sigle: json['sigle'],
      id: json['structure_id'],
      nom: json['nom'],
      description: json['description'],
      typeStructure: json['type'],
      logo: json['image'],
      localisation: json['localisation'],
      publications: (json['publications'] as List<dynamic>?)
          ?.map((publicationJson) => Publication.fromJson(publicationJson))
          .toList(),
      formations: (json['formations'] as List<dynamic>?)
          ?.map((formationJson) => Formation.fromJson(formationJson))
          .toList(),
      options: (json['options'] as List<dynamic>?)
          ?.map((optionJson) => Option.fromJson(optionJson))
          .toList(),
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Structure(nom: $nom, description: $description, typeStructure: $typeStructure, logo: $logo, localisation: $localisation, publications: $publications, formations: $formations, options: $options)';
  }
}
