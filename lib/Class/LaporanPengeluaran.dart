import 'package:cloud_firestore/cloud_firestore.dart';

import '../ClassService.dart/LaporanPengeluaranService.dart';

class LaporanPengeluaran {
  String idPengeluaran;
  String idToko;
  int totalPengeluaran;
  Timestamp date;

  LaporanPengeluaran({
    required this.idPengeluaran,
    required this.idToko,
    required this.totalPengeluaran,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'idPengeluaran': idPengeluaran,
      'idToko': idToko,
      'totalPengeluaran': totalPengeluaran,
      'date': date
    };
  }

  factory LaporanPengeluaran.fromMap(Map<String, dynamic> map) {
    return LaporanPengeluaran(
        idPengeluaran: map['idPengeluaran'],
        idToko: map['idToko'],
        totalPengeluaran: map['totalPengeluaran'],
        date: map['date']);
  }
}
