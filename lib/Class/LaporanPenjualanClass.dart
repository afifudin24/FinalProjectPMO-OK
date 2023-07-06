import 'package:cloud_firestore/cloud_firestore.dart';

import '../ClassService.dart/LaporanPemasukanService.dart';

class LaporanPenjualan {
  String idJual;
  String kdbarang;
  String namaBarang;
  String idToko;
  int totalJual;
  Timestamp date;

  LaporanPenjualan({
    required this.idJual,
    required this.kdbarang,
    required this.namaBarang,
    required this.idToko,
    required this.totalJual,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'idJual': idJual,
      'kdbarang': kdbarang,
      'namaBarang': namaBarang,
      'idToko': idToko,
      'totalJual': totalJual,
      'date': date
    };
  }

  factory LaporanPenjualan.fromMap(Map<String, dynamic> map) {
    return LaporanPenjualan(
        idJual: map['idJual'],
        kdbarang: map['kdbarang'],
        namaBarang: map['namaBarang'],
        idToko: map['idToko'],
        totalJual: map['totalJual'],
        date: map['date']);
  }
}
