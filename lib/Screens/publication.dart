import 'package:flutter/material.dart';
import 'package:gde_web/Screens/home_screen.dart';
import 'package:gde_web/main.dart';
import 'package:gde_web/models/poste.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class Pub extends StatefulWidget {
  const Pub({super.key});

  @override
  State<Pub> createState() => _PubState();
}

class _PubState extends State<Pub> {
  TextEditingController informationController = TextEditingController();
  List<String> photos = [];
  List<String> videos = [];
  List<Publication> pubs = [];
  final supabse_managemet c = Get.put(supabse_managemet());
  uploadPubliciter() async {
    pubs = c.publiciter;
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();

    final lifFile = await picker.pickMultiImage(maxWidth: 300, maxHeight: 300);
    if (lifFile == []) {
      return;
    }
    //setState(() => _isLoading = true);
    for (final imageFile in lifFile) {
      try {
        final bytes = await imageFile.readAsBytes();
        final fileExt = imageFile.path.split('.').last;
        final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
        final filePath = fileName;
        await MyApp.supabase.storage.from('photo_video_pub').uploadBinary(
              filePath,
              bytes,
              fileOptions: FileOptions(contentType: imageFile.mimeType),
            );
        photos.add(await MyApp.supabase.storage
            .from('photo_video_pub')
            .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10));
        //widget.onUpload(imageUrlResponse);
        //print(photos.length);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle publication"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: _uploadImage,
                  icon: const Icon(Icons.photo),
                  label: const Text('Ajouter une photo'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: informationController,
                  decoration: const InputDecoration(
                    labelText: 'Exprimez-vous...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final id = const Uuid().v4();
                    Publication newPublication = Publication(
                      date: DateTime.now(),
                      idPublication: id,
                      information: informationController.text,
                    );
                    try {
                      c.admin.first.structure == null
                          ? c.addFacultePublication(newPublication,
                              c.admin.first.idfaculte!, photos, videos)
                          : c.addPublication(newPublication,
                              c.admin.first.structureId!, photos, videos);
                      pubs.add(newPublication);
                      setState(() {});
                    } catch (e) {
                      SnackBar(
                        content: const Text('Une erreur inattendue est survenue'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      );
                    }
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                  child: const Text('Publier'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
