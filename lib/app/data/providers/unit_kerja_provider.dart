import 'package:get/get.dart';

import '../models/unit_kerja_model.dart';

class UnitKerjaProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UnitKerja.fromJson(map);
      if (map is List) {
        return map.map((item) => UnitKerja.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UnitKerja?> getUnitKerja(int id) async {
    final response = await get('unitkerja/$id');
    return response.body;
  }

  Future<Response<UnitKerja>> postUnitKerja(UnitKerja unitkerja) async =>
      await post('unitkerja', unitkerja);
  Future<Response> deleteUnitKerja(int id) async =>
      await delete('unitkerja/$id');
}
