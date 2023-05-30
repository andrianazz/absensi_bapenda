import 'dart:convert';

import 'package:absensi_bapenda/app/routes/app_pages.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nikC = TextEditingController();
  final passC = TextEditingController();
  RxBool obsecureText = true.obs;
  RxBool isLoading = false.obs;

  Dio dio = Dio();

  changeObsecureText() {
    obsecureText.value = !obsecureText.value;
    update();
  }

  Future<Map<String, dynamic>> loginAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    try {
      var response = await dio.post(
        "$baseUrlAPI/login",
        data: {
          "nik": nikC.text,
          "password": passC.text,
        },
        options: Options(
          receiveDataWhenStatusError: true,
          sendTimeout: const Duration(seconds: 5), // 60 seconds
          receiveTimeout: const Duration(seconds: 2),
        ),
      );

      print("Response Login : ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = response.data;

        if (data != null) {
          String user = jsonEncode({'data': data['data']});

          prefs.setString('user', user);
          Get.snackbar(
              "Login Berhasil", "${data['status']} ${data['data']['nama']}");
          isLoading.value = false;
          Get.offAllNamed(Routes.HOME);

          return data;
        } else {
          isLoading.value = false;
          Get.snackbar("Login Gagal", "Username / Password salah");
          return {"status": false, "message": "Terjadi kesalahan"};
        }
      } else if (response.statusCode == 401) {
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Status 401");
        return {"status": false, "message": "Terjadi kesalahan"};
      } else {
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Status 500");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Terjadi kesalahan koneksi");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
      if (e.type == DioErrorType.receiveTimeout) {
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Terjadi kesalahan koneksi");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
      if (e.type == DioErrorType.sendTimeout) {
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Terjadi kesalahan koneksi");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
    }

    isLoading.value = false;

    Get.snackbar("Login Gagal", "Terjadi kesalahan");
    return {"status": false, "message": "Terjadi kesalahan"};
  }
}
