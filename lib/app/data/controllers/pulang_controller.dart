import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/pulang_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PulangController {
  CancelToken pulangCancelToken = CancelToken();

  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  RxMap mapPulangwithUserId = {}.obs;
  RxMap mapPulangFetchToday = {}.obs;
  RxMap mapPulangFetchYesterday = {}.obs;

  Dio dio = Dio();

  Future<Pulang> getPulangwithUserId() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/pulang",
        cancelToken: pulangCancelToken,
      );
      Pulang pulang = Pulang();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            pulang = Pulang.fromJson(item);
            mapPulangwithUserId.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            mapPulangFetchYesterday.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            mapPulangFetchToday.value = item;
          }
        }
      }

      return pulang;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Pulang();
    } catch (e) {
      debugPrint(e.toString());
      return Pulang();
    }
  }

  Future<Pulang> getPulangYesterday() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/pulang",
        cancelToken: pulangCancelToken,
      );
      Pulang pulang = Pulang();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            pulang = Pulang.fromJson(item);
          }
        }
      }

      return pulang;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Pulang();
    } catch (e) {
      debugPrint(e.toString());
      return Pulang();
    }
  }

  Future<Pulang> getPulangToday() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/pulang",
        cancelToken: pulangCancelToken,
      );
      Pulang pulang = Pulang();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            pulang = Pulang.fromJson(item);
          }
        }
      }

      return pulang;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Pulang();
    } catch (e) {
      debugPrint(e.toString());
      return Pulang();
    }
  }

  Future<void> postPulang(Position position, int radius, String status) async {
    Absensi absensi = await absensiC.getAbsensiToday();

    await dio.post("$baseUrlAPI/pulang", data: {
      "absensi_id": absensi.id,
      "jam_pulang": DateTime.now().toString().split(' ')[1].split('.')[0],
      "radius": radius,
      "long": position.longitude,
      "lang": position.latitude,
      "status": status,
    }).then((value) => Get.snackbar("Berhasil", "Berhasil Pulang"));
  }
}
