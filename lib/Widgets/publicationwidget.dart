import 'package:flutter/material.dart';
import 'package:gde_web/Widgets/MyText.dart';
import 'dart:math';

import 'package:gde_web/models/Poste.dart';

class PublicationWidget extends StatelessWidget {
  PublicationWidget(
      {Key? key,
      required this.username,
      required this.structureLogo,
      required this.structureNom,
      required this.publication})
      : super(key: key);

  final String username;
  String structureLogo;
  String structureNom;
  final Publication publication;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.blue),
                ),
                child: ClipOval(
                  child: Image.network(
                    structureLogo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      structureNom,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      publication.date.toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    CText(
                      username,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            publication.information,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          publication.photo != null ? _buildImageGrid(context) : Container(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _buildButton("Like", Icons.thumb_up),
              _buildButton("Comment", Icons.comment),
              const SizedBox(
                width: 15,
              ),
              _buildButton("Share", Icons.share),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    if (publication.photo != null && publication.photo!.isNotEmpty) {
      return Wrap(
        spacing: 6.0,
        runSpacing: 8.0,
        children: publication.photo!.map((imageUrl) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl.photo,
              fit: BoxFit.cover,
              width: (MediaQuery.of(context).size.width - 45) /
                  min(publication.photo!.length, 3),
              height: (MediaQuery.of(context).size.width - 45) /
                  min(publication.photo!.length, 3),
            ),
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}
