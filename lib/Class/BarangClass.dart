import '../ClassService.dart/BarangService.dart';

class Barang {
  String kdbarang;
  String namabarang;
  String idtoko;
  int stok;
  int harga;

  Barang(
      {required this.kdbarang,
      required this.namabarang,
      required this.idtoko,
      required this.stok,
      required this.harga});
  Map<String, dynamic> toMap() {
    return {
      'kdbarang': kdbarang,
      'namabarang': namabarang,
      'idtoko': idtoko,
      'stok': stok,
      'harga': harga
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      kdbarang: map['kdbarang'],
      namabarang: map['namabarang'],
      idtoko: map['idtoko'],
      stok: map['stok'],
      harga: map['harga'],
    );
  }
}
