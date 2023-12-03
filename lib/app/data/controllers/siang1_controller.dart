import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/siang1_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Siang1Controller {
  CancelToken siang1CancelToken = CancelToken();

  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  RxMap mapSiang1withUserId = {}.obs;
  RxMap mapSiang1FetchToday = {}.obs;
  RxMap mapSiang1FetchYesterday = {}.obs;

  Dio dio = Dio();

  Future<Siang1> getSiang1withUserId() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/siang1",
        cancelToken: siang1CancelToken,
      );

      Siang1 siang1 = Siang1();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            siang1 = Siang1.fromJson(item);
            mapSiang1withUserId.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            mapSiang1FetchYesterday.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            mapSiang1FetchToday.value = item;
          }
        }
      }

      // debugPrint("mapSiang1withUserId: $mapSiang1withUserId");
      // debugPrint("mapSiang1FetchToday: $mapSiang1FetchToday");
      // debugPrint("mapSiang1FetchYesterday: $mapSiang1FetchYesterday");

      return siang1;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Siang1();
    } catch (e) {
      debugPrint(e.toString());
      return Siang1();
    }
  }

  Future<Siang1> getSiang1Yesterday() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/siang1",
        cancelToken: siang1CancelToken,
      );
      Siang1 siang1 = Siang1();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            siang1 = Siang1.fromJson(item);
          }
        }
      }

      return siang1;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Siang1();
    } catch (e) {
      debugPrint(e.toString());
      return Siang1();
    }
  }

  Future<Siang1> getSiang1Today() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/siang1",
        cancelToken: siang1CancelToken,
      );
      Siang1 siang1 = Siang1();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            siang1 = Siang1.fromJson(item);
          }
        }
      }

      return siang1;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request");
      }

      return Siang1();
    } catch (e) {
      debugPrint(e.toString());
      return Siang1();
    }
  }

  Future<void> postSiang1(Position position, int radius, String status) async {
    Absensi absensi = await absensiC.getAbsensiToday();

    await dio.post("$baseUrlAPI/siang1", data: {
      "absensi_id": absensi.id,
      "jam_siang": DateTime.now().toString().split(' ')[1].split('.')[0],
      "radius": radius,
      "long": position.longitude,
      "lang": position.latitude,
      "status": status,
    }).then((value) => Get.snackbar("Berhasil", "Berhasil Absen Siang"));
  }
}
