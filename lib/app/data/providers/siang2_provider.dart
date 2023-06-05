import 'package:get/get.dart';

import '../models/siang2_model.dart';

class Siang2Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Siang2.fromJson(map);
      if (map is List) return map.map((item) => Siang2.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Siang2?> getSiang2(int id) async {
    final response = await get('siang2/$id');
    return response.body;
  }

  Future<Response<Siang2>> postSiang2(Siang2 siang2) async =>
      await post('siang2', siang2);
  Future<Response> deleteSiang2(int id) async => await delete('siang2/$id');
}
