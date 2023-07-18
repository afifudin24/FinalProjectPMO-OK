import 'package:cloud_firestore/cloud_firestore.dart';

import '../ClassService.dart/PenyaluranDonasiService.dart';

class PenyaluranDonasiClass {
  String idtoko;
  String kdsalur;
  String tujuan;
  Timestamp tanggal;
  int jumlah;
  String urlImage;

  PenyaluranDonasiClass({
    required this.idtoko,
    required this.kdsalur,
    required this.tujuan,
    required this.tanggal,
    required this.jumlah,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'idtoko': idtoko,
      'kdsalur': kdsalur,
      'tujuan': tujuan,
      'tanggal': tanggal,
      'jumlah': jumlah,
      'urlImage': urlImage
    };
  }

  factory PenyaluranDonasiClass.fromMap(Map<String, dynamic> map) {
    return PenyaluranDonasiClass(
      idtoko: map['idtoko'],
      kdsalur: map['kdsalur'],
      tujuan: map['tujuan'],
      tanggal: map['tanggal'],
      jumlah: map['jumlah'],
      urlImage: map['urlImage'],
    );
  }
}
