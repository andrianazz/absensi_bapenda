import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/siang2_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Siang2Controller {
  CancelToken siang2CancelToken = CancelToken();

  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  RxMap mapSiang2withUserId = {}.obs;
  RxMap mapSiang2FetchToday = {}.obs;
  RxMap mapSiang2FetchYesterday = {}.obs;

  Dio dio = Dio();

  Future<Siang2> getSiang2withUserId() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/siang2",
        cancelToken: siang2CancelToken,
      );
      Siang2 siang2 = Siang2();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            siang2 = Siang2.fromJson(item);
            mapSiang2withUserId.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            mapSiang2FetchYesterday.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            mapSiang2FetchToday.value = item;
          }
        }
      }

      // debugPrint("mapSiang2withUserId: $mapSiang2withUserId");
      // debugPrint("mapSiang2FetchToday: $mapSiang2FetchToday");
      // debugPrint("mapSiang2FetchYesterday: $mapSiang2FetchYesterday");

      return siang2;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Siang2();
    } catch (e) {
      debugPrint(e.toString());
      return Siang2();
    }
  }

  Future<Siang2> getSiang2Yesterday() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/siang2",
        cancelToken: siang2CancelToken,
      );
      Siang2 siang2 = Siang2();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            siang2 = Siang2.fromJson(item);
          }
        }
      }

      return siang2;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Siang2();
    } catch (e) {
      debugPrint(e.toString());
      return Siang2();
    }
  }

  Future<Siang2> getSiang2Today() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/siang2",
        cancelToken: siang2CancelToken,
      );
      Siang2 siang2 = Siang2();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            siang2 = Siang2.fromJson(item);
          }
        }
      }

      return siang2;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Siang2();
    } catch (e) {
      debugPrint(e.toString());
      return Siang2();
    }
  }

  Future<void> postSiang2(Position position, int radius, String status) async {
    Absensi absensi = await absensiC.getAbsensiToday();

    await dio.post("$baseUrlAPI/siang2", data: {
      "absensi_id": absensi.id,
      "jam_siang2": DateTime.now().toString().split(' ')[1].split('.')[0],
      "radius": radius,
      "long": position.longitude,
      "lang": position.latitude,
      "status": status,
    }).then((value) => Get.snackbar("Berhasil", "Berhasil Absen Siang2"));
  }
}
