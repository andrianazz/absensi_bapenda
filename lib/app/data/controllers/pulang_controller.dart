import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/pulang_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PulangController {
  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  Dio dio = Dio();

  Future<Pulang> getPulangwithUserId() async {
    final response = await dio.get("$baseUrlAPI/pulang");
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
  }

  Future<Pulang> getPulangYesterday() async {
    final response = await dio.get("$baseUrlAPI/pulang");
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
  }

  Future<Pulang> getPulangToday() async {
    final response = await dio.get("$baseUrlAPI/pulang");
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
