import 'dart:math';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
//import 'package:gde_web/Widgets/publicationwidget.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final supabaseManagement = Get.put(supabse_managemet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Divider(
              //   height: 20,
              //   color: Colors.black,
              // ),
              Column(
                children: [
                  const Text("Les dernières publications",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.045,
                              child: Image.network(
                                  supabaseManagement.admin.first.structure !=
                                          null
                                      ? supabaseManagement
                                          .admin.first.structure!.logo
                                      : supabaseManagement
                                          .admin.first.faculter!.image),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    supabaseManagement.admin.first.structure !=
                                            null
                                        ? supabaseManagement
                                            .admin.first.structure!.sigle
                                        : supabaseManagement
                                            .admin.first.faculter!.sigle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                // ...
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.2),
                                  child: EasyRichText(
                                    supabaseManagement
                                                .admin.first.structure !=
                                            null
                                        ? supabaseManagement
                                            .admin.first.structure!.nom
                                        : supabaseManagement
                                            .admin.first.faculter!.nom,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    defaultStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: SingleChildScrollView(
                                child: _buildImageGrid(context))),
                        Text(
                            supabaseManagement.publiciter.isNotEmpty
                                ? supabaseManagement
                                    .publiciter.first.information
                                : "",
                            style: const TextStyle(fontSize: 18)),
                        Text(supabaseManagement.publiciter.isNotEmpty
                            ? supabaseManagement.publiciter.first.date
                                .toString()
                            : "")
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Informations sur les structures ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  _buildProfileInfo(),
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildProfileInfo() {
    final admin = supabaseManagement.admin.first;
    final structure = admin.structure;
    final faculter = admin.faculter;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Image.network(
              structure?.logo ?? faculter?.image ?? '',
            ),
          ),
          const SizedBox(
              height:
                  8), // Ajout d'un espace vertical entre l'image et le texte
          Text(
            structure?.description ?? faculter?.description ?? '',
            textAlign: TextAlign.center, // Aligner le texte au centre
            style: const TextStyle(
              fontSize: 16, // Ajuster la taille de la police selon vos besoins
              fontWeight:
                  FontWeight.bold, // Appliquer une police en gras si nécessaire
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    if (supabaseManagement.publiciter.first.photo != null &&
        supabaseManagement.publiciter.first.photo!.isNotEmpty) {
      return Wrap(
        spacing: 6.0,
        runSpacing: 8.0,
        children: supabaseManagement.publiciter.first.photo!.map((imageUrl) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl.photo,
              fit: BoxFit.cover,
              width: (MediaQuery.of(context).size.width - 45) /
                  min(supabaseManagement.publiciter.first.photo!.length, 3),
              height: (MediaQuery.of(context).size.width - 45) /
                  min(supabaseManagement.publiciter.first.photo!.length, 3),
            ),
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}
