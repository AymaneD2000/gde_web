import 'package:flutter/material.dart';
import 'package:gde_web/Screens/StructureManagement.dart';
import 'package:gde_web/Screens/WelcomePage.dart';
import 'package:gde_web/Screens/filiereFaculte.dart';
import 'package:gde_web/Screens/filiersStructure.dart';
import 'package:gde_web/Screens/listmodulePage.dart';
import 'package:gde_web/Screens/pubpage.dart';
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
    WelcomePage(),
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
    print("in");
  }

  final supabse_managemet c = Get.put(supabse_managemet());
  Widget buildDrawerItem(String icon, String title, int pages) {
    return ListTile(
      leading: SizedBox(
        child: Image.asset(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Icon(
        Icons.circle,
        color: page == pages ? Colors.green : Colors.red,
      ),
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
      body: Card(
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
                  child: buildDrawerItem(
                      "assets/fluent_home-20-regular.png", "Accueil", 0),
                ),
                Expanded(
                  child:
                      buildDrawerItem("assets/bx_box.png", "Publications", 1),
                ),
                Expanded(
                  child: buildDrawerItem(
                      "assets/Mortarboard.png", "Manage Structure", 2),
                ),
                Expanded(
                  child: buildDrawerItem(
                      "assets/Diploma.png",
                      "Formations",
                      c.admin.first.faculter == null
                          ? (c.admin.first.structure!.typeStructure ==
                                  "Centre de formation"
                              ? 5
                              : 3)
                          : 4),
                ),
                TextButton.icon(
                    label: const Text(
                      "Deconnexion",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      c.deconnexion();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.logout_outlined))
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
                      Text(
                        c.admin.first.structure == null
                            ? c.admin.first.faculter!.sigle
                            : c.admin.first.structure!.sigle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/gdeLasticon.jpg")),
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
