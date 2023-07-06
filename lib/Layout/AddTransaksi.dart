import 'package:flutter/material.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import '../Class/BarangClass.dart';
import '../ClassService.dart/BarangService.dart';

class AddTransaksi extends StatefulWidget {
  const AddTransaksi({super.key});

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  TextEditingController conQTY = TextEditingController();
  TextEditingController conKodeBarang = TextEditingController();
  BarangService barangController = BarangService();
  List<Barang> barangData = [];

  Future<void> _getData(String kd) async {
    List<Barang> barangPilih = await barangController.getData(kd);
    setState(() {
      barangData = barangPilih;
      print(barangData[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Tambah Barang"),
        centerTitle: true,
      ),
      body: Container(
        color: primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          _getData(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(),
                          label: Text("Kode Barang"),
                        ),
                        controller: conKodeBarang,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(),
                          label: Text("QTY"),
                        ),
                        controller: conQTY,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // barang = "Lah";
                      });
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            )),
            Visibility(
              visible: true,
              child: Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 30,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.all(10)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.cyanAccent)),
                              onPressed: () {},
                              icon: Icon(Icons.view_in_ar_sharp),
                              label: const Text("Tampilkan Barang")),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
