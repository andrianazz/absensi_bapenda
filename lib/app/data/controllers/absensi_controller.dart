import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbsensiController {
  HomeController homeC = Get.put(HomeController());
  Dio dio = Dio();

  Future<Absensi> getAbsensiToday() async {
    try {
      final response = await dio.get("$baseUrlAPI/absensi");
      Absensi absensi = Absensi();

      if (response.statusCode == 200) {
        for (var item in response.data['data']) {
          if (item['user_id'] == homeC.userModel.value.id) {
            if (item['tanggal'] == DateTime.now().toString().split(' ')[0]) {
              absensi = Absensi.fromJson(item);
            }
          }
        }
      }

      return absensi;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        debugPrint("Connection Timeout");
        Get.snackbar("Terjadi Kesalahan", "Connection Timeout");
      } else if (e.type == DioErrorType.receiveTimeout) {
        debugPrint("Receive Timeout");
        Get.snackbar("Terjadi Kesalahan", "Receive Timeout");
      } else if (e.type == DioErrorType.badResponse) {
        debugPrint("Bad Response");
        Get.snackbar("Terjadi Kesalahan", "Bad Response");
      } else if (e.type == DioErrorType.sendTimeout) {
        debugPrint("Send Timeout");
        Get.snackbar("Terjadi Kesalahan", "Send Timeout");
      } else if (e.type == DioErrorType.cancel) {
        debugPrint("Request Cancelled");
        Get.snackbar("Terjadi Kesalahan", "Request Cancelled");
      } else {
        debugPrint("Connection Timeout");
        Get.snackbar("Terjadi Kesalahan", "${e.type}");
      }
      return Absensi();
    } catch (e) {
      debugPrint("$e");
      Get.snackbar("Terjadi Kesalahan", "$e");
      return Absensi();
    }
  }

  Future<void> createAbsensiToday() async {
    try {
      final response = await dio.post("$baseUrlAPI/absensi", data: {
        "user_id": homeC.userModel.value.id,
        "tanggal": DateTime.now().toString().split(' ')[0],
      });

      if (response.statusCode == 200) {
        return;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        debugPrint("Connection Timeout");
        Get.snackbar("Terjadi Kesalahan", "Connection Timeout");
      } else if (e.type == DioErrorType.receiveTimeout) {
        debugPrint("Receive Timeout");
        Get.snackbar("Terjadi Kesalahan", "Receive Timeout");
      } else if (e.type == DioErrorType.badResponse) {
        debugPrint("Bad Response");
        Get.snackbar("Terjadi Kesalahan", "Bad Response");
      } else if (e.type == DioErrorType.sendTimeout) {
        debugPrint("Send Timeout");
        Get.snackbar("Terjadi Kesalahan", "Send Timeout");
      } else if (e.type == DioErrorType.cancel) {
        debugPrint("Request Cancelled");
        Get.snackbar("Terjadi Kesalahan", "Request Cancelled");
      } else {
        debugPrint("Terjadi Kesalahan");
        Get.snackbar("Terjadi Kesalahan", "${e.type}");
      }
    } catch (e) {
      debugPrint("$e");
      Get.snackbar("Terjadi Kesalahan", "$e");
    }
  }
}
