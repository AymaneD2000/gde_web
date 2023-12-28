import 'package:flutter/material.dart';
import 'package:gde_web/Screens/addModuleStructurePage.dart';
import 'package:gde_web/Screens/moduleStructure.dart';
import 'package:gde_web/models/formation.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class ListeModulesPage extends StatefulWidget {
  const ListeModulesPage({Key? key}) : super(key: key);

  @override
  _ListeModulesPageState createState() => _ListeModulesPageState();
}

class _ListeModulesPageState extends State<ListeModulesPage> {
  final supabse_managemet c = Get.put(supabse_managemet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Modules'),
      ),
      body: FutureBuilder<List<Formation>>(
        future: c
            .getModules(), // Assurez-vous d'avoir une méthode getModules pour récupérer la liste des modules
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun module trouvé.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Formation module = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Naviguer vers la page de mise à jour avec le module sélectionné
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayUpdateModulePage(
                          module: module,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(module.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    module.nom,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    module.description,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    c.deleteStructureModule(module);
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Container(
          color: Colors.black,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AjouterModulePage()));
            },
          )),
    );
  }
}

// Utiliser la même classe DisplayUpdateModulePage de la réponse précédente pour la mise à jour des modules
