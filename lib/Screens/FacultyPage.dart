import 'package:flutter/material.dart';
import 'package:gde_web/Screens/filiereFaculte.dart';
import 'package:gde_web/models/faculter_model.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class FacultyPage extends StatefulWidget {
  const FacultyPage({Key? key});

  @override
  State<FacultyPage> createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  // Exemple de liste de facultés, vous devez remplacer cela par votre propre liste de facultés.
  List<Faculter> facultes = [];
  final supabse_managemet c = Get.put(supabse_managemet());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    facultes = c.faculter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Facultés")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: facultes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FiliereFacultePage()));
              },
              child: FaculterCard(faculte: facultes[index]));
        },
      ),
    );
  }
}

class FaculterCard extends StatelessWidget {
  final Faculter faculte;

  const FaculterCard({Key? key, required this.faculte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            faculte.image,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  faculte.nom,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(faculte.sigle),
                Text(faculte.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
