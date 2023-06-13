import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/HomeScreen.dart';
import 'package:kasir_euy/Layout/Registerpage.dart';
import 'Layout/LoginPage.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
          nextScreen:
              HomePage(), // Ganti dengan widget berikutnya setelah splash screen selesai
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color.fromRGBO(33, 64, 100, 1),
          duration: 3000, // Durasi tampilan splash screen dalam milidetik,
        ));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Halaman Home"),
      ),
    );
  }
}
