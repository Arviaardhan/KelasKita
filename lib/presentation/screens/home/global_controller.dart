import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../data/models/biografi_model.dart';
import '../../registration/biografi/kelas_model.dart';

class GlobalController extends GetxController {
  var isLoading = true.obs;
  RxString userName = ''.obs;
  RxString idBiodata = ''.obs;
  var selectedKelas = KelasModel(
      idKelas: 0,
      nama: '',
      idBiodata: 0,
      jumlahKas: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
  ).obs;
  RxString advancedClassSchedule = '11 PPLG 2'.obs;
  RxList<InfoBiografiModel> biografiList = <InfoBiografiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 4), () {
      isLoading.value = false;
    });
    loadUserName();
    fetchBiografi();
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('nama') ?? '';
  }

  Future<void> saveUserName(String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', nama);
    userName.value = nama;
  }

  Future<void> saveIdBiodata(int id_biodata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_biodata', idBiodata.toString());
    idBiodata.value = id_biodata.toString();
  }

  Future<void> refreshHome() async {
    isLoading.value = true;
    await loadUserName();
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }

  void advanceSchedule(String newSchedule) {
    advancedClassSchedule.value = newSchedule;
  }

  Future<void> fetchBiografi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      int? userId = prefs.getInt('id_user');

      if (userId != null) {
        final response = await http.get(
          Uri.parse('$baseUrl$biodataEndpointGet$userId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          print('JSON Response: $jsonResponse');

          var fetchedData = InfoBiografiModel.fromJson(jsonResponse);
          biografiList.value = [fetchedData];

          // Save the user's name in shared preferences
          await saveUserName(fetchedData.nama ?? '');
          await saveIdBiodata((fetchedData.idBiodata ?? '') as int);

          print('Successfully loaded biografi data: ${biografiList.length}');
        } else {
          print('Failed to load biografi, status code: ${response.statusCode}');
          throw Exception('Failed to load biografi');
        }
      } else {
        print('User ID is null. Unable to fetch biografi.');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
