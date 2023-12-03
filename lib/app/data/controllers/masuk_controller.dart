import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MasukController {
  CancelToken masukCancelToken = CancelToken();

  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  Dio dio = Dio();

  RxMap mapMasukwithUserId = {}.obs;
  RxMap mapFetchToday = {}.obs;
  RxMap mapFetchYesterday = {}.obs;

  Future<Masuk> getMasukwithUserId() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/masuk",
        cancelToken: masukCancelToken,
      );

      Masuk masuk = Masuk();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            masuk = Masuk.fromJson(item);
            mapMasukwithUserId.value = item;
          }

          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            mapFetchYesterday.value = item;
          }

          if (item['absensi']['user_id'] == homeC.userModel.value.id) {
            if (item['absensi']['tanggal'] ==
                DateTime.now().toString().split(' ')[0]) {
              mapFetchToday.value = item;
            }
          }
        }
      }

      // debugPrint("mapMasukwithUserId: $mapMasukwithUserId");
      // debugPrint("mapFetchToday: $mapFetchToday");
      // debugPrint("mapFetchYesterday: $mapFetchYesterday");

      return masuk;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request getMasukwithUserId");
      }

      return Masuk();
    } catch (e) {
      debugPrint(e.toString());
      return Masuk();
    }
  }

  Future<Masuk> getMasukYesterday() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/masuk",
        cancelToken: masukCancelToken,
      );

      Masuk masuk = Masuk();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toString()
                  .split(' ')[0]) {
            masuk = Masuk.fromJson(item);
          }
        }
      }

      return masuk;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request getMasukYesserday");
      }

      return Masuk();
    } catch (e) {
      debugPrint(e.toString());
      return Masuk();
    }
  }

  Future<Masuk> getMasukToday() async {
    try {
      final response = await dio.get(
        "$baseUrlAPI/masuk",
        cancelToken: masukCancelToken,
      );
      Masuk masuk = Masuk();

      for (var item in response.data['data']) {
        if (item['absensi']['user_id'] == homeC.userModel.value.id) {
          if (item['absensi']['tanggal'] ==
              DateTime.now().toString().split(' ')[0]) {
            masuk = Masuk.fromJson(item);
          }
        }
      }

      return masuk;
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response!.statusCode == 404) {
        debugPrint("Data Masuk Belum Ada");
      } else if (e.response!.statusCode == 500) {
        debugPrint("Server Error");
      } else if (e.response!.statusCode == 429) {
        debugPrint("Terlalu Banyak Request Today");
      }

      return Masuk();
    } catch (e) {
      debugPrint(e.toString());
      return Masuk();
    }
  }

  Future<void> postMasuk(Position position, int radius, String status) async {
    Absensi absensi = await absensiC.getAbsensiToday();

    await dio.post("$baseUrlAPI/masuk", data: {
      "absensi_id": absensi.id,
      "jam_masuk": DateTime.now().toString().split(' ')[1].split('.')[0],
      "radius": radius,
      "long": position.longitude,
      "lang": position.latitude,
      "status": status,
    }).then((value) => Get.snackbar("Berhasil", "Berhasil Absen"));
  }
}
