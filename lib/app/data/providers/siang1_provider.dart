import 'package:get/get.dart';

import '../models/siang1_model.dart';

class Siang1Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Siang1.fromJson(map);
      if (map is List) return map.map((item) => Siang1.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Siang1?> getSiang1(int id) async {
    final response = await get('siang1/$id');
    return response.body;
  }

  Future<Response<Siang1>> postSiang1(Siang1 siang1) async =>
      await post('siang1', siang1);
  Future<Response> deleteSiang1(int id) async => await delete('siang1/$id');
}
