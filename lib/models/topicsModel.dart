import 'package:flutter/material.dart';
import 'package:gde_web/models/suggestionmodel.dart';

class Topics {
  String sujet;
  IconData icon;
  List<Suggestion> suggestions;
  Topics({required this.sujet, required this.suggestions, required this.icon});
}
