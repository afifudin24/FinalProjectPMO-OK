import 'package:cloud_firestore/cloud_firestore.dart';

import '../ClassService.dart/LaporanPemasukanService.dart';

class LaporanPemasukan {
  String idToko;
  String idTransaksi;
  int jumlBarang;
  int totalHarga;
  Timestamp date;

  LaporanPemasukan(
      {required this.idToko,
      required this.idTransaksi,
      required this.jumlBarang,
      required this.totalHarga,
      required this.date});
  Map<String, dynamic> toMap() {
    return {
      'idToko': idToko,
      'idTransaksi': idTransaksi,
      'jumlBarang': jumlBarang,
      'totalHarga': totalHarga,
      'date': date
    };
  }

  factory LaporanPemasukan.fromMap(Map<String, dynamic> map) {
    return LaporanPemasukan(
        idToko: map['idToko'],
        idTransaksi: map['idTransaksi'],
        jumlBarang: map['jumlBarang'],
        totalHarga: map['totalHarga'],
        date: map['date']);
  }
}
