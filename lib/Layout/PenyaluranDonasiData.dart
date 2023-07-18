import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/PenyaluranDonasiClass.dart';
import 'package:kasir_euy/ClassService.dart/PenyaluranDonasiService.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import 'package:kasir_euy/main.dart';

import 'PenyaluranDonasi.dart';

class PenyaluranDonasiData extends StatefulWidget {
  const PenyaluranDonasiData({super.key});

  @override
  State<PenyaluranDonasiData> createState() => _PenyaluranDonasiDataState();
}

class _PenyaluranDonasiDataState extends State<PenyaluranDonasiData> {
  PenyaluranDonasiService penyaluranDonasiController =
      PenyaluranDonasiService();
  List<PenyaluranDonasiClass> _donasi = [];
  List<String> _id = [];

  @override
  void initState() {
    super.initState();
    _loadData();

    print("OK");
  }

  Future<void> _loadData() async {
    List<PenyaluranDonasiClass> donasis = await penyaluranDonasiController
        .getDataItems(currentUser!.uid.toString());
    setState(() {
      _donasi = donasis;
    });
  }

  Future<void> _getData(String kd) async {
    List<PenyaluranDonasiClass> donasis =
        await penyaluranDonasiController.getPilihItems(kd);
    setState(() {
      _donasi = donasis;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Bukti Penyaluran")),
          content: Container(
            padding: EdgeInsets.all(5),
            height: 250,
            width: 250,
            child: Center(
              child: Image.file(File(donasis[0].urlImage)),
            ),
          ),
          actions: [
            TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                label: Text("Tutup"))
          ],
        );
      },
    );
  }

  Future<void> _loadID() async {
    List<String> documentIds =
        await penyaluranDonasiController.getDocumentIds();
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
          'Daftar Penyaluran Donasi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: () {
        if (_donasi.length > 0) {
          return buildView();
        } else {
          return Center(
            child: Text("Belum ada data"),
          );
        }
      }(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PenyaluranDonasi()),
            );
          }),
    );
  }

  Widget buildView() {
    return ListView.builder(
      itemCount: _donasi.length,
      itemBuilder: (context, index) {
        PenyaluranDonasiClass donasi = _donasi[index];
        DateTime tanggal = donasi.tanggal.toDate();
        String waktu = '${tanggal.day}/${tanggal.month}/${tanggal.year}';
        return Column(
          children: [
            ListTile(
              iconColor: Colors.red,
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              title: Text(donasi.tujuan),
              subtitle: Text(waktu),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(donasi.jumlah.toString()),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        _getData(donasi.kdsalur);
                      },
                      icon: Icon(Icons.visibility)),
                  IconButton(
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
                                  penyaluranDonasiController
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
                ],
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
