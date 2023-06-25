import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/FormInfoPage.dart';
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
        home: AnimatedSplashScreen(
          splashIconSize: MediaQuery.of(context).size.height,
          splash: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/logo.png",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "KASIR-EUY",
                      style: GoogleFonts.montserrat(
                          fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Ganti dengan path gambar splash screen Anda

          // Ganti dengan widget berikutnya setelah splash screen selesai
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color.fromRGBO(33, 64, 100, 1),
          duration: 3000,
          nextScreen: Home(), // Durasi tampilan splash screen dalam milidetik,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: oek ? '/home' : '/transaksi',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => Home(),
          '/cek': (context) => Cek(),
          '/oke': (context) => FormInfo(),
        });
  }
}
