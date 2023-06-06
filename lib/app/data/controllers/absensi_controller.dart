import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AbsensiController {
  HomeController homeC = Get.put(HomeController());
  Dio dio = Dio();

  Future<Absensi> getAbsensiToday() async {
    final response = await dio.get("$baseUrlAPI/absensi");
    Absensi absensi = Absensi();

    for (var item in response.data['data']) {
      if (item['user_id'] == homeC.userModel.value.id) {
        if (item['tanggal'] == DateTime.now().toString().split(' ')[0]) {
          absensi = Absensi.fromJson(item);
        }
      }
    }

    return absensi;
  }

  Future<void> createAbsensiToday() async {
    final response = await dio.post("$baseUrlAPI/absensi", data: {
      "user_id": homeC.userModel.value.id,
      "tanggal": DateTime.now().toString().split(' ')[0],
    });
  }
}
