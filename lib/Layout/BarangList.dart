import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir_euy/Class/BarangClass.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import 'package:kasir_euy/main.dart';

import '../ClassService.dart/BarangService.dart';

class Kocak extends StatefulWidget {
  const Kocak({super.key});

  @override
  State<Kocak> createState() => _KocakState();
}

class _KocakState extends State<Kocak> {
  BarangService controller = BarangService();
  List<String> _id = [];
  List<String> _iddata = [];
  List<Barang> _barang = [];
  List<Barang> _barangdata = [];
  var idhapus = "";
  File? imageFile;
  String urlGambar = "assets/image/default.png";
  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadID();
    print("OK");
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Barang> barangs = await controller.getItems(currentUser!.uid);
    setState(() {
      _barang = barangs;
    });
  }

  Future<void> _loadData(String kd) async {
    List<Barang> barangPilih = await controller.getData(kd);
    setState(() {
      _barangdata = barangPilih;
      conKodeBarang.text = _barangdata[0].kdbarang;
      conHargaBarang.text = _barangdata[0].harga.toString();
      conNamaBarang.text = _barangdata[0].namabarang;
      conStokBarang.text = _barangdata[0].stok.toString();
      conTerjual.text = _barangdata[0].terjual.toString();
      urlGambar = _barang[0].urlImage.toString();

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Edit Barang"),
              content: Container(
                child: Column(
                  children: [
                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Container(
                    //       height: 150,
                    //       width: 150,
                    //       child: CircleAvatar(
                    //           radius: 50,
                    //           backgroundImage:
                    //               FileImage(File(urlGambar))
                    //           //() {
                    //           //   if (urlGambar ==
                    //           //       'default.png') {
                    //           //     return AssetImage(
                    //           //         'assets/image/default.png');
                    //           //   } else {
                    //           //     return FileImage(
                    //           //             File(urlGambar))
                    //           //         as ImageProvider;
                    //           //   }
                    //           // }()
                    //           // File(
                    //           //             _barang[index]
                    //           //                 .urlImage)
                    //           //         .existsSync()
                    //           //     ? FileImage(File(
                    //           //             _barang[index]
                    //           //                 .urlImage))
                    //           //         as ImageProvider<
                    //           //             Object> // Gambar dari file
                    //           //     : AssetImage(
                    //           //         'assets/image/default.png'),
                    //           ),
                    //     ),
                    //     Positioned(
                    //         bottom: 15,
                    //         right: 1,
                    //         child: Container(
                    //           height: 50,
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //             borderRadius:
                    //                 BorderRadius.circular(
                    //                     50),
                    //             color: primaryColor,
                    //           ),
                    //           child: IconButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   pickImage();
                    //                 });
                    //               },
                    //               icon: Icon(
                    //                 Icons.edit,
                    //                 size: 15,
                    //                 color: Colors.white,
                    //               )),
                    //         ))
                    //   ],
                    // ),
                    Container(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              pickImage();
                            });
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
                      child: urlGambar != "default.png"
                          ? Image.file(
                              File(urlGambar),
                              height: 200.0,
                              width: 200.0,
                            )
                          : Image.asset(
                              'assets/image/default.png',
                              height: 200.0,
                              width: 200.0,
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      child: imageFile != null
                          ? Image.file(
                              File(urlGambar),
                              height: 200.0,
                              width: 200.0,
                            )
                          : Image.asset(
                              'assets/image/default.png',
                              height: 200.0,
                              width: 200.0,
                            ),
                    ),

                    // Visibility(
                    //   visible: false,
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         contentPadding:
                    //             EdgeInsets.all(10),
                    //         border: UnderlineInputBorder(),
                    //         label: Text("Kode Barang")),
                    //     controller: conID,
                    //   ),
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       contentPadding:
                    //           EdgeInsets.all(10),
                    //       border: UnderlineInputBorder(),
                    //       label: Text("Kode Barang")),
                    //   controller: conKodeBarang,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       label: Text("Nama Barang")),
                    //   controller: conNamaBarang,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       label: Text("Harga Barang")),
                    //   controller: conHargaBarang,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       label: Text("Stok Barang")),
                    //   controller: conStokBarang,
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       label: Text("Terjual")),
                    //   controller: conTerjual,
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       var kdbarang = conKodeBarang.text;
                    //       var namabarang =
                    //           conNamaBarang.text;
                    //       int hargabarang = int.parse(
                    //           conHargaBarang.text);
                    //       int stokbarang =
                    //           int.parse(conStokBarang.text);
                    //       int terjual =
                    //           int.parse(conTerjual.text);
                    //       setState(() {
                    //         Barang newItem = Barang(
                    //             idtoko: currentUser!.uid,
                    //             kdbarang: kdbarang,
                    //             namabarang: namabarang,
                    //             stok: stokbarang,
                    //             harga:
                    //                 hargabarang.toDouble(),
                    //             terjual: terjual,
                    //             urlImage:
                    //                 'defaultbarang.png');
                    //         controller.updateItem(
                    //             conID.text, newItem);
                    //       });
                    //       refreshPage();
                    //     },
                    //     child: Text("Update Barang"))
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Tutup"))
              ],
            );
          });
    });
  }

  Future<void> _loadViewData(String kd) async {
    List<Barang> barangPilih = await controller.getData(kd);
    setState(() {
      _barangdata = barangPilih;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(_barangdata[0].namabarang),
              content: Container(
                height: 200,
                child: Center(child: () {
                  if (_barangdata[0].urlImage == 'default.png') {
                    print('okkk');
                    return Image.asset("assets/image/default.png");
                    // Text("ok");
                  } else {
                    print('oool');
                    return Image.file(File(_barangdata[0].urlImage));
                  }
                }()),
              ),
            );
          });
    });
  }

  Future<void> _loadID() async {
    List<String> documentIds = await controller.getDocumentIds();
    print('Document IDs: $documentIds');
    setState(() {
      _id = documentIds;
    });
    print(_id);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        urlGambar = pickedImage.path;
      });
      print(urlGambar);
    }
  }

  Future<void> _loadDataID(String kd) async {
    List<String> documentpilihIds = await controller.getDocumentDataIds(kd);
    print('Document IDs: $documentpilihIds');
    setState(() {
      _iddata = documentpilihIds;
      var id = _iddata[0].toString();
      idhapus = id;
      conID.text = id;
    });
    print(_iddata);
  }

  @override
  TextEditingController conID = TextEditingController();
  TextEditingController conKodeBarang = TextEditingController();
  TextEditingController conNamaBarang = TextEditingController();
  TextEditingController conStokBarang = TextEditingController();
  TextEditingController conHargaBarang = TextEditingController();
  TextEditingController conTerjual = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text("Data Barang"),
        ),
        body: ListView(children: [
          DataTable(
              showBottomBorder: true,
              columnSpacing: 10,
              columns: [
                DataColumn(
                    label: Container(
                        alignment: Alignment.center,
                        child: Center(child: Text('KD')))),
                DataColumn(label: Center(child: Text('Nama Barang'))),
                DataColumn(label: Center(child: Text('Stok'))),
                DataColumn(label: Center(child: Text('Harga'))),
                DataColumn(label: Text('Aksi')),
                // DataColumn(label: Center(child: Container( alignment: Alignment.center ,child: Text('Aksi', textAlign: TextAlign.center,)))),
              ],
              rows: List.generate(_barang.length, (index) {
                return DataRow(cells: [
                  DataCell(Container(
                      alignment: Alignment.center,
                      child: Text(_barang[index].kdbarang))),
                  DataCell(Container(
                      alignment: Alignment.center,
                      child: Text(_barang[index].namabarang))),
                  DataCell(Container(
                      alignment: Alignment.center,
                      child: Text(_barang[index].stok.toString()))),
                  DataCell(Container(
                      alignment: Alignment.center,
                      child: Text(_barang[index].harga.toString()))),
                  DataCell(Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          alignment: Alignment.center,
                          iconSize: 15,
                          onPressed: () {
                            _loadViewData(_barang[index].kdbarang);
                          },
                          color: Colors.amber,
                          icon: Icon(Icons.visibility)),
                      IconButton(
                          iconSize: 15,
                          onPressed: () {
                            _loadData(_barang[index].kdbarang);

                            _loadDataID(_barang[index].kdbarang).toString();

                            // print(_barangdata[0].kdbarang);
                          },
                          color: Colors.green,
                          icon: Icon(Icons.edit)),
                      IconButton(
                          iconSize: 15,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Konfirmasi"),
                                  content: Text("Yakin menghapus data?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Batal")),
                                    TextButton(
                                        onPressed: () {
                                          controller.deleteItem(
                                              _barang[index].kdbarang);
                                          Navigator.of(context).pop();
                                          refreshPage();
                                        },
                                        child: Text("Hapus")),
                                  ],
                                );
                              },
                            );
                          },
                          color: Colors.red,
                          icon: Icon(Icons.delete)),
                    ],
                  ))
                ]);
              })),
        ]));
  }

  void refreshPage() {
    setState(() {
      _loadUsers();
    });
  }
}
