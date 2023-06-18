import '../ClassService.dart/BarangService.dart';

class Barang {
  String kdbarang;
  String namabarang;
  int stok;
  int harga;

  Barang(
      {required this.kdbarang,
      required this.namabarang,
      required this.stok,
      required this.harga});
  Map<String, dynamic> toMap() {
    return {
      'kdbarang': kdbarang,
      'namabarang': namabarang,
      'stok': stok,
      'harga': harga
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      kdbarang: map['kdbarang'],
      namabarang: map['namabarang'],
      stok: map['stok'],
      harga: map['harga'],
    );
  }
}
