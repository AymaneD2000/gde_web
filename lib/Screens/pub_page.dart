// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gde_web/Screens/publication.dart';
import 'package:gde_web/Widgets/publicationwidget.dart';
import 'package:gde_web/models/poste.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class PublicationPage extends StatefulWidget {
  const PublicationPage({super.key});

  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  TextEditingController informationController = TextEditingController();
  List<String> photos = [];
  List<String> videos = [];
  List<Publication> pubs = [];
  final supabse_managemet c = Get.put(supabse_managemet());
  uploadPubliciter() async {
    pubs = c.publiciter;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadPubliciter();
  }

  @override
  Widget build(BuildContext context) {
    uploadPubliciter();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Nouvelle publication'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: c.admin.first.structure == null
                    ? c.getFacultePublication(c.admin.first.idfaculte!)
                    : c.getPublication(c.admin.first.structureId!),
                builder: (context, snapshot) {
                  final pub = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: pub == null ? 0 : pub.length,
                      itemBuilder: (context, index) {
                        return PublicationWidget(
                          structureNom: c.admin.first.structure == null
                              ? c.admin.first.faculter!.nom
                              : c.admin.first.structure!.nom,
                          structureLogo: c.admin.first.structure == null
                              ? c.admin.first.faculter!.image
                              : c.admin.first.structure!.logo,
                          publication: pub![pub.length - index - 1],
                          username: c.admin.first.username,
                        );
                      },
                    );
                  } else {
                    return const SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Pub()));
          }),
    );
  }
}
