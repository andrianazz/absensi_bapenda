import 'package:absensi_bapenda/app/data/models/siang1_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Siang1Controller {
  HomeController homeC = Get.put(HomeController());
  Dio dio = Dio();

  Future<Siang1> getSiang1withUserId() async {
    final response = await dio.get("$baseUrlAPI/siang1");
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
  }

  Future<Siang1> getSiang1Yesterday() async {
    final response = await dio.get("$baseUrlAPI/siang1");
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
  }

  Future<Siang1> getSiang1Today() async {
    final response = await dio.get("$baseUrlAPI/siang1");
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
  }

  Future<Map<String, dynamic>> postSiang1(
      Position position, int radius, String status) async {
    return await dio.post("$baseUrlAPI/siang1", data: {
      "user_id": homeC.userModel.value.id,
      "tanggal": DateTime.now().toString().split(' ')[0],
      "jam_siang": DateTime.now().toString().split(' ')[1].split('.')[0],
      "radius": radius,
      "long": position.longitude,
      "lang": position.latitude,
      "status": status,
    }).then((value) => value.data['message']);
  }
}
