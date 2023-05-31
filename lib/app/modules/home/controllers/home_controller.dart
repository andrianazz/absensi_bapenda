import 'dart:convert';

import 'package:absensi_bapenda/app/data/controllers/masuk_controller.dart';
import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/app/data/models/user_model.dart';
import 'package:absensi_bapenda/app/routes/app_pages.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  MasukController masukC = Get.put(MasukController());

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences prefs;
  Map<String, dynamic> mapUser = {};

  Rx<User> userModel = User().obs;

  RxList<Masuk> listMasuk = <Masuk>[].obs;
  Rx<Masuk> todayMasuk = Masuk().obs;

  Dio dio = Dio();

  // ${"ANDRIAN WAHYU".split(' ').join('+')}
  RxString defaultImage =
      "https://ui-avatars.com/api/?name=No+Name&background=0D8ABC&bold=true&color=fff&rounded=true"
          .obs;

  Future<Map<String, dynamic>> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      mapUser = jsonDecode(user);
      userModel.value = User.fromJson(mapUser['data']);
      update();
      return mapUser;
    } else {
      return {};
    }
  }

  Future<String> checkSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      mapUser = jsonDecode(user);

      return user;
    } else {
      return "";
    }
  }

  Future<void> deletePreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<void> logout() async {
    Dio dio = Dio();
    var response = await dio.post(
      "$baseUrlAPI/logout",
    );

    if (response.statusCode == 200) {
      var data = response.data;
      if (data != null) {
        deletePreference();
        Get.snackbar("Logout Berhasil", "${data['status']}");
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Logout Gagal", "Terjadi kesalahan");
      }
    } else if (response.statusCode == 401) {
      Get.snackbar("Logout Gagal", "Status 401");
    } else {
      Get.snackbar("Logout Gagal", "Status 500");
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    mapUser = await getUser();

    if (await checkSharedPreference() == "") {
      Get.offAllNamed(Routes.LOGIN);
      await deletePreference();
    } else {
      defaultImage.value =
          "https://ui-avatars.com/api/?name=${userModel.value.nama!.split(' ').join('+')}&background=0D8ABC&bold=true&color=fff&rounded=true";
      // listMasuk.value = (await MasukProvider().getAllMasuk())!;

      listMasuk.value = await masukC.getAllMasuk();

      //get listmasuk with absensi user_id = usermodel.id
      listMasuk.value
          .where((element) => element.absensi?.userId == userModel.value.id);

      DateTime today = DateTime.now();
      print(today);

      print(userModel.toJson());
    }
  }
}
