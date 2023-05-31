import 'package:absensi_bapenda/app/data/models/absensi_model.dart';

class Masuk {
  int? id;
  int? absensiId;
  String? jamMasuk;
  String? long;
  String? lang;
  String? radius;
  String? status;
  String? createdAt;
  String? updatedAt;
  Absensi? absensi;

  Masuk(
      {this.id,
      this.absensiId,
      this.jamMasuk,
      this.long,
      this.lang,
      this.radius,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.absensi});

  Masuk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    absensiId = json['absensi_id'];
    jamMasuk = json['jam_masuk'];
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
    data['jam_masuk'] = jamMasuk;
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
