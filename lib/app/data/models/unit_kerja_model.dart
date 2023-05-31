class UnitKerja {
  int? id;
  String? namaUnitKerja;
  String? createdAt;
  String? updatedAt;

  UnitKerja({this.id, this.namaUnitKerja, this.createdAt, this.updatedAt});

  UnitKerja.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaUnitKerja = json['nama_unit_kerja'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_unit_kerja'] = namaUnitKerja;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
