import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart';

class MasukController {
  Dio dio = Dio();

  Future<List<Masuk>> getAllMasuk() async {
    final response = await dio.get("$baseUrlAPI/masuk");
    return (response.data['data'] as List)
        .map((e) => Masuk.fromJson(e))
        .toList();
  }

  Future<Masuk> getMasuk(int id) async {
    final response = await dio.get("$baseUrlAPI/masuk/$id");
    return Masuk.fromJson(response.data['data']);
  }
}
