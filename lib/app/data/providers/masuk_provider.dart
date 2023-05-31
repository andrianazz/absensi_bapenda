import 'package:absensi_bapenda/theme/variable.dart';
import 'package:get/get.dart';

import '../models/masuk_model.dart';

class MasukProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Masuk.fromJson(map);
      if (map is List) return map.map((item) => Masuk.fromJson(item)).toList();
    };
    httpClient.baseUrl = "$baseUrlAPI/";
  }

  Future<List<Masuk>?> getAllMasuk() async {
    final response = await get('masuk');
    return response.body;
  }

  Future<Masuk?> getMasuk(int id) async {
    final response = await get('masuk/$id');
    print((response.body as Masuk).toJson());
    return response.body;
  }

  Future<Response<Masuk>> postMasuk(Masuk masuk) async =>
      await post('masuk', masuk);

  Future<Response> deleteMasuk(int id) async => await delete('masuk/$id');
}
