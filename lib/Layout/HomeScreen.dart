import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/MenuLayout.dart';
import 'package:kasir_euy/Layout/ProfilPage.dart';
import '../Class/TokoClass.dart';
import '../ClassService.dart/TokoService.dart';
import 'DashboardPage.dart';
import 'package:image_picker/image_picker.dart';
import 'TransaksiPage.dart';
import '../main.dart';
import 'komposisi.dart';

var warna = Color.fromRGBO(33, 64, 100, 1);
List menu = [DashboardScreen(), TransaksiScreen(), KasirMenuPage(), Profil()];
List visibilitasLeading = [false, false, false, true];
List title = ["Selamat Datang, ", "Transaksi", "Menu", "Profil"];
var namatoko = "";
var urlImage = " ";

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final int laman;
  final Function? MyFunction;
  // ignore: non_constant_identifier_names
  HomePage({super.key, this.laman = 0, this.MyFunction});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedNavbar;
  final TextEditingController conNama = TextEditingController();
  final TextEditingController conEmail = TextEditingController();
  final TextEditingController conMotto = TextEditingController();
  final TextEditingController conNamaToko = TextEditingController();
  final TextEditingController conAlamat = TextEditingController();
  TokoService tokoController = TokoService();
  List<Toko> toko = [];
  var image;
  File? _imageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path as String);
        image = pickedImage.path;
      });
      print(_imageFile);
    }
  }

  void initState() {
    super.initState();
    _selectedNavbar = widget.laman;
    initData();
    _getUser();
  }

  var nama = "";
  final _formKey = GlobalKey<FormState>();
  // int _selectedNavbar = _variableName;
  var visRumah = false;
  var visLengkap = false;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
      print(_selectedNavbar);
    });
  }

  @override
  void dispose() {
    conNama.dispose();
    conEmail.dispose();
    conMotto.dispose();
    conNamaToko.dispose();
    super.dispose();
  }

  //   Future<void> _simpan() async {
  //   List<Toko> tokoIni = await tokoController.getDataItems(currentUser!.uid.toString());
  //   setState(() {
  //     toko = tokoIni;
  //     var admin = toko[0].adminToko;
  //     title[0] = "Selamat datang, $admin";
  //     namatoko = toko[0].namatoko;
  //     print(toko[0].adminToko);
  //     print(namatoko);
  //   });
  // }

  Future<void> _getUser() async {
    List<Toko> tokoIni =
        await tokoController.getDataItems(currentUser!.uid.toString());
    setState(() {
      toko = tokoIni;
      var admin = toko[0].adminToko;
      title[0] = "Selamat datang, $admin";
      namatoko = toko[0].namatoko;
      urlImage = toko[0].urlImage;
      print(toko[0].adminToko);
      print(namatoko);
    });
  }

  Future<void> fetchUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('toko')
          .where('idtoko', isEqualTo: currentUser!.uid.toString())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Data ditemukan dalam koleksi
        // Navigator.pushReplacementNamed(context, '/home');
        setState(() {
          visRumah = true;
          visLengkap = false;
        });

        print('Data ada');
      } else {
        // Tidak ada data dalam koleksi
        // Navigator.pushReplacementNamed(context, '/oke');
        setState(() {
          visLengkap = true;
          visRumah = false;
        });
        print('Data tidak ada');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> initData() async {
    await fetchUsers();
    print('Proses inisialisasi selesai');
  }

  Widget build(BuildContext context) {
    return _rumah();
  }

  Widget _rumah() {
    if (widget.MyFunction != null) {
      setState(() {
        widget.MyFunction!();
      });
    }
    return Scaffold(
        body: Container(
      color: warna,
      child: Stack(
        children: [
          Visibility(
            visible: visLengkap,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Lengkapi Data Toko Anda",
                            style: GoogleFonts.chicle(
                                fontSize: 24, color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.all(30),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: conNama,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        contentPadding: EdgeInsets.all(10),
                                        label: Text("Nama Admin")),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama admin harus diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: conEmail,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        contentPadding: EdgeInsets.all(10),
                                        label: Text("Email")),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email harus diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: conNamaToko,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        contentPadding: EdgeInsets.all(10),
                                        label: Text("Nama Toko")),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama toko harus diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: conMotto,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        contentPadding: EdgeInsets.all(10),
                                        label: Text("Motto Toko")),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Motto toko harus diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: conAlamat,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        contentPadding: EdgeInsets.all(10),
                                        label: Text("Alamat Toko")),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Motto toko harus diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsetsDirectional.all(12)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.orange)),
                                      onPressed: () {
                                        _pickImage();
                                      },
                                      child: Text("Pilih Gambar")),
                                  _imageFile != null
                                      ? Image.file(_imageFile!, height: 150.0)
                                      : Visibility(
                                          visible: false,
                                          child: Placeholder(
                                              fallbackHeight: 150.0)),
                                  SizedBox(height: 16.0),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsetsDirectional.all(12)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.orange)),
                              onPressed: () {
                                Toko data = Toko(
                                    idtoko: currentUser!.uid.toString(),
                                    email: conEmail.text,
                                    namatoko: conNamaToko.text,
                                    mottotoko: conMotto.text,
                                    adminToko: conNama.text,
                                    alamat: conAlamat.text,
                                    urlImage: image,
                                    saldo: 0);
                                tokoController.addItem(data);
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              child: Text("Simpan")),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: visRumah,
            child: Scaffold(
              appBar: AppBar(
                clipBehavior: Clip.antiAlias,
                toolbarHeight: 60,
                bottomOpacity: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                title: Text(
                  title[_selectedNavbar],
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primaryColor),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: Colors.white),
                ),
                centerTitle: true,
                actions: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Visibility(
                            visible: visibilitasLeading[_selectedNavbar],
                            child: IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibilitasLeading[_selectedNavbar],
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Tombol Edit ditekan
                      },
                    ),
                  ),
                  Visibility(
                    visible: visibilitasLeading[_selectedNavbar],
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Tombol Log Out ditekan
                      },
                    ),
                  ),
                ],
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: menu[_selectedNavbar],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Dashboard"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.computer), label: "Transaksi"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Menu"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business), label: "Profil"),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedNavbar,
                selectedItemColor: primaryColor,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                onTap: _changeSelectedNavBar,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
