import 'package:gde_web/main.dart';
import 'package:gde_web/models/adminStructure.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class supabse_managemet extends GetxController {
  List<AdminStructure> admin = <AdminStructure>[].obs;
  Future<bool> login(String email, String password) async {
    final list = await getAllAdminStructure();
    final ad = list.firstWhere(
        (element) => element.email == email && element.password == password);
    print(ad);
    admin.isNotEmpty ? {admin.clear(), admin.add(ad)} : admin.add(ad);
    return list.contains(ad);
  }

  Future<List<AdminStructure>> getAllAdminStructure() async {
    List<AdminStructure> list = [];
    final listadmin = await MyApp.supabase.from("admin_structs").select('*');
    for (final i in listadmin) {
      final a = AdminStructure.fromJson(i);
      print(a);
      print(a);
      list.add(a);
    }
    return list;
  }
}
