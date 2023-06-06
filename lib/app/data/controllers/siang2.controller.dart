import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/siang2_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Siang2Controller {
  HomeController homeC = Get.put(HomeController());
  AbsensiController absensiC = Get.put(AbsensiController());

  Dio dio = Dio();

  Future<Siang2> getSiang2withUserId() async {
    final response = await dio.get("$baseUrlAPI/siang2");
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
  }

  Future<Siang2> getSiang2Yesterday() async {
    final response = await dio.get("$baseUrlAPI/siang2");
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
  }

  Future<Siang2> getSiang2Today() async {
    final response = await dio.get("$baseUrlAPI/siang2");
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
  }

  Future<Map<String, dynamic>> postSiang2(
      Position position, int radius, String status) async {
    Absensi absensi = await absensiC.getAbsensiToday();

    return await dio.post("$baseUrlAPI/siang2", data: {
      "absensi_id": absensi.id,
      "jam_siang2": DateTime.now().toString().split(' ')[1].split('.')[0],
      "radius": radius,
      "long": position.longitude,
      "lang": position.latitude,
      "status": status,
    }).then((value) => value.data['message']);
  }
}
