import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/medicine.dart';

class GlobalBloc {
  BehaviorSubject<List<Medicine>>? _medicineList$;
  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;

  GlobalBloc() {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    //makeMedicineList();
  }

  Future<String?> getCurrentUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

  Future makeMedicineList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String? email = await getCurrentUserEmail();
    if (email == null) return; // User not logged in

    List<String>? jsonList = sharedUser.getStringList(email); // Use email as the key
    List<Medicine> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      _medicineList$!.add(prefList); // Update state
    }
  }

  Future updateMedicineList(Medicine newMedicine) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String? email = await getCurrentUserEmail();
    if (email == null) return; // User not logged in

    var blocList = _medicineList$!.value;
    blocList.add(newMedicine);
    _medicineList$!.add(blocList);

    Map<String, dynamic> tempMap = newMedicine.toJson();
    String newMedicineJson = jsonEncode(tempMap);

    List<String> medicineJsonList = sharedUser.getStringList(email) ?? []; // Use email as the key
    medicineJsonList.add(newMedicineJson);

    await sharedUser.setStringList(email, medicineJsonList);
  }

  Future removeMedicine(Medicine tobeRemoved) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String? email = await getCurrentUserEmail();
    if (email == null) return; // User not logged in

    List<Medicine> blockList = List.from(_medicineList$!.value);
    blockList.removeWhere((medicine) => medicine.medicineName == tobeRemoved.medicineName);

    List<String> medicineJsonList = [];
    if (blockList.isNotEmpty) {
      for (var blockMedicine in blockList) {
        String medicineJson = jsonEncode(blockMedicine.toJson());
        medicineJsonList.add(medicineJson);
      }
    }

    await sharedUser.setStringList(email, medicineJsonList); // Use email as the key
    _medicineList$!.add(blockList); // Update the BehaviorSubject
  }

  void dispose() {
    _medicineList$!.close();
  }
  void clearList()
  {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
  }
}