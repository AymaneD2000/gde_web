import 'package:flutter/material.dart';
import 'package:gde_web/Screens/HomeScreen.dart';
import 'package:gde_web/Screens/registrationPage.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final supabse_managemet c = Get.put(supabse_managemet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool isTrue = await c.login(
                    emailController.text, passwordController.text);
                print(isTrue);
                print(isTrue);
                if (isTrue) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Don\'t have an account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}
