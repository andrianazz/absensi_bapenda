import 'package:absensi_bapenda/app/data/models/absensi_model.dart';

class Siang1 {
  int? id;
  int? absensiId;
  String? jamSiang;
  String? long;
  String? lang;
  String? radius;
  String? status;
  String? createdAt;
  String? updatedAt;
  Absensi? absensi;

  Siang1(
      {this.id,
      this.absensiId,
      this.jamSiang,
      this.long,
      this.lang,
      this.radius,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.absensi});

  Siang1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    absensiId = json['absensi_id'];
    jamSiang = json['jam_siang'];
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
    data['jam_siang'] = jamSiang;
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
