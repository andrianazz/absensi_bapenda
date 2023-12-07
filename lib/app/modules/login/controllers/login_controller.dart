import 'dart:convert';

import 'package:absensi_bapenda/app/routes/app_pages.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nikC = TextEditingController();
  final passC = TextEditingController();
  RxBool obsecureText = true.obs;
  RxBool isLoading = false.obs;
  RxString statusLoading = "".obs;

  Dio dio = Dio();

  changeObsecureText() {
    obsecureText.value = !obsecureText.value;
    update();
  }

  Future<Map<String, dynamic>> loginAPI(String nik, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    statusLoading.value = "Loading...";
    if (isLoading.value == true) {
      voidDialogLoading();
    }

    try {
      // var response = await http.post(
      //   "$baseUrlAPI/login",
      //   data: {
      //     "nik": nik,
      //     "password": pass,
      //   },
      //   options: Options(
      //     receiveDataWhenStatusError: true,
      //     sendTimeout: const Duration(seconds: 5), // 60 seconds
      //     receiveTimeout: const Duration(seconds: 2),
      //   ),
      // );

      statusLoading.value = "Mencoba login...";

      var response = await http.post(
        Uri.parse("$baseUrlAPI/login"),
        body: {
          "nik": nik,
          "password": pass,
        },
        headers: {
          "Accept": "application/json",
        },
        encoding: Encoding.getByName("utf-8"),
      );

      // debugPrint("Response Login : ${response.statusCode}");

      if (response.statusCode == 200) {
        statusLoading.value = "Berhasil login...";

        Get.back();
        isLoading.value = false;

        // convert data to json

        var data = jsonDecode(response.body);

        String user = jsonEncode({'data': data['data']});

        prefs.setString('user', user);
        Get.snackbar(
            "Login Berhasil", "${data['message']} ${data['data']['nama']}");

        Get.offAllNamed(Routes.HOME);

        return data;
      } else if (response.statusCode == 401) {
        Get.back();
        isLoading.value = false;
        Get.defaultDialog(
          title: "Login Gagal",
          middleText: "NIK atau Password salah",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
        return {"status": false, "message": "Terjadi kesalahan"};
      } else {
        Get.back();
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Status 500");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        Get.back();
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Terjadi kesalahan koneksi");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
      if (e.type == DioErrorType.receiveTimeout) {
        Get.back();
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Terjadi kesalahan koneksi");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
      if (e.type == DioErrorType.sendTimeout) {
        Get.back();
        isLoading.value = false;
        Get.snackbar("Login Gagal", "Terjadi kesalahan koneksi");
        return {"status": false, "message": "Terjadi kesalahan"};
      }
    } catch (e) {
      Get.back();
      isLoading.value = false;
      debugPrint("Error Login : $e");
      Get.snackbar("Login Gagal", "Terjadi kesalahan");
      return {"status": false, "message": "Terjadi kesalahan"};
    }

    return {"status": false, "message": "Terjadi kesalahan"};
  }

  void voidDialogLoading() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(width: 20.w),
                    Obx(() => Expanded(child: Text(statusLoading.value))),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              ElevatedButton(
                onPressed: () {
                  isLoading.value = false;
                  Get.back();
                  return;
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
