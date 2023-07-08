import '../ClassService.dart/TokoService.dart';

class Toko {
  String idtoko;
  String email;
  String namatoko;
  String mottotoko;
  String adminToko;
  String urlImage;
  String alamat;

  Toko(
      {required this.idtoko,
      required this.email,
      required this.namatoko,
      required this.mottotoko,
      required this.adminToko,
      required this.alamat,
      required this.urlImage});
  Map<String, dynamic> toMap() {
    return {
      'idtoko': idtoko,
      'email': email,
      'namatoko': namatoko,
      'mottotoko': mottotoko,
      'adminToko': adminToko,
      'urlImage': urlImage,
      'alamat': alamat,
    };
  }

  factory Toko.fromMap(Map<String, dynamic> map) {
    return Toko(
      idtoko: map['idtoko'],
      email: map['email'],
      namatoko: map['namatoko'],
      mottotoko: map['mottotoko'],
      adminToko: map['adminToko'],
      urlImage: map['urlImage'],
      alamat: map['alamat'],
    );
  }
}
