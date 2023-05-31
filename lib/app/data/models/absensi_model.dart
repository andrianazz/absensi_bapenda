import 'package:absensi_bapenda/app/data/models/user_model.dart';

class Absensi {
  int? id;
  int? userId;
  String? tanggal;
  String? createdAt;
  String? updatedAt;
  User? user;

  Absensi(
      {this.id,
      this.userId,
      this.tanggal,
      this.createdAt,
      this.updatedAt,
      this.user});

  Absensi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tanggal = json['tanggal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['tanggal'] = tanggal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}
