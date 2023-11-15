import 'package:get/get.dart';

import '../models/absensi_model.dart';

class AbsensiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Absensi.fromJson(map);
      if (map is List) {
        return map.map((item) => Absensi.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Absensi?> getAbsensi(int id) async {
    final response = await get('absensi/$id');
    return response.body;
  }

  Future<Response<Absensi>> postAbsensi(Absensi absensi) async =>
      await post('absensi', absensi);
  Future<Response> deleteAbsensi(int id) async => await delete('absensi/$id');
}
