import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kasir_euy/Layout/HomeScreen.dart';
import 'package:kasir_euy/Layout/MenuLayout.dart';
import 'package:kasir_euy/main.dart';

import '../Class/DonasiClass.dart';
import '../ClassService.dart/DonasiService.dart';

void main() {
  runApp(DonationApp());
}

class DonationApp extends StatefulWidget {
  final int? jumlah;
  DonationApp({super.key, this.jumlah});
  @override
  _DonationAppState createState() => _DonationAppState();
}

class _DonationAppState extends State<DonationApp> {
  String donorName = '';
  String email = '';
  String phoneNumber = '';
  double donationAmount = 0.0;
  TextEditingController namadonatur = TextEditingController();
  TextEditingController emailoke = TextEditingController();
  TextEditingController notelpon = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  DonasiService donasicontroller = DonasiService();
  void initState() {
    super.initState();
    jumlah.text = widget.jumlah.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Halaman Donasi',
          style: TextStyle(
            color: Color.fromRGBO(33, 64, 100, 1),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(33, 64, 100, 1),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 500,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      donorName = value;
                    });
                  },
                  controller: namadonatur,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text('Nama Donatur'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  controller: emailoke,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                  controller: notelpon,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text('Nomor Telepon'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      donationAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                  controller: jumlah,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    label: Text('Jumlah'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        DateTime now = DateTime.now();
                        Timestamp timestamp = Timestamp.fromDate(now);
                        String randomId = FirebaseFirestore.instance
                            .collection('donasi')
                            .doc()
                            .id;
                        Donasi newItem = Donasi(
                          kdDonasi: randomId,
                          email: emailoke.text,
                          idToko: currentUser!.uid.toString(),
                          jumlah: int.parse(jumlah.text),
                          namadonatur: namadonatur.text,
                          noTelp: notelpon.text,
                          tanggal: timestamp,
                        );
                        donasicontroller
                            .addItem(randomId, newItem)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      laman: 1,
                                    )),
                            (Route<dynamic> route) => false,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Berhasil'),
                                content: Text("Donasi Berhasil"),
                              );
                            },
                          );
                        }).catchError((error) {
                          print(error);
                        });
                        print("okbng");
                      });
                    },
                    child: Text('Donasi'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      textStyle: TextStyle(
                        fontSize: 16.0, // Ukuran font teks tombol
                      ),
                      minimumSize: Size(150.0, 50.0), // Ukuran minimal tombol
                    ),
                    // Warna latar belakang tombol
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
