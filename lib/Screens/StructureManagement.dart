import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gde_web/Widgets/customTextForm.dart';
import 'package:gde_web/main.dart';
import 'package:gde_web/models/Structure.dart';
import 'package:gde_web/models/faculter_model.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateFaculterPage extends StatefulWidget {
  const UpdateFaculterPage();

  @override
  _UpdateFaculterPageState createState() => _UpdateFaculterPageState();
}

class _UpdateFaculterPageState extends State<UpdateFaculterPage> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController sigleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController localisationController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final supabse_managemet c = Get.put(supabse_managemet());
  String? _avatarUrl;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    // Remplir les contrôleurs avec les valeurs existantes
    if (c.admin.first.structure == null) {
      _avatarUrl = c.admin.first.faculter!.image;
      nomController.text = c.admin.first.faculter!.nom;
      conditionController.text = c.admin.first.faculter!.accessConditon;
      sigleController.text = c.admin.first.faculter!.sigle;
      emailController.text = c.admin.first.faculter!.email;
      descriptionController.text = c.admin.first.faculter!.description;
      imageController.text = c.admin.first.faculter!.image;
      localisationController.text = c.admin.first.faculter!.localisation;
    } else {
      _avatarUrl = c.admin.first.structure!.logo;
      nomController.text = c.admin.first.structure!.nom;
      conditionController.text = c.admin.first.structure!.accessCondition;
      sigleController.text = c.admin.first.structure!.sigle;
      emailController.text = c.admin.first.structure!.email;
      descriptionController.text = c.admin.first.structure!.description;
      imageController.text = c.admin.first.structure!.logo;
      localisationController.text = c.admin.first.structure!.localisation;
    }
  }

  void updateFaculter() {
    // Récupérer les nouvelles valeurs depuis les contrôleurs
    String newNom = nomController.text;
    String newSigle = sigleController.text;
    String newEmail = emailController.text;
    String newDescription = descriptionController.text;
    String newImage = imageController.text;
    String newLocalisation = localisationController.text;
    String access = conditionController.text;

    // Mettre à jour l'objet Faculter
    c.admin.first.faculter!.accessConditon = access;
    c.admin.first.faculter!.nom = newNom;
    c.admin.first.faculter!.sigle = newSigle;
    c.admin.first.faculter!.email = newEmail;
    c.admin.first.faculter!.description = newDescription;
    c.admin.first.faculter!.image = newImage;
    c.admin.first.faculter!.localisation = newLocalisation;

    // Effectuer la logique de mise à jour ici, par exemple, en appelant une fonction de mise à jour dans votre modèle ou service
    // updateFaculterInDatabase(widget.faculter);

    // Vous pouvez également naviguer vers une autre page après la mise à jour, par exemple, la page de détails de la faculté
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => FaculterDetailsPage(faculter: widget.faculter),
    // ));
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (imageFile == null) {
      return;
    }
    _imageFile = File(imageFile.path);
    setState(() {});

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await MyApp.supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );
      print(bytes);
      _avatarUrl = await MyApp.supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      //widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier Faculté'),
        backgroundColor: Colors.blue, // Changer la couleur de l'app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _upload,
                        child: _imageFile == null
                            ? const Text("Sélectionner un logo")
                            : const Text("Logo sélectionner"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: CustomTextField(
                          controller: nomController,
                          labelText: 'Nom',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last nom';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: CustomTextField(
                          controller: sigleController,
                          labelText: 'Sigle',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a sigle';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: CustomTextField(
                          controller: localisationController,
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a localisation';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: CustomTextField(
                          controller: localisationController,
                          labelText: 'Localisation',
                          prefixIcon: Icons.location_city,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: CustomTextField(
                          controller: telephoneController,
                          labelText: 'Telephone',
                          prefixIcon: Icons.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your telephone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CustomTextField(
                          expand: true,
                          controller: descriptionController,
                          labelText: 'Description',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Description';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CustomTextField(
                          expand: true,
                          controller: conditionController,
                          labelText: "Condition d'access",
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter words';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (c.admin.first.structure == null) {
                        Faculter adminStructure = Faculter(
                          accessConditon: conditionController.text,
                          idfaculter: c.admin.first.faculter!.idfaculter,
                          idUniv: c.admin.first.faculter!.idUniv,
                          image: _avatarUrl!,
                          localisation: localisationController.text,
                          sigle: sigleController.text,
                          description: descriptionController.text,
                          email: emailController.text,
                          nom: nomController.text,
                        );
                        try {
                          c.updateFaculter(adminStructure);
                        } catch (e) {
                          print("this is sppabase erro $e");
                        }
                      } else {
                        Structure adminStructure = Structure(
                          typeStructure: c.admin.first.structure!.typeStructure,
                          accessCondition: conditionController.text,
                          id: c.admin.first.structure!.id,
                          logo: _avatarUrl!,
                          localisation: localisationController.text,
                          sigle: sigleController.text,
                          description: descriptionController.text,
                          email: emailController.text,
                          nom: nomController.text,
                        );
                        try {
                          c.updateStructure(adminStructure);
                        } catch (e) {
                          print("this is sppabase erro $e");
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget pour un champ de texte stylisé
class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const StyledTextField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border:
            const OutlineInputBorder(), // Ajouter une bordure autour du champ de texte
      ),
      style: const TextStyle(fontSize: 16.0),
    );
  }
}

// Widget pour un bouton stylisé
class StyledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const StyledButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 18.0),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0), // Ajuster l'espacement interne du bouton
      ),
    );
  }
}
