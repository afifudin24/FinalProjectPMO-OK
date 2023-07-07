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

class DonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Donasi',
      debugShowCheckedModeBanner: false,
      home: DonationScreen(),
    );
  }
}

class DonationScreen extends StatefulWidget {
  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  String donorName = '';
  String email = '';
  String phoneNumber = '';
  double donationAmount = 0.0;
  TextEditingController namadonatur = TextEditingController();
  TextEditingController emailoke = TextEditingController();
  TextEditingController notelpon = TextEditingController();
  TextEditingController jumlah = TextEditingController();
   DonasiService donasicontroller = DonasiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Halaman Donasi', style: TextStyle(
          color: Color.fromRGBO(33, 64, 100, 1),
        ),),
        backgroundColor: Colors.white,
        
      ),
      body: Container(
        color: Color.fromRGBO(33, 64, 100, 1),
        child: Center(
         
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 600,
            margin: EdgeInsets.all(20),
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white
            ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
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
                    SizedBox(height: 16.0),
                    Text(
                      '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
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
                    SizedBox(height: 16.0),
                    Text(
                      '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
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
                    SizedBox(height: 16.0),
                    Text(
                      '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
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
                    SizedBox(height: 50.0),
                    Center(
                      child: ElevatedButton(
                        
                        onPressed: () {
                              setState(() {
                String randomId = FirebaseFirestore.instance.collection('donasi').doc().id;
            Donasi newItem = Donasi(
                kdDonasi: randomId,
                email: emailoke.text,
         
                idToko: "dafa",
                jumlah: int.parse(jumlah.text),
                namadonatur: namadonatur.text,
                noTelp: notelpon.text);
            donasicontroller.addItem(randomId, newItem).then((value) {
              showDialog(context: context, builder: (BuildContext context) { 
                return AlertDialog(
                  title: Text('Berhasil'),
                  content: Text("Data telah ditambahkan"),
                );
               }, );
             Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HomePage()),
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



