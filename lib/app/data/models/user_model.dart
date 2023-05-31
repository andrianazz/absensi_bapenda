import 'package:absensi_bapenda/app/data/models/unit_kerja_model.dart';

class User {
  int? id;
  String? nik;
  String? nama;
  String? tempatLahir;
  String? tanggalLahir;
  String? jenisKelamin;
  String? pendidikan;
  String? agama;
  String? alamat;
  int? unitKerjaId;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  UnitKerja? unitKerja;

  User(
      {this.id,
      this.nik,
      this.nama,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.pendidikan,
      this.agama,
      this.alamat,
      this.unitKerjaId,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      this.unitKerja});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    nama = json['nama'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    jenisKelamin = json['jenis_kelamin'];
    pendidikan = json['pendidikan'];
    agama = json['agama'];
    alamat = json['alamat'];
    unitKerjaId = json['unit_kerja_id'];
    imageUrl = json['imageUrl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unitKerja = json['unit_kerja'] != null
        ? UnitKerja?.fromJson(json['unit_kerja'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nik'] = nik;
    data['nama'] = nama;
    data['tempat_lahir'] = tempatLahir;
    data['tanggal_lahir'] = tanggalLahir;
    data['jenis_kelamin'] = jenisKelamin;
    data['pendidikan'] = pendidikan;
    data['agama'] = agama;
    data['alamat'] = alamat;
    data['unit_kerja_id'] = unitKerjaId;
    data['imageUrl'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (unitKerja != null) {
      data['unit_kerja'] = unitKerja?.toJson();
    }
    return data;
  }
}
