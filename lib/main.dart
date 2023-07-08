import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/Registerpage.dart';
import 'Layout/komposisi.dart';
import 'package:kasir_euy/Layout/FormInfoPage.dart';
import 'package:kasir_euy/Layout/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Layout/LoginPage.dart';
import 'firebase_options.dart';
import 'Proses/CekProfil.dart';
import 'Layout/Pageview.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
User? currentUser = _auth.currentUser as User?;
FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> saveLoginStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

Future<void> fetchUsers() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('toko')
        // .where('email', isEqualTo: currentUser!.email)
        .where('idtoko', isEqualTo: "123")
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      // Data ditemukan dalam koleksi

      print("ok");
    } else if (querySnapshot.docs.isNotEmpty) {
      print("ok");
    } else if (querySnapshot.docs.isEmpty) {
      print("ok");
    } else if (querySnapshot.docs.isEmpty) {
      // Tidak ada data dalam koleksi
      print("oke");
    }
  } catch (e) {
    print('Error: $e');
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool isLoggedIn = await checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
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
        nextScreen: Tentukan(
          isLoggedIn: isLoggedIn,
        ), // Ganti dengan widget berikutnya setelah splash screen selesai
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color.fromRGBO(33, 64, 100, 1),
        duration: 3000, // Durasi tampilan splash screen dalam milidetik,
      ));
    // );
  }
}

// var lokasi;

// class Tentukan extends StatefulWidget {
//   final bool isLoggedIn;
//   Tentukan({required this.isLoggedIn});
//   void initState() {
//     fetchUsers();
//   }

//   void fetchUsers() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
//           .collection('toko')
//           .where('email', isEqualTo: currentUser!.email)
//           .get();
//       if (isLoggedIn == true && querySnapshot.docs.isNotEmpty) {
//         // Data ditemukan dalam koleksi

//         lokasi = '/home';

//         print("ok");
//       } else if (isLoggedIn == false && querySnapshot.docs.isNotEmpty) {
//         lokasi = '/home';

//         print("ok");
//       } else if (isLoggedIn == true && querySnapshot.docs.isEmpty) {
//         lokasi = '/oke';
//         print("ok");
//       } else if (isLoggedIn == false && querySnapshot.docs.isEmpty) {
//         // Tidak ada data dalam koleksi
//         lokasi = '/login';
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   State<Tentukan> createState() => _TentukanState();
// }

// class _TentukanState extends State<Tentukan> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Kasir Euy",
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: lokasi,
//       // isLoggedIn && isInfo? '/cek' : '/login',
//       routes: {
//         '/login': (context) => LoginPage(),
//         '/home': (context) => Home(),
//         '/cek': (context) => Cek(),
//         '/oke': (context) => TransaksiScreen(),
//         // '/tunggu': (context) => Tunggu(),
//       },
//     );
//   }
// }

class Tentukan extends StatelessWidget {
  final bool isLoggedIn;

  const Tentukan({required this.isLoggedIn});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kasir Euy",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/cek': (context) => Cek(),
        '/oke': (context) => FormInfo(),
        // '/tunggu': (context) => Tunggu(),
      },
    );
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
