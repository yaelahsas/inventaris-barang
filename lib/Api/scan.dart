class ScanData {
  bool? success;
  String? message;
  Data? data;

  ScanData({this.success, this.message, this.data});

  ScanData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? namaDivisi;
  String? namaBarang;
  String? spesifikasi;
  String? jumlahBarang;
  String? tanggalMasuk;
  int? idDivisi;
  String? kodeQrcode;
  int? idStatusBarang;

  Data(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.namaDivisi,
      this.namaBarang,
      this.spesifikasi,
      this.jumlahBarang,
      this.tanggalMasuk,
      this.idDivisi,
      this.kodeQrcode,
      this.idStatusBarang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaDivisi = json['nama_divisi'];
    namaBarang = json['nama_barang'];
    spesifikasi = json['spesifikasi'];
    jumlahBarang = json['jumlah_barang'];
    tanggalMasuk = json['tanggal_masuk'];
    idDivisi = json['id_divisi'];
    kodeQrcode = json['kode_qrcode'];
    idStatusBarang = json['id_status_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_status'] = namaStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nama_divisi'] = namaDivisi;
    data['nama_barang'] = namaBarang;
    data['spesifikasi'] = spesifikasi;
    data['jumlah_barang'] = jumlahBarang;
    data['tanggal_masuk'] = tanggalMasuk;
    data['id_divisi'] = idDivisi;
    data['kode_qrcode'] = kodeQrcode;
    data['id_status_barang'] = idStatusBarang;
    return data;
  }
}
