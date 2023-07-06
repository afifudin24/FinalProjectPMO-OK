import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/DonasiClass.dart';

import '../ClassService.dart/DonasiService.dart';

class PenyaluranDonasi extends StatefulWidget {
  @override
  State<PenyaluranDonasi> createState() => _PenyaluranDonasiState();
}

class _PenyaluranDonasiState extends State<PenyaluranDonasi> {
  String tujuan = '';
  String tanggal = '';
  double donationAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        tujuan = value;
                      });
                    },
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Tujuan',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        tanggal = value;
                      });
                    },
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Tanggal',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        donationAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Jumlah',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextButton.icon(
                  onPressed: () {
                    print('Upload foto');
                  },
                  icon: Icon(Icons.cloud_upload),
                  label: Text('Upload Foto'),
                ),
                SizedBox(height: 5.0),
                Image.asset(
                  'assets/image/transaksi.png', // Path ke gambar
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //Proses donasi
                        print('Tujuan: $tujuan');
                        print('Tanggal: $tanggal');
                        print('Jumlah Donasi: $donationAmount');
                      },
                      child: Text('Salurkan'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: TextStyle(
                          fontSize: 16.0, // Ukuran font teks tombol
                        ),
                        minimumSize: Size(150.0, 50.0), // Ukuran minimal tombol
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}