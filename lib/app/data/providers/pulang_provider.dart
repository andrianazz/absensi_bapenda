import 'package:get/get.dart';

import '../models/pulang_model.dart';

class PulangProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Pulang.fromJson(map);
      if (map is List) return map.map((item) => Pulang.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Pulang?> getPulang(int id) async {
    final response = await get('pulang/$id');
    return response.body;
  }

  Future<Response<Pulang>> postPulang(Pulang pulang) async =>
      await post('pulang', pulang);
  Future<Response> deletePulang(int id) async => await delete('pulang/$id');
}
