import 'package:flutter/material.dart';

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
                             // Proses donasi
                          print('Donatur: $donorName');
                          print('Email: $email');
                          print('Nomor Telepon: $phoneNumber');
                          print('Jumlah Donasi: $donationAmount');

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


