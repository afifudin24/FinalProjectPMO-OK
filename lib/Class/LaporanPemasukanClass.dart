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
      'id transaksi': idTransaksi,
      'juml barang': jumlBarang,
      'total harga': totalHarga,
      'date': date
    };
  }

  factory LaporanPemasukan.fromMap(Map<String, dynamic> map) {
    return LaporanPemasukan(
        idTransaksi: map['id transaksi'],
        jumlBarang: map['juml harga'],
        totalHarga: map['total harga'],
        date: map['date']);
  }
}
