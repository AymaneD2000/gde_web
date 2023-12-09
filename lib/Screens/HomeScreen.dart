import 'package:flutter/material.dart';
import 'package:gde_web/supabase/supabase_managements.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabse_managemet c = Get.put(supabse_managemet());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.chat,
              size: 20,
              color: Colors.blue,
            ),
            Text(
              "F.S.T",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: ListTile(
                title: Text(c.admin.first.username),
                subtitle: Text("Doyen"),
                trailing: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: 50,
                    height: 50,
                    child: Image.network(c.admin.first.Photo!)),
              ),
            )
          ],
        ),
      ),
      body: Container(),
    );
  }
}
