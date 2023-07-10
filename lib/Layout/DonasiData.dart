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
    List<Donasi> donasis =
        await donasicontroller.getItems(currentUser!.uid.toString());
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
        title: Text(
          'Daftar Donasi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: buildView(),
    );
  }

  Widget buildView() {
    return ListView.builder(
      itemCount: _donasi.length,
      itemBuilder: (context, index) {
        Donasi donasi = _donasi[index];
        DateTime tanggal = donasi.tanggal.toDate();
        String waktu = '${tanggal.day}/${tanggal.month}/${tanggal.year}';

        return Column(
          children: [
            ListTile(
              iconColor: Colors.red,
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              title: Text(donasi.namadonatur),
              subtitle: Text(waktu),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(donasi.jumlah.toString()),
                ],
              ),
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
                              Navigator.of(context).pop();
                              donasicontroller
                                  .deleteItem(_id[index])
                                  .then((value) {
                                print("oke");
                              }).catchError((onError) {
                                print(onError);
                              });
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
    setState(() {
      _loadData();
      _loadID();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hapus Donasi Berhasil')),
      );
    });
  }
}
