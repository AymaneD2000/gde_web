import 'package:flutter/material.dart';
import 'package:gde_web/models/options.dart';
import 'package:gde_web/models/filiere.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class OptionsFacultePage extends StatefulWidget {
  final Filiere filiere;
  final int idStructure;
  OptionsFacultePage(this.filiere, this.idStructure);

  @override
  _OptionsFacultePageState createState() => _OptionsFacultePageState();
}

class _OptionsFacultePageState extends State<OptionsFacultePage> {
  final supabse_managemet c = Get.put(supabse_managemet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Options de la filière ${widget.filiere.nom}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.filiere.list_option!.length,
                itemBuilder: (context, index) {
                  final option = widget.filiere.list_option![index];
                  final isAdded = c.faculteOptions.any(
                    (i) =>
                        i.options_id == option.id &&
                        i.faculte_id == widget.idStructure,
                  );

                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        option.denomination,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          isAdded ? Icons.check_circle : Icons.add_circle,
                          color: isAdded ? Colors.green : Colors.blue,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          if (isAdded) {
                            await c.deleteOptionsFaculte(
                              option.id,
                              widget.idStructure,
                            );
                          } else {
                            await c.addFaculteOptions(
                              option.id,
                              widget.idStructure,
                            );
                          }
                          // Mettez à jour la liste d'options après l'ajout/suppression
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
