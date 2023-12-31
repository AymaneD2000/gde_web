import 'package:flutter/material.dart';
import 'package:gde_web/Screens/HomeScreen.dart';
import 'package:gde_web/Screens/loginPage.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ihrtyyxbykdgxmiahzws.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlocnR5eXhieWtkZ3htaWFoendzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk5MDY1MTcsImV4cCI6MjAxNTQ4MjUxN30.SnLCAAJwMK2gELbjE_g2WW92q7RXrO7kkn3n3PSZLCk',
  );

  runApp(GetMaterialApp(home: MyApp()));
}

// Get a reference your Supabase client

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static final supabase = Supabase.instance.client;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
