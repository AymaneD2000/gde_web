// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gde_web/Screens/HomeScreen.dart';
import 'package:gde_web/Screens/registrationPage.dart';
import 'package:gde_web/Widgets/customradioButton.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final supabse_managemet c = Get.put(supabse_managemet());

  String val = "Universiter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Connexion'),
      // ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Image.asset("assets/Ellipse 35.png"),
            width: MediaQuery.of(context).size.width * 0.45,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                      height: 90, child: Image.asset("assets/G.D.E image.jpg")),
                  Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Connectez-Vous",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00A8E7),
                            ),
                          ),
                          Text(
                            "Connectez-vous pour accéder à votre espace",
                            style: TextStyle(color: Color(0xFF474749)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: Icon(Icons.mail),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: Icon(Icons.remove_red_eye_sharp),
                              ),
                              obscureText: false,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomRadio(
                                label: "Universite",
                                value: "Universite",
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                              ),
                              CustomRadio(
                                label: "C.F",
                                value: "C.F",
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                              ),
                              CustomRadio(
                                label: "Ecole",
                                value: "Ecole",
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                              ),
                              CustomRadio(
                                label: "Faculte",
                                value: "Faculte",
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF00A8E7))),
                            onPressed: () async {
                              bool isTrue = false;
                              if (val == "Faculte") {
                                isTrue = await c.loginFaculty(
                                  emailController.text,
                                  passwordController.text,
                                );

                                if (isTrue) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                }
                              } else {
                                bool isTrue = await c.loginStructure(
                                  emailController.text,
                                  passwordController.text,
                                );
                                if (isTrue) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Connexion',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Vous n'avez pas de compte ?"),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationPage()));
                                  },
                                  child: const Text(
                                    " Inscrivez-vous ici.",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF00A8E7)),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
