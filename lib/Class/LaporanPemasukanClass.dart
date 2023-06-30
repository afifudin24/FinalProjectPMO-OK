import '../ClassService.dart/LaporanPemasukanService.dart';

class LaporanPemasukan {
  String idTransaksi;
  String jumlBarang;
  String totalHarga;
  DateTime date;

  LaporanPemasukan(
      {required this.idTransaksi,
      required this.jumlBarang,
      required this.totalHarga,
      required this.date});
  Map<String, dynamic> toMap() {
    return {
      'idTransaksi': idTransaksi,
      'jumlBarang': jumlBarang,
      'totalHarga': totalHarga,
      'date': date
    };
  }

  factory LaporanPemasukan.fromMap(Map<String, dynamic> map) {
    return LaporanPemasukan(
        idTransaksi: map['idTransaksi'],
        jumlBarang: map['jumlHarga'],
        totalHarga: map['totalHarga'],
        date: map['date']);
  }
}
