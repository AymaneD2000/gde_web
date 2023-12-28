import 'package:flutter/material.dart';
import 'package:gde_web/Screens/StructureManagement.dart';
import 'package:gde_web/Screens/filiereFaculte.dart';
import 'package:gde_web/Screens/filiersStructure.dart';
import 'package:gde_web/Screens/listmodulePage.dart';
import 'package:gde_web/Screens/moduleStructure.dart';
import 'package:gde_web/Screens/pubpage.dart';
import 'package:gde_web/models/faculter_model.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';
//import 'package:image_network/image_network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  final listPage = [
    Container(
      color: Colors.red,
    ),
    PublicationPage(),
    UpdateFaculterPage(),
    FiliereStructurePage(),
    FiliereFacultePage(),
    ListeModulesPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final supabse_managemet c = Get.put(supabse_managemet());
  Widget buildDrawerItem(IconData icon, String title, pages) {
    return ListTile(
      selectedColor: const Color(0xFFD9D9D9),
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blueGrey,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        setState(() {
          page = pages;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 50,
                        child: Image.network(c.admin.first.structure == null
                            ? c.admin.first.faculter!.image
                            : c.admin.first.structure!.logo),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        c.admin.first.structure == null
                            ? c.admin.first.faculter!.sigle
                            : c.admin.first.structure!.sigle,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        c.admin.first.nom,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: buildDrawerItem(Icons.home, "Accueil", 0),
                ),
                Expanded(
                  child: buildDrawerItem(Icons.mail, "Publications", 1),
                ),
                Expanded(
                  child: buildDrawerItem(Icons.mail, "Manage Structure", 2),
                ),
                Expanded(
                  child: buildDrawerItem(
                      Icons.settings,
                      "Formations",
                      c.admin.first.structure!.typeStructure ==
                              "Centre de formation"
                          ? 5
                          : (c.admin.first.faculter == null ? 3 : 4)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.chat,
                        size: 20,
                        color: Colors.blue,
                      ),
                      Text(
                        c.admin.first.structure == null
                            ? c.admin.first.faculter!.sigle
                            : c.admin.first.structure!.sigle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ListTile(
                          title: Text(c.admin.first.username),
                          subtitle: Text(c.admin.first.structure == null
                              ? c.admin.first.faculter!.sigle
                              : c.admin.first.structure!.sigle),
                          trailing: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              width: 50,
                              height: 50,
                              child: Image.network(c.admin.first.Photo!)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: listPage[page])
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
