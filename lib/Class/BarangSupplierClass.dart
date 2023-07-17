import '../ClassService.dart/BarangSupplierService.dart';

class BarangSupplier {
  String kodebarang;
  String namabarang;
  String idtoko;
  int hargabarang;

  BarangSupplier({
    required this.kodebarang,
    required this.namabarang,
    required this.idtoko,
    required this.hargabarang,
  });
  Map<String, dynamic> toMap() {
    return {
      'kodebarang': kodebarang,
      'namabarang': namabarang,
      'idtoko': idtoko,
      'hargabarang': hargabarang,
    };
  }

  factory BarangSupplier.fromMap(Map<String, dynamic> map) {
    return BarangSupplier(
      kodebarang: map['kodebarang'],
      namabarang: map['namabarang'],
      idtoko: map['idtoko'],
      hargabarang: map['hargabarang'],
    );
  }
}
