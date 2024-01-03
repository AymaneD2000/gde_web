import 'package:flutter/material.dart';
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
          const Text(
            "Bienvenue",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          SizedBox(
              height:
                  16), // Ajout d'un espace vertical entre le texte "Bienvenue" et les informations de profil
          _buildProfileInfo(),
          // Ajout d'un espace vertical entre les informations de profil et le widget de publication
          // Si vous souhaitez réactiver le widget de publication, vous pouvez le faire avec la méthode ci-dessous :
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.3,
          //   height: MediaQuery.of(context).size.height * 0.8,
          //   child: _buildPublicationWidget(),
          // ),
        ],
      ),
    ));
  }

  Widget _buildProfileInfo() {
    final admin = supabaseManagement.admin.first;
    final structure = admin.structure;
    final faculter = admin.faculter;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Image.network(
              structure?.logo ?? faculter?.image ?? '',
            ),
          ),
          SizedBox(
              height:
                  8), // Ajout d'un espace vertical entre l'image et le texte
          Text(
            structure?.description ?? faculter?.description ?? '',
            textAlign: TextAlign.center, // Aligner le texte au centre
            style: TextStyle(
              fontSize: 16, // Ajuster la taille de la police selon vos besoins
              fontWeight:
                  FontWeight.bold, // Appliquer une police en gras si nécessaire
            ),
          ),
        ],
      ),
    );
  }
}
