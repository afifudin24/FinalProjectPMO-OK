import '../ClassService.dart/MemberService.dart';

class Member {
  String idtoko;
  String idMember;
  String email;
  String nama;
  String alamat;
  String telepon;

  Member({
    required this.idtoko,
    required this.idMember,
    required this.email,
    required this.nama,
    required this.alamat,
    required this.telepon,
  });

  Map<String, dynamic> toMap() {
    return {
      'idtoko': idtoko,
      'idMember': idMember,
      'email': email,
      'nama': nama,
      'alamat': alamat,
      'telepon': telepon,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      idtoko: map['idtoko'],
      idMember: map['idMember'],
      email: map['email'],
      nama: map['nama'],
      alamat: map['alamat'],
      telepon: map['telepon'],
    );
  }
}
