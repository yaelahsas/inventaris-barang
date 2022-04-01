class ScanData {
  bool? success;
  String? message;
  Data? data;

  ScanData({this.success, this.message, this.data});

  ScanData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? namaStatus;
  Null? createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_divisi'] = this.namaDivisi;
    data['nama_barang'] = this.namaBarang;
    data['spesifikasi'] = this.spesifikasi;
    data['jumlah_barang'] = this.jumlahBarang;
    data['tanggal_masuk'] = this.tanggalMasuk;
    data['id_divisi'] = this.idDivisi;
    data['kode_qrcode'] = this.kodeQrcode;
    data['id_status_barang'] = this.idStatusBarang;
    return data;
  }
}
