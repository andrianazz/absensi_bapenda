import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MasukController {
  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  Dio dio = Dio();

  Future<Masuk> getMasukwithUserId() async {
    final response = await dio.get("$baseUrlAPI/masuk");
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
  }

  Future<Masuk> getMasukYesterday() async {
    final response = await dio.get("$baseUrlAPI/masuk");
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
  }

  Future<Masuk> getMasukToday() async {
    final response = await dio.get("$baseUrlAPI/masuk");
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
