import '../ClassService.dart/DonasiService.dart';

class Donasi {
  String namadonatur;
  String email;
  String noTelp;
  int jumlah;

  Donasi(
      {required this.namadonatur,
      required this.email,
      required this.noTelp,
      required this.jumlah});
  Map<String, dynamic> toMap() {
    return {
      'namadonatur': namadonatur,
      'email': email,
      'notelp': noTelp,
      'jumlah': jumlah
    };
  }

  factory Donasi.fromMap(Map<String, dynamic> map) {
    return Donasi(
      namadonatur: map['namadonatur'],
      email: map['email'],
      noTelp: map['notelp'],
      jumlah: map['jumlah'],
    );
  }
}
