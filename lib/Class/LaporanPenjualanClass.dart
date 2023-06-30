import '../ClassService.dart/LaporanPemasukanService.dart';

class LaporanPenjualan {
  String idJual;
  String kdBarang;
  String namaBarang;
  int totalJual;
  DateTime date;

  LaporanPenjualan({
    required this.idJual,
    required this.kdBarang,
    required this.namaBarang,
    required this.totalJual,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'idJual': idJual,
      'kdBarang': kdBarang,
      'namaBarang': namaBarang,
      'totalJual': totalJual,
      'date': date
    };
  }

  factory LaporanPenjualan.fromMap(Map<String, dynamic> map) {
    return LaporanPenjualan(
        idJual: map['idJual'],
        kdBarang: map['kdBarang'],
        namaBarang: map['namaBarang'],
        totalJual: map['totalJual'],
        date: map['date']);
  }
}
