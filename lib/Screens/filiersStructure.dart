import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:gde_web/Screens/optionsStructure.dart';
import 'package:gde_web/models/filiere.dart';
import 'package:gde_web/models/filiere_structure.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class FiliereStructurePage extends StatefulWidget {
  const FiliereStructurePage({super.key});

  @override
  State<FiliereStructurePage> createState() => _FiliereStructurePageState();
}

class _FiliereStructurePageState extends State<FiliereStructurePage> {
  final supabse_managemet c = Get.put(supabse_managemet());
  List<Filiere> filieres = [];
  List<FiliereStructure> filieres_structure = [];
  Future<void> _loadData() async {
    setState(() {
      // Mettez à jour les filières après le chargement des données
      filieres = c.filiers;
      filieres_structure = c.filierestructure;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filières et Options'),
        ),
        body: DynamicHeightGridView(
            itemCount: filieres.length,
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            builder: (ctx, index) {
              return _buildFiliereCard(filieres[index]);
            })

        // GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 4,
        //       crossAxisSpacing: 16.0,
        //       mainAxisSpacing: 16.0,
        //       childAspectRatio: 0.7),
        //   itemCount: filieres.length,
        //   itemBuilder: (context, index) {
        //     return _buildFiliereCard(filieres[index]);
        //   },
        // ),
        );
  }

  Widget _buildFiliereCard(Filiere filiere) {
    bool isAdded = false;
    for (var element in filieres_structure) {
      if (element.id_filiere == filiere.id &&
          element.id_structure == c.admin.first.structure_id) {
        isAdded = true;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          filiere.image ?? 'lien_par_defaut',
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filiere.nom,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  _truncateDescription(filiere.description),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                const Text('Options:'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListView.builder(
                      itemCount: filiere.list_option!.length,
                      itemBuilder: (context, index) {
                        final option = filiere.list_option!;
                        //bool optAded = false;
                        final optAded = c.optionsStructure.any(
                          (i) =>
                              i.id_options == option[index].id &&
                              i.id_structure == c.admin.first.structure_id,
                        );
                        return Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: optAded ? Colors.green : Colors.grey,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              _truncateDenomination(option[index].denomination),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isAdded ? 'Ajouté' : 'Non ajouté',
                        style: TextStyle(
                          color: isAdded ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (isAdded == true) {
                            await c.deleteFiliereStructure(
                                filiere.id,
                                c.admin.first.structure_id,
                                filiere.list_option);
                          } else {
                            await c.addFiliereStructure(
                                filiere.id, c.admin.first.structure_id);
                          }
                          // Mettez à jour la liste de filières après l'ajout/suppression
                          await _loadData();
                          setState(() {});
                        },
                        child: Text(isAdded ? 'Retirer' : 'Ajouter'),
                      ),
                    ],
                  ),
                ),
                isAdded == true
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return OptionsPage(
                                    filiere, c.admin.first.structure_id!);
                              });
                          setState(() {});
                        },
                        child: const Text('Gérer Options',
                            style: TextStyle(color: Colors.green)),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Gérer Options',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _truncateDenomination(String denomination) {
    // Tronquer la dénomination à une seule ligne
    if (denomination.length > 20) {
      return '${denomination.substring(0, 17)}...';
    }
    return denomination;
  }

  String _truncateDescription(String description) {
    // Tronquer la description à 4 lignes
    final List<String> lines = description.split('\n');
    if (lines.length > 4) {
      return lines.sublist(0, 4).join('\n');
    }
    return description;
  }

  // void _toggleFiliereState(filiere_id, structure_id) {
  //   setState(() {
  //     if (isAdded == true) {
  //       c.deleteFiliereStructure(filiere_id, structure_id);
  //     } else {
  //       c.addFiliereStructure(filiere_id, structure_id);
  //     }
  //     isAdded = !isAdded;
  //   });
  // }
}
