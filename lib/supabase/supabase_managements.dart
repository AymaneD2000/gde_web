// ignore_for_file: camel_case_types

import 'package:gde_web/main.dart';
import 'package:gde_web/models/Options.dart';
import 'package:gde_web/models/Poste.dart';
import 'package:gde_web/models/Structure.dart';
import 'package:gde_web/models/Videos.dart';
import 'package:gde_web/models/adminStructure.dart';
import 'package:gde_web/models/faculte_filiere.dart';
import 'package:gde_web/models/faculte_options.dart';
import 'package:gde_web/models/faculter_model.dart';
import 'package:gde_web/models/filiere.dart';
import 'package:gde_web/models/filiere_structure.dart';
import 'package:gde_web/models/photos.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/optionsStructure.dart';

class supabse_managemet extends GetxController {
  List<AdminStructure> admin = <AdminStructure>[].obs;
  List<Filiere> filiers = <Filiere>[].obs;
  List<Faculter> faculter = <Faculter>[].obs;
  List<Publication> publiciter = <Publication>[].obs;
  List<FaculteFiliere> faculteFiliere = <FaculteFiliere>[].obs;
  List<FaculteOptions> faculteOptions = <FaculteOptions>[].obs;
  List<FiliereStructure> filierestructure = <FiliereStructure>[].obs;
  List<OptionsStructure> optionsStructure = <OptionsStructure>[].obs;
  Future<bool> loginStructure(String email, String password) async {
    try {
      final ad = await MyApp.supabase
          .from("admin")
          .select("*")
          .eq("email", email)
          .eq("password", password);
      final list = ad.map((e) => AdminStructure.fromJson(e));
      final a = list.first;
      final struct = await MyApp.supabase
          .from("structure")
          .select("*")
          .eq("structure_id", a.structure_id);
      final s = struct.map((e) => Structure.fromJson(e)).first;
      final faculty = await MyApp.supabase
          .from("faculte")
          .select("*")
          .eq("id_univ", a.structure_id);
      List<Faculter> listfaculty = [];
      for (final i in faculty) {
        listfaculty.add(Faculter.fromJson(i));
      }
      faculter = listfaculty;
      //a.structure.faculter = listfaculty;
      s.faculter = listfaculty;
      a.structure = s;
      admin.add(a);
      filiers = await getAllFiliere();
      filierestructure = await getFiliereStructure();
      optionsStructure = await getOptionsStructure();
      await getPublication(a.structure_id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  updateFaculter(Faculter fac) async {
    await MyApp.supabase.from('faculte').update({
      "description": fac.description,
      "email": fac.email,
      "image": fac.image,
      "localisation": fac.localisation,
      "nom": fac.nom,
      "sigle": fac.sigle
    }).eq("id_faculte", fac.idfaculter).then((value) => {});
  }

  Future<bool> loginFaculty(String email, String password) async {
    try {
      final ad = await MyApp.supabase
          .from("admin")
          .select("*")
          .eq("email", email)
          .eq("password", password);
      final list = ad.map((e) => AdminStructure.fromJson(e));
      final a = list.first;
      final struct = await MyApp.supabase
          .from("faculte")
          .select("*")
          .eq("id_faculte", a.idfaculte);
      final s = struct.map((e) => Faculter.fromJson(e)).first;
      //a.structure.faculter = listfaculty;
      a.faculter = s;
      admin.add(a);
      filiers = await getAllFiliere();
      faculteFiliere = await getFiliereFaculte();
      faculteOptions = await getOptionsFaculte();
      await getFacultePublication(a.idfaculte);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  addStructure(Structure structure, String username) async {
    final data = await MyApp.supabase
        .from('structure')
        .insert(structure.toJson())
        .select();
    await MyApp.supabase.from('admin').update({"username": username}).eq(
        'structure_id', Structure.fromJson(data).id);
  }

  addPublication(Publication pub, int structureId, List<String> photos,
      List<String> videos) async {
    // Formatage de la date au format ISO 8601
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(pub.date);
    try {
      var uuid = const Uuid();
      await MyApp.supabase.from('publication').insert({
        "id": pub.idPublication,
        "description": pub.information,
        "structure_id": structureId,
        "date": formattedDate
      }).whenComplete(() async {
        print("complete");
        if (photos.isNotEmpty) {
          for (final p in photos) {
            await MyApp.supabase.from('image').insert({
              "id": const Uuid().v4(),
              "image": p,
              "id_pub": pub.idPublication
            });
          }
        }
        print("complete");
        if (videos.isNotEmpty) {
          for (final p in videos) {
            await MyApp.supabase.from('video').insert(
                {"id": uuid.v4(), "video": p, "id_pub": pub.idPublication});
          }
        }
      });
      publiciter.add(pub);
    } catch (e) {
      print(e);
    }
  }

  addFacultePublication(Publication pub, int structureId, List<String> photos,
      List<String> videos) async {
    // Formatage de la date au format ISO 8601
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(pub.date);
    try {
      var uuid = const Uuid();
      await MyApp.supabase.from('publication').insert({
        "id": pub.idPublication,
        "description": pub.information,
        "faculte_id": structureId,
        "date": formattedDate
      }).whenComplete(() async {
        print("complete");
        if (photos.isNotEmpty) {
          for (final p in photos) {
            await MyApp.supabase.from('image').insert({
              "id": const Uuid().v4(),
              "image": p,
              "id_pub": pub.idPublication
            });
          }
        }
        print("complete");
        if (videos.isNotEmpty) {
          for (final p in videos) {
            await MyApp.supabase.from('video').insert(
                {"id": uuid.v4(), "video": p, "id_pub": pub.idPublication});
          }
        }
      });
      publiciter.add(pub);
    } catch (e) {
      print(e);
    }
  }

  getPublication(int idStructure) async {
    final ad = await MyApp.supabase
        .from("publication")
        .select("*")
        .eq("structure_id", idStructure);
    final list = ad.map((e) => Publication.fromJson(e));
    final a = list.toList();
    for (final i in a) {
      final img = await MyApp.supabase
          .from("image")
          .select("*")
          .eq("id_pub", i.idPublication);
      final imgList = img.map((e) => Photo.fromJson(e)).toList();
      final vdo = await MyApp.supabase
          .from("video")
          .select("*")
          .eq("id_pub", i.idPublication);
      final vdoList = vdo.map((e) => Video.fromJson(e)).toList();
      i.video = vdoList;
      i.photo = imgList;
      publiciter.add(i as Publication);
    }
    //publiciter = a;
    //return a;
  }

  getFacultePublication(int idStructure) async {
    final ad = await MyApp.supabase
        .from("publication")
        .select("*")
        .eq("faculte_id", idStructure);
    final list = ad.map((e) => Publication.fromJson(e));
    final a = list.toList();
    for (final i in a) {
      final img = await MyApp.supabase
          .from("image")
          .select("*")
          .eq("id_pub", i.idPublication);
      final imgList = img.map((e) => Photo.fromJson(e)).toList();
      final vdo = await MyApp.supabase
          .from("video")
          .select("*")
          .eq("id_pub", i.idPublication);
      final vdoList = vdo.map((e) => Video.fromJson(e)).toList();
      i.video = vdoList;
      i.photo = imgList;
      publiciter.add(i as Publication);
    }
    //publiciter = a;
    //return a;
  }

  Future<List<FiliereStructure>> getFiliereStructure() async {
    List<FiliereStructure> file = [];
    final listFiliere =
        await MyApp.supabase.from("filiere_structure").select('*');
    for (final i in listFiliere) {
      final a = FiliereStructure.fromJson(i);
      file.add(a);
    }
    return file;
  }

  Future<List<FaculteFiliere>> getFiliereFaculte() async {
    List<FaculteFiliere> file = [];
    final listFiliere =
        await MyApp.supabase.from("filiere_faculte").select('*');
    for (final i in listFiliere) {
      final a = FaculteFiliere.fromJson(i);
      file.add(a);
    }
    return file;
  }

  Future<List<OptionsStructure>> getOptionsStructure() async {
    List<OptionsStructure> file = [];
    final list_options =
        await MyApp.supabase.from("structure_options").select('*');
    for (final i in list_options) {
      final a = OptionsStructure.fromJson(i);
      file.add(a);
    }
    return file;
  }

  Future<List<FaculteOptions>> getOptionsFaculte() async {
    List<FaculteOptions> file = [];
    final listOptions =
        await MyApp.supabase.from("faculte_options").select('*');
    for (final i in listOptions) {
      final a = FaculteOptions.fromJson(i);
      file.add(a);
    }
    return file;
  }

  deleteFiliereStructure(filiereId, structureId, options) async {
    await MyApp.supabase
        .from("filiere_structure")
        .delete()
        .eq("structure_id", structureId)
        .eq("filiere_id", filiereId);
    for (final i in options) {
      deleteOptionsStructure(i.id, structureId);
    }
    filierestructure = await getFiliereStructure();
  }

  deleteFiliereFaculte(filiereId, faculteId, options) async {
    await MyApp.supabase
        .from("filiere_faculte")
        .delete()
        .eq("faculte_id", faculteId)
        .eq("filiere_id", filiereId);
    for (final i in options) {
      deleteOptionsFaculte(i.id, faculteId);
    }
    faculteFiliere = await getFiliereFaculte();
  }

  addFiliereStructure(filiereId, structureId) async {
    await MyApp.supabase
        .from("filiere_structure")
        .insert({"structure_id": structureId, "filiere_id": filiereId});
    filierestructure = await getFiliereStructure();
  }

  addFiliereFaculte(filiereId, faculteId) async {
    await MyApp.supabase
        .from("filiere_faculte")
        .insert({"faculte_id": faculteId, "filiere_id": filiereId});
    faculteFiliere = await getFiliereFaculte();
  }

  deleteOptionsStructure(optionsId, structureId) async {
    await MyApp.supabase
        .from("structure_options")
        .delete()
        .eq("id_structure", structureId)
        .eq("id_option", optionsId);
    optionsStructure = await getOptionsStructure();
  }

  deleteOptionsFaculte(optionsId, faculteId) async {
    await MyApp.supabase
        .from("faculte_options")
        .delete()
        .eq("faculte_id", faculteId)
        .eq("option_id", optionsId);
    faculteOptions = await getOptionsFaculte();
  }

  addOptionsStructure(optionsId, structureId) async {
    await MyApp.supabase
        .from("structure_options")
        .insert({"id_structure": structureId, "id_option": optionsId});
    optionsStructure = await getOptionsStructure();
  }

  addFaculteOptions(optionsId, faculteId) async {
    await MyApp.supabase
        .from("faculte_options")
        .insert({"faculte_id": faculteId, "option_id": optionsId});
    faculteOptions = await getOptionsFaculte();
  }

  Future<List<Filiere>> getAllFiliere() async {
    List<Filiere> list = [];
    final listadmin = await MyApp.supabase.from("filiere").select('*');

    for (final i in listadmin) {
      final a = Filiere.fromJson(i);
      var f = await MyApp.supabase
          .from("option")
          .select('*')
          .eq("filiere_id", a.id);
      final listOptions = await f.map((e) {
        return Option.fromJson(e);
      }).toList();
      a.list_option = listOptions;
      list.add(a);
    }
    return list;
  }
}

// Fonction pour convertir la chaîne de date en objet DateTime
DateTime parseDate(String dateString) {
  return DateTime.parse(dateString);
}

Future<List<AdminStructure>> getAllAdminStructure() async {
  List<AdminStructure> list = [];
  final listadmin = await MyApp.supabase.from("admin").select('*');

  for (final i in listadmin) {
    final a = AdminStructure.fromJson(i);
    list.add(a);
  }
  return list;
}
// ...

