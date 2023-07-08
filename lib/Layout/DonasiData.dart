import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/DonasiClass.dart';
import 'package:kasir_euy/ClassService.dart/DonasiService.dart';
import 'package:kasir_euy/ClassService.dart/TokoService.dart';
import 'package:kasir_euy/main.dart';

import '../Class/TokoClass.dart';

class DonasiData extends StatefulWidget {
  const DonasiData({super.key});

  @override
  State<DonasiData> createState() => _DonasiData();
}

class _DonasiData extends State<DonasiData> {
  DonasiService donasicontroller = DonasiService();
  List<Donasi> _donasi = [];
  List<String> _id = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadID();
    print("OK");
  }

  Future<void> _loadData() async {
    print("lah");
    List<Donasi> donasis = await donasicontroller.getItems(currentUser!.uid.toString());
    setState(() {
      _donasi = donasis;
    });
  }

  Future<void> _loadID() async {
    List<String> documentIds = await donasicontroller.getDocumentIds();
    print('Document IDs: $documentIds');
    setState(() {
      _id = documentIds;
    });
    print(_id);
  }

  int getItemCount() {
    return _donasi.length; // Mengembalikan panjang data sebagai jumlah item
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(33, 64, 100, 1),

        title: Text('Daftar Donasi', style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: buildView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            Donasi newItem = Donasi(
                kdDonasi: '128;;klk3gjh',
                email: 'Itemoojjlk 1hgjh',
         
                idToko: currentUser!.uid,
                jumlah: 0,
                namadonatur: "Afif",
                noTelp: "123");
                 String randomId = FirebaseFirestore.instance.collection('donasi').doc().id;
            donasicontroller.addItem(randomId, newItem);
            print("okbng");
           
          });
           _loadData();
            refreshPage();
        },
      ),
    );
  }

  Widget buildView() {
    return ListView.builder(
      itemCount: _donasi.length,
      itemBuilder: (context, index) {
        Donasi donasi = _donasi[index];

        return Column(
          children: [
            ListTile(iconColor: Colors.red,
            contentPadding: EdgeInsets.only(left : 10, right: 10),
            
              title: Text(donasi.namadonatur),
              subtitle: Text(donasi.jumlah.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah Anda yakin?'),
            actions: <Widget>[
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Hapus'),
                onPressed: () {
                  donasicontroller.deleteItem(_id[index]);
                 
                  refreshPage();
             
                },
              ),
            ],
      );
    },
  );

                  
              
                },
              ),
            ),
              Divider(),
          ],
        );
      },
    );
  }

  void refreshPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DonasiData()),
    );
  }
}
