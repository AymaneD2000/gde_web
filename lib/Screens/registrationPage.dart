import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gde_web/Widgets/genderSelectableform.dart';
import 'package:gde_web/Widgets/textformfield.dart';
import 'package:gde_web/main.dart';
import 'package:gde_web/models/AdminStructure.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v5.dart';

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
    //setState(() => _isLoading = true);

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

    //setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: _upload,
                ),
                SizedBox(height: 20),
                CustomTextField(
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
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
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
                    SizedBox(width: 20),
                    Expanded(
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
                SizedBox(height: 20),
                CustomTextField(
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
                SizedBox(height: 20),
                CustomTextField(
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
                SizedBox(height: 20),
                GenderFormField(
                  gender: genreController.text,
                  onChanged: (value) {
                    setState(() {
                      genreController.text = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Implement your registration logic here
                      // Access form values using controller.text
                      AdminStructure adminStructure = AdminStructure(
                        username: usernameController.text,
                        password: passwordController.text,
                        email: emailController.text,
                        nom: nomController.text,
                        prenom: prenomController.text,
                        genre: genreController.text,
                        telephone: telephoneController.text,
                        Photo: _avatarUrl ?? "",
                      );
                      //adminStructure.create();
                      // MyApp.supabase.storage.from("flutter_gde").uploadBinary(
                      //     "/image", await _selectedPhoto!.readAsBytesSync());
                      try {
                        print(adminStructure.toJson());
                        MyApp.supabase
                            .from('admin_struct')
                            .insert(adminStructure.toJson());
                        print(adminStructure.toJson());
                        print(adminStructure.toJson());
                      } catch (e) {
                        print("this is sppabase erro $e");
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
