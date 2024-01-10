// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gde_web/main.dart';
import 'package:gde_web/models/formation.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayUpdateModulePage extends StatefulWidget {
  Formation module;
  DisplayUpdateModulePage({Key? key, required this.module}) : super(key: key);

  @override
  _DisplayUpdateModulePageState createState() =>
      _DisplayUpdateModulePageState();
}

class _DisplayUpdateModulePageState extends State<DisplayUpdateModulePage> {
  Uint8List? _imageFile;
  String? _avatarUrl = '';
  TextEditingController nomController = TextEditingController(),
      descriptionController = TextEditingController(),
      dureeController = TextEditingController();
  final supabse_managemet c = Get.put(supabse_managemet());
  @override
  void initState() {
    super.initState();
    nomController.text = widget.module.nom;
    descriptionController.text = widget.module.description;
    dureeController.text = widget.module.duree;
  }

  Future<void> _chargerImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (imageFile == null) {
      return;
    }
    _imageFile = await imageFile.readAsBytes();
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
      _avatarUrl = await MyApp.supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
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
            content: const Text('Une erreur inattendue est survenue'),
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
        title: const Text('Module'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () async {
                await _chargerImage();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: _imageFile != null
                    ? Image.memory(
                        _imageFile!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Image.network(widget.module.image),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nomController,
              decoration: const InputDecoration(
                labelText: "Nom du Module",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: dureeController,
              decoration: const InputDecoration(
                labelText: "Durée de la formation",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: null,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: "Description du Module",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                try {
                  Formation formation = Formation(
                    idCtf: c.admin.first.structure_id!,
                    description: descriptionController.text,
                    nom: nomController.text,
                    image: _avatarUrl!,
                    duree: dureeController.text,
                  );
                  c.addStructureModule(formation);
                  setState(() {
                    c.getModules();
                  });
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Mettre à jour'),
            ),
          ],
        ),
      ),
    );
  }
}
