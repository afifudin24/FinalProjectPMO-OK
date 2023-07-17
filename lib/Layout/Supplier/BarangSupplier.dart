import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import 'package:kasir_euy/main.dart';

import '../../Class/BarangSupplierClass.dart';
import '../../ClassService.dart/BarangSupplierService.dart';

class BarangSupp extends StatefulWidget {
  const BarangSupp({super.key});

  @override
  State<BarangSupp> createState() => _BarangSuppState();
}

class _BarangSuppState extends State<BarangSupp> {
  List<BarangSupplier> barangSupplier = [];
  List<BarangSupplier> barangPilih = [];
  BarangSupplierService barangsuppcontroller = BarangSupplierService();
  TextEditingController conkodebarang = TextEditingController();
  TextEditingController connamabarang = TextEditingController();
  TextEditingController conhargabarang = TextEditingController();
  Future<void> loadData() async {
    List<BarangSupplier> barangs =
        await barangsuppcontroller.getItems(currentUser!.uid.toString());
    setState(() {
      barangSupplier = barangs;
    });
  }

  Future<void> getData(String kd) async {
    List<BarangSupplier> barangs = await barangsuppcontroller.getData(kd);
    setState(() {
      barangPilih = barangs;
      conkodebarang.text = barangs[0].kodebarang;
      connamabarang.text = barangs[0].namabarang;
      conhargabarang.text = barangs[0].hargabarang.toString();
      print('oo');
    });
  }

  void initState() {
    super.initState();
    print('buset');
    loadData();
    print(barangSupplier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Barang Supplier"),
          centerTitle: true,
          backgroundColor: secondaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(secondaryColor)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Tambah Barang Supplier"),
                              content: Container(
                                width: 400,
                                height: 250,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextField(
                                        controller: conkodebarang,
                                        decoration: InputDecoration(
                                          label: Text("Kode Barang"),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        controller: connamabarang,
                                        decoration: InputDecoration(
                                          label: Text("Nama Barang"),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      TextField(
                                        controller: conhargabarang,
                                        decoration: InputDecoration(
                                          label: Text("Harga Barang"),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                ElevatedButton.icon(
                                    onPressed: () {
                                      BarangSupplier data = BarangSupplier(
                                          kodebarang: conkodebarang.text,
                                          namabarang: connamabarang.text,
                                          idtoko: currentUser!.uid.toString(),
                                          hargabarang:
                                              int.parse(conhargabarang.text));
                                      barangsuppcontroller
                                          .addItem(conkodebarang.text, data)
                                          .then((value) {
                                        print("Berhasil Tambah Data");
                                        Navigator.pop(context);
                                        refreshPage();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Berhasil"),
                                              content: Container(
                                                height: 200,
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Text("Berhasil tambah data")
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                    label: Text("Tambah")),
                                ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.close),
                                    label: Text("Batal")),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.library_add_sharp),
                      label: Text("Tambah Barang")),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: () {
                      if (barangSupplier.length > 0) {
                        return buildView();
                      } else {
                        return noData();
                      }
                    }(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget noData() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/kosongSupp.png"),
            SizedBox(
              height: 10,
            ),
            Text(
              "Belum Ada Barang",
              style: GoogleFonts.poppins(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildView() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 5, right: 5),
      itemCount: barangSupplier.length,
      itemBuilder: (context, index) {
        BarangSupplier _barangSupplier = barangSupplier[index];

        return Column(
          children: [
            ListTile(
              iconColor: Colors.red,
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              title: Text(_barangSupplier.namabarang),
              subtitle: Text(_barangSupplier.hargabarang.toString()),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_barangSupplier.kodebarang),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      getData(_barangSupplier.kodebarang);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Update Data Barang'),
                            content: Container(
                              width: 400,
                              height: 250,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      enabled: false,
                                      controller: conkodebarang,
                                      decoration: InputDecoration(
                                        label: Text("Kode Barang"),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: connamabarang,
                                      decoration: InputDecoration(
                                        label: Text("Nama Barang"),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: conhargabarang,
                                      decoration: InputDecoration(
                                        label: Text("Harga Barang"),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton.icon(
                                  onPressed: () {
                                    var kd = conkodebarang.text;
                                    var namabrg = connamabarang.text;
                                    var hargabrg =
                                        int.parse(conhargabarang.text);

                                    BarangSupplier data = BarangSupplier(
                                        kodebarang: kd,
                                        namabarang: namabrg,
                                        idtoko: currentUser!.uid.toString(),
                                        hargabarang: hargabrg);
                                    barangsuppcontroller
                                        .updateItem(kd, data)
                                        .then((value) {
                                      print("Berhasil Update Data");
                                      Navigator.pop(context);
                                      refreshPage();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Container(
                                              height: 100,
                                              width: 100,
                                              child: Center(
                                                  child: Text(
                                                      "Berhasil Update Data")),
                                            ),
                                          );
                                        },
                                      );
                                    });
                                  },
                                  icon: Icon(Icons.edit),
                                  label: Text("Update")),
                              ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.close),
                                  label: Text("Batal")),
                            ],
                          );
                        },
                      );
                    },
                  ),
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
                                  barangsuppcontroller
                                      .deleteItem(_barangSupplier.kodebarang)
                                      .then((value) {
                                    print("oke");
                                  }).catchError((onError) {
                                    print(onError);
                                  });
                                  // refreshPage();
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
      conhargabarang.clear();
      connamabarang.clear();
      conhargabarang.clear();
      loadData();
    });
  }
}
