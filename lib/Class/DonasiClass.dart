import 'package:cloud_firestore/cloud_firestore.dart';

import '../ClassService.dart/DonasiService.dart';

class Donasi {
  String kdDonasi;
  String idToko;
  String namadonatur;
  String email;
  String noTelp;
  int jumlah;
  Timestamp tanggal;

  Donasi(
      {required this.kdDonasi,
      required this.idToko,
      required this.namadonatur,
      required this.email,
      required this.noTelp,
      required this.jumlah,
      required this.tanggal});
  Map<String, dynamic> toMap() {
    return {
      'kdDonasi': kdDonasi,
      'idToko': idToko,
      'namadonatur': namadonatur,
      'email': email,
      'notelp': noTelp,
      'jumlah': jumlah,
      'tanggal': tanggal
    };
  }

  factory Donasi.fromMap(Map<String, dynamic> map) {
    return Donasi(
      kdDonasi: map['kdDonasi'],
      idToko: map['idToko'],
      namadonatur: map['namadonatur'],
      email: map['email'],
      noTelp: map['notelp'],
      jumlah: map['jumlah'],
      tanggal: map['tanggal'],
    );
  }
}
