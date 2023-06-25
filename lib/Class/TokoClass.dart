import '../ClassService.dart/TokoService.dart';

class Toko {
  String idtoko;
  String email;
  String namatoko;
  String mottotoko;
  int status;
  String adminToko;
  String urlImage;

  Toko(
      {required this.idtoko,
      required this.email,
      required this.namatoko,
      required this.mottotoko,
      required this.status,
      required this.adminToko,
      required this.urlImage});
  Map<String, dynamic> toMap() {
    return {
      'idtoko': idtoko,
      'email': email,
      'namatoko': namatoko,
      'mottotoko': mottotoko,
      'status': status.toDouble(),
      'adminToko': adminToko,
      'urlImage': urlImage
    };
  }

  factory Toko.fromMap(Map<String, dynamic> map) {
    return Toko(
      idtoko: map['idtoko'],
      email: map['email'],
      namatoko: map['namatoko'],
      mottotoko: map['mottotoko'],
      status: map['status'].toDouble(),
      adminToko: map['adminToko'],
      urlImage: map['urlImage'],
    );
  }
}
