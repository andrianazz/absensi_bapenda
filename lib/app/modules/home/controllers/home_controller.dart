import 'dart:convert';

import 'package:absensi_bapenda/app/data/models/data_absen_model.dart';
import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/app/data/models/user_model.dart';
import 'package:absensi_bapenda/app/routes/app_pages.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  String today = DateTime.now().toString().split(' ')[0];
  String yesterday =
      DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late SharedPreferences prefs;
  Map<String, dynamic> mapUser = {};

  Rx<User> userModel = User().obs;

  RxList<Masuk> listMasuk = <Masuk>[].obs;
  Rx<Masuk> todayMasuk = Masuk().obs;
  Rx<DataAbsenModel> dataAbsenModel = DataAbsenModel().obs;

  Dio dio = Dio();
  CancelToken getAbsenCancelToken = CancelToken();

  // ${"ANDRIAN WAHYU".split(' ').join('+')}
  RxString defaultImage =
      "https://ui-avatars.com/api/?name=No+Name&background=0D8ABC&bold=true&color=fff&rounded=true"
          .obs;
  RxString defaultProfile =
      "https://ui-avatars.com/api/?name=No+Name&background=0D8ABC&bold=true&color=fff&size=512"
          .obs;

  Future<Map<String, dynamic>> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      mapUser = jsonDecode(user);

      update();
      return mapUser;
    } else {
      return {};
    }
  }

  Future<User> getUserModel() async {
    userModel.value = User.fromJson(mapUser['data']);
    return userModel.value;
  }

  Future<String> checkSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      mapUser = jsonDecode(user);
      // debugPrint(mapUser.toString());

      return user;
    } else {
      return "";
    }
  }

  Future<void> deletePreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
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

  Future<bool> isWeekend() async {
    DateTime now = DateTime.now();
    return now.weekday == DateTime.saturday || now.weekday == DateTime.sunday;
  }

  Future<DataAbsenModel> getAbsen(String idPegawai) async {
    try {
      String endpoint = "$baseUrlAPI/v1/getabsen/$idPegawai";
      // debugPrint("endpoint: $endpoint");
      final response = await dio.get(
        endpoint,
        cancelToken: getAbsenCancelToken,
        options: Options(
          headers: <String, String>{
            "Authorization": "Basic QWJzZW5iYXBlbmRhOmIyQFlAM1NhTiE=",
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data != null) {
          return DataAbsenModel.fromJson(data);
        } else {
          return DataAbsenModel();
        }
      } else if (response.statusCode == 401) {
        Get.snackbar("Gagal", "Terjadi kesalahan");
        return DataAbsenModel();
      } else {
        Get.snackbar("Gagal", "Server Error");
        return DataAbsenModel();
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request getMasukwithUserId");
      }

      return DataAbsenModel();
    } catch (e) {
      debugPrint(e.toString());
      return DataAbsenModel();
    }
  }

  @override
  void onInit() async {
    if (await checkSharedPreference() == "") {
      Get.offAllNamed(Routes.LOGIN);
      await deletePreference();
    } else {
      mapUser = await getUser();
      userModel.value = await getUserModel();

      dataAbsenModel.value = await getAbsen(mapUser['data']['id'].toString());

      // debugPrint(userModel.value.toJson().toString());

      defaultImage.value = userModel.value.imageUrl!.isEmpty ||
              userModel.value.imageUrl == ""
          ? "https://ui-avatars.com/api/?name=${userModel.value.nama!.split(' ').join('+')}&background=0D8ABC&bold=true&color=fff&rounded=true"
          : "$baseUrl/storage/images/${userModel.value.imageUrl}";

      defaultProfile.value = userModel.value.imageUrl!.isEmpty ||
              userModel.value.imageUrl == ""
          ? "https://ui-avatars.com/api/?name=${userModel.value.nama!.split(' ').join('+')}&background=0D8ABC&bold=true&color=fff&size=512"
          : '$baseUrl/storage/images/${userModel.value.imageUrl}';
    }

    super.onInit();
  }
}
