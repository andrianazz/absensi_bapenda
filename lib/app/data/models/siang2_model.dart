import 'package:absensi_bapenda/app/data/models/absensi_model.dart';

class Siang2 {
  int? id;
  int? absensiId;
  String? jamSiang2;
  String? long;
  String? lang;
  String? radius;
  String? status;
  String? createdAt;
  String? updatedAt;
  Absensi? absensi;

  Siang2(
      {this.id,
      this.absensiId,
      this.jamSiang2,
      this.long,
      this.lang,
      this.radius,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.absensi});

  Siang2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    absensiId = json['absensi_id'];
    jamSiang2 = json['jam_siang2'];
    long = json['long'];
    lang = json['lang'];
    radius = json['radius'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    absensi =
        json['absensi'] != null ? Absensi?.fromJson(json['absensi']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['absensi_id'] = absensiId;
    data['jam_siang2'] = jamSiang2;
    data['long'] = long;
    data['lang'] = lang;
    data['radius'] = radius;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (absensi != null) {
      data['absensi'] = absensi?.toJson();
    }
    return data;
  }
}
