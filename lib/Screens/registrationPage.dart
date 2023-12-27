import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gde_web/Widgets/genderSelectableform.dart';
import 'package:gde_web/Widgets/textformfield.dart';
import 'package:gde_web/main.dart';
import 'package:gde_web/models/AdminStructure.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  String? _avatarUrl;
  File? _imageFile;

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
        body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              children: [
                SizedBox(
                    height: 90, child: Image.asset("assets/G.D.E image.jpg")),
                const Text(
                  "Page d'Inscription",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: _upload,
                                  child: _imageFile == null
                                      ? const Text("Sélectionner une photo")
                                      : const Text("Photo sélectionner"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: CustomTextField(
                                controller: usernameController,
                                labelText: 'Username',
                                prefixIcon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: CustomTextField(
                                    controller: nomController,
                                    labelText: 'Nom',
                                    prefixIcon: Icons.person,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: CustomTextField(
                                    controller: prenomController,
                                    labelText: 'Prenom',
                                    prefixIcon: Icons.person,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: CustomTextField(
                                    controller: passwordController,
                                    labelText: 'Password',
                                    prefixIcon: Icons.lock,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: GenderFormField(
                                    gender: genreController.text,
                                    onChanged: (value) {
                                      setState(() {
                                        genreController.text = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
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
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  AdminStructure adminStructure =
                                      AdminStructure(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    email: emailController.text,
                                    nom: nomController.text,
                                    prenom: prenomController.text,
                                    genre: genreController.text,
                                    telephone: telephoneController.text,
                                    Photo: _avatarUrl ?? "",
                                  );
                                  try {
                                    MyApp.supabase
                                        .from('admin')
                                        .insert(adminStructure.toJson());
                                  } catch (e) {
                                    print("this is sppabase erro $e");
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          child: Image.asset("assets/Rectangle 11.png"),
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    ));
  }
}
