import 'package:gde_web/models/Structure.dart';
import 'package:gde_web/models/Videos.dart';
import 'package:gde_web/models/photos.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Publication {
  String idPublication;
  String information;
  Structure? structure;
  DateTime date;
  List<dynamic>? photo;
  List<dynamic>? video;

  Publication(
      {this.video,
      required this.date,
      required this.information,
      required this.idPublication,
      this.photo,
      this.structure});

  // toJson method to convert Publication object to a Map
  Map<String, dynamic> toJson() {
    return {
      'idPublication': idPublication,
      'information': information,
      'photo': photo?.map((photo) => photo.toJson()).toList(),
    };
  }

  // fromJson method to create a Publication object from a Map
  factory Publication.fromJson(Map<String, dynamic> json) {
    DateTime temps = DateTime.parse(json["date"]);
    String dat = DateFormat('dd/MM/yyyy à HH:mm:ss').format(temps);
    return Publication(
      structure: null,
      date: DateTime.tryParse(json['date'])!,
      video: [],
      idPublication: json['id'],
      information: json['description'],
      photo: [],
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Publication(idPublication: $idPublication, information: $information, photo: $photo)';
  }
}
