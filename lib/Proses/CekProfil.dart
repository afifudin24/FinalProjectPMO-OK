import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Layout/LoginPage.dart';
import '../Layout/TransaksiPage.dart';
import '../firebase_options.dart';
import '../main.dart';

class Cek extends StatefulWidget {
  const Cek({super.key});

  @override
  State<Cek> createState() => _CekState();
}

class _CekState extends State<Cek> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('toko')
          .where('email', isEqualTo: currentUser!.email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Data ditemukan dalam koleksi
        Navigator.pushReplacementNamed(context, '/home');

        print('Data ada');
      } else {
        // Tidak ada data dalam koleksi
        Navigator.pushReplacementNamed(context, '/oke');

        print('Data tidak ada');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  var oek = false;
  Future<void> initData() async {
    await fetchUsers();
    print('Proses inisialisasi selesai');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
          child: Container(
            color: Color.fromRGBO(33, 64, 100, 1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: oek ? '/home' : '/transaksi',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => Home(),
          '/cek': (context) => Cek(),
          '/oke': (context) => TransaksiScreen(),
        });
  }
}
