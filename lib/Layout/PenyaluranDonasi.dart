import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_euy/Class/PenyaluranDonasiClass.dart';
import 'package:kasir_euy/ClassService.dart/PenyaluranDonasiService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasir_euy/Layout/HomeScreen.dart';
import 'package:kasir_euy/Layout/MenuLayout.dart';
import 'package:kasir_euy/Layout/PenyaluranDonasiData.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import 'package:kasir_euy/main.dart';

class PenyaluranDonasi extends StatefulWidget {
  @override
  State<PenyaluranDonasi> createState() => _PenyaluranDonasiState();
}

class _PenyaluranDonasiState extends State<PenyaluranDonasi> {
  TextEditingController _jumlahController = TextEditingController();
  TextEditingController _tujuanController = TextEditingController();
  // TextEditingController _tanggalController = TextEditingController();
  PenyaluranDonasiService salur = PenyaluranDonasiService();
  String outputMessage = ''; // Variabel untuk menyimpan pesan output
  File? imageFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        centerTitle: true,
        title: Text(
          'Penyaluran Donasi',
          style: TextStyle(
            color: Color.fromRGBO(33, 64, 100, 1),
          ),
        ),
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
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _tujuanController,
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Tujuan',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _jumlahController,
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Jumlah',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(
                          Icons.cloud_upload,
                          color: primaryColor,
                        ),
                        label: Text('Upload Foto'),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: double.infinity,
                    child: imageFile != null
                        ? Image.file(
                            imageFile!,
                            height: 200.0,
                            width: 200.0,
                          )
                        : Image.asset(
                            'assets/image/transaksi.png',
                            height: 200.0,
                            width: 200.0,
                          ),
                  ),
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Proses donasi
                          String tujuan = _tujuanController.text;

                          int jumlah = int.parse(_jumlahController.text);
                          DateTime now = DateTime.now();
                          Timestamp timestamp = Timestamp.fromDate(now);
                            String randomId =
            FirebaseFirestore.instance.collection('penyalurandonasi').doc().id;
                          PenyaluranDonasiClass donasi = PenyaluranDonasiClass(
                            idtoko: currentUser!.uid.toString(),
                            jumlah: jumlah,
                            tujuan: tujuan,
                            tanggal: timestamp,
                            urlImage: imageFile != null ? imageFile!.path : '', kdsalur: randomId,
                          );

                          salur.addItem(donasi).then((result) {
                            print("oke");
                            // Mengatur pesan output
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Penyaluran donasi dengan jumlah $jumlah telah berhasil')),
                            );
                            _jumlahController.clear();
                            _tujuanController.clear();
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PenyaluranDonasiData(),
                              ),
                            );
                          }).catchError((error) {
                            // Mengatur pesan output jika terjadi error
                            setState(() {
                              outputMessage =
                                  'Terjadi kesalahan saat menyimpan donasi: $error';
                            });
                          });
                        },
                        child: Text('Salurkan'),
                        style: ElevatedButton.styleFrom(
                          primary: secondaryColor,
                          textStyle: TextStyle(
                            fontSize: 16.0,
                          ),
                          minimumSize: Size(150.0, 50.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}