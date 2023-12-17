// To parse this JSON data, do
//
//     final dataAbsenModel = dataAbsenModelFromJson(jsonString);

import 'dart:convert';

DataAbsenModel dataAbsenModelFromJson(String str) =>
    DataAbsenModel.fromJson(json.decode(str));

String dataAbsenModelToJson(DataAbsenModel data) => json.encode(data.toJson());

class DataAbsenModel {
  final String? status;
  final Absen? absentoday;
  final List<Absen>? absenbefore;
  final String? message;

  DataAbsenModel({
    this.status,
    this.absentoday,
    this.absenbefore,
    this.message,
  });

  factory DataAbsenModel.fromJson(Map<String, dynamic> json) => DataAbsenModel(
        status: json["status"] ?? "",
        absentoday: Absen.fromJson(json["absentoday"]),
        absenbefore:
            List<Absen>.from(json["absenbefore"].map((x) => Absen.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "absentoday": absentoday!.toJson(),
        "absenbefore": List<dynamic>.from(absenbefore!.map((x) => x.toJson())),
        "message": message,
      };
}

class Absen {
  final String? tanggal;
  final String? jamMasuk;
  final String? jamSiang;
  final String? jamSiang2;
  final String? jamPulang;

  Absen({
    this.tanggal,
    this.jamMasuk,
    this.jamSiang,
    this.jamSiang2,
    this.jamPulang,
  });

  factory Absen.fromJson(Map<String, dynamic> json) => Absen(
        tanggal: json["tanggal"],
        jamMasuk: json["jam_masuk"],
        jamSiang: json["jam_siang"],
        jamSiang2: json["jam_siang2"],
        jamPulang: json["jam_pulang"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "jam_masuk": jamMasuk,
        "jam_siang": jamSiang,
        "jam_siang2": jamSiang2,
        "jam_pulang": jamPulang,
      };
}
