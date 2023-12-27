import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gde_web/models/Structure.dart';

class StructureForm extends StatefulWidget {
  @override
  _StructureFormState createState() => _StructureFormState();
}

class _StructureFormState extends State<StructureForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire de Structure'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nom',
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              FormBuilderTextField(
                name: 'description',
                decoration: InputDecoration(labelText: 'Description'),
              ),
              FormBuilderDropdown(
                name: 'typeStructure',
                decoration: InputDecoration(labelText: 'Type de Structure'),
                items: ['Institut', 'Université', 'Centre de Formation']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
              ),

              FormBuilderTextField(
                name: 'logo',
                decoration: InputDecoration(labelText: 'Logo'),
              ),
              FormBuilderTextField(
                name: 'localisation',
                decoration: InputDecoration(labelText: 'Localisation'),
              ),
              // Ajoutez ici d'autres champs selon vos besoins

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Récupérer les valeurs du formulaire
                    Map<String, dynamic> formData =
                        _formKey.currentState!.value;

                    // Utiliser ces valeurs pour créer un objet Structure
                    // Structure newStructure = Structure(
                    //   id: 'nouvel_id', // Vous pouvez générer un nouvel ID ici
                    //   nom: formData['nom'],
                    //   description: formData['description'],
                    //   typeStructure: formData['typeStructure'],
                    //   logo: formData['logo'],
                    //   localisation: formData['localisation'],
                    //   // Ajoutez ici d'autres champs selon vos besoins
                    // );

                    // // Vous pouvez maintenant utiliser l'objet newStructure comme nécessaire
                    // print(newStructure);
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
