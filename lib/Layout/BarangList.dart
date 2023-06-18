import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/BarangClass.dart';

import '../ClassService.dart/BarangService.dart';

class Kocak extends StatefulWidget {
  const Kocak({super.key});

  @override
  State<Kocak> createState() => _KocakState();
}

class _KocakState extends State<Kocak> {
  BarangService controller = BarangService();
  List<Barang> _barang = [];
  List<String> _id = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadID();
    print("OK");
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Barang> barangs = await controller.getItems();
    setState(() {
      _barang = barangs;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ok"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(onPressed: (){
            showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                        title: Text("uhuyy"),
                        content: Text('uhuyy'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);

                          }, child: Text("OK"))
                        ],
                  );
            });
          }, icon: Icon(Icons.add), label: Text("Tambah")),
        ),
          Expanded(
            child: ListView.builder(
              
              padding: EdgeInsets.all(8),
             itemCount: _barang.length,
             itemBuilder: (context, index) {
             return DataTable(
              decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      ),
              
              columnSpacing: 10,
                
            columns: [
                  
              DataColumn(label: Text('NO')),
              DataColumn(label: Text('Kode Barang')),
              DataColumn(label: Text('Nama Barang')),
              DataColumn(label: Text('Stok')),
              DataColumn(label: Text('Harga')),
              DataColumn(label: Text('Aksi')),
              ],
              rows: [
               DataRow(
          
                cells: [
                  DataCell(Text((index + 1) .toString(), textAlign: TextAlign.center,),),
                  DataCell(Text(_barang[index].kdbarang)),
                  DataCell(Text(_barang[index].namabarang)),
                  DataCell(Text(_barang[index].stok.toString())),
                  DataCell(Text(_barang[index].harga.toString())),
                  DataCell(
                    Row(children: [
                      IconButton(
                        onPressed: () {},
                        color: Colors.amber,
                        icon: Icon(Icons.visibility)),
                      IconButton(
                        onPressed: () {},
                        color: Colors.green,
                        icon: Icon(Icons.edit)),
                      IconButton(
                        onPressed: () {},
                        color: Colors.red,
                        icon: Icon(Icons.delete))
                    ],)
                  ),
                ],
              ),
            ],
              );
              }),
          ),
        ],
      ));

  }
  }
 