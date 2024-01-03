import 'package:flutter/material.dart';
import 'package:gde_web/Widgets/publicationwidget.dart';
import 'package:gde_web/main.dart';
import 'package:gde_web/models/Poste.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PublicationPage extends StatefulWidget {
  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
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
        print(photos.length);
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

    //setState(() => _isLoading = false);
  }

  Future<void> _uploadVideo() async {
    final picker = ImagePicker();

    final lifFile =
        await picker.pickMultipleMedia(maxWidth: 300, maxHeight: 300);
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
        videos.add(await MyApp.supabase.storage
            .from('photo_video_pub')
            .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10));
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
    }

    //setState(() => _isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadPubliciter();
  }

  @override
  Widget build(BuildContext context) {
    uploadPubliciter();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Nouvelle publication'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pubs.length,
              itemBuilder: (context, index) {
                return PublicationWidget(
                  structureNom: c.admin.first.structure == null
                      ? c.admin.first.faculter!.nom
                      : c.admin.first.structure!.nom,
                  structureLogo: c.admin.first.structure == null
                      ? c.admin.first.faculter!.image
                      : c.admin.first.structure!.logo,
                  publication: c.publiciter[pubs.length - index - 1],
                  username: c.admin.first.username,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showAboutDialog(context: context, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _uploadImage,
                        icon: Icon(Icons.photo),
                        label: Text('Ajouter une photo'),
                      ),
                      // SizedBox(height: 8),
                      // ElevatedButton.icon(
                      //   onPressed: _uploadVideo,
                      //   icon: Icon(Icons.videocam),
                      //   label: Text('Ajouter une vidéo'),
                      // ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: informationController,
                        decoration: InputDecoration(
                          labelText: 'Exprimez-vous...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        maxLines: 4,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final id = Uuid().v4();
                          Publication newPublication = Publication(
                            date: DateTime.now(),
                            idPublication: id,
                            information: informationController.text,
                          );
                          try {
                            c.admin.first.structure == null
                                ? c.addFacultePublication(newPublication,
                                    c.admin.first.idfaculte!, photos, videos)
                                : c.addPublication(
                                    newPublication,
                                    c.admin.first.structure_id!,
                                    photos,
                                    videos);
                            pubs.add(newPublication);
                            setState(() {});
                          } catch (e) {
                            print(e);
                          }
                          //Navigator.pop(context);
                        },
                        child: Text('Publier'),
                      ),
                    ],
                  ),
                ),
              )
            ]);
          }),
    );
  }
}
