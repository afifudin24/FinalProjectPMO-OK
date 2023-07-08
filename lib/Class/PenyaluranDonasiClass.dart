import '../ClassService.dart/PenyaluranDonasiService.dart';

class PenyaluranDonasiClass {
  String tujuan;
  String tanggal;
  int jumlah;
  String urlImage;


  PenyaluranDonasiClass({
    required this.tujuan,
    required this.tanggal,
    required this.jumlah,
    required this.urlImage,
   });

  Map<String, dynamic> toMap() {
    return {
      'tujuan': tujuan,
      'tanggal': tanggal,
      'jumlah': jumlah,
      'urlImage': urlImage

    };
  }

  factory PenyaluranDonasiClass.fromMap(Map<String, dynamic> map) {
    return PenyaluranDonasiClass(
      tujuan: map['tujuan'],
      tanggal: map['tanggal'],
      jumlah: map['jumlah'],
      urlImage: map['urlImage'],

    );
  }
}
