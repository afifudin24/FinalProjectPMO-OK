import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/AddTransaksi.dart';
import '../Class/BarangClass.dart';
import '../ClassService.dart/BarangService.dart';
import 'komposisi.dart';
import 'AddTransaksi.dart';
import 'package:need_resume/need_resume.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  String namaBrg = " ";
  int hrg = 0;
  int ttlHarga = 0;
  int qty = 0;
  int? stok;
  int? totalSeluruhHarga;
  @override
  var kodemember = false;
  List<Map<String, dynamic>?> daftarBarang = [];

  List namaBarang = [];

  List hargaBarang = [];
  List totalBarang = [];
  List totalHargaPerBarang = [];
  var visTampilBarang = false;
  var visMulaiTransaksi = true;
  var visTable = true;
  var visTransaksi = false;
  void initState() {
    super.initState();
    _getBarang();
    print("OK");
  }

  TextEditingController conKdBarang = TextEditingController();
  TextEditingController conQTY = TextEditingController();
  final FocusNode _qtyfocusNode = FocusNode();
  BarangService barangController = BarangService();
  List<Barang> barangData = [];
  List<Barang> dataBarang = [];
  int? hargaPer;
  Future<void> _getBarang() async {
    List<Barang> barangs = await barangController.getItems("546");
    setState(() {
      dataBarang = barangs;
    });
  }

  Future<void> _getData(String kd) async {
    List<Barang> barangPilih = await barangController.getData(kd);
    if (barangPilih.length > 0) {
      setState(() {
        barangData = barangPilih;
        print(barangData[0].namabarang);
        namaBrg = barangData[0].namabarang;
        hrg = barangData[0].harga;
        ttlHarga = hrg * qty;
        stok = barangData[0].stok;
      });
    }
  }

  void ubahData(String nama, harga, kd) {
    setState(() {
      namaBrg = nama;
      hrg = harga;
      conKdBarang.text = kd;
    });
  }

  void _prosesTransaksi() {
    setState(() {
      totalSeluruhHarga = daftarBarang
          .map((data) => data?['totalharga']!)
          .reduce((a, b) => a + b);
      print(totalSeluruhHarga);
    });
  }

  void dispose() {
    conQTY.dispose();
    super.dispose();
  }

  void _ubahNilai(String nilai) {
    namaBrg = nilai;
    print(namaBrg);
  }

  // void dispose() {
  //   conKdBarang.dispose();
  //   super.dispose();
  // }

  void _tambahKeDaftar(
      String kd, String nmbrg, int hrgpr, int totalHarga, int qty) {
    setState(() {
      Map<String, dynamic> data = {
        "kodebarang": kd,
        "namabarang": nmbrg,
        "hargaperbarang": hrgpr,
        "totalharga": totalHarga,
        "qty": qty
      };
      daftarBarang.add(data);

      print(daftarBarang.toString());
      Navigator.pop(context);
    });
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data Barang'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: dataBarang.length,
              itemBuilder: (BuildContext context, int index) {
                Barang dtBrg = dataBarang[index];
                return ListTile(
                  title: Text(dtBrg.kdbarang.toString()),
                  subtitle: Text(dtBrg.namabarang),
                  hoverColor: Colors.grey,
                  trailing: FilledButton.icon(
                    onPressed: () {
                      ubahData(dtBrg.namabarang, dtBrg.harga, dtBrg.kdbarang);
                      print(hrg);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.add_circle),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(secondaryColor),
                        iconColor: MaterialStatePropertyAll(Colors.white)),
                    label: Text("Tambah"),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(225, 255, 255, 255),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                padding: EdgeInsets.all(10),
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => oke(context)));
                    },
                    icon: Icon(Icons.add_shopping_cart_rounded),
                    label: Text("Tambah Barang")),
              ),
              Container(
                child: () {
                  if (daftarBarang.isEmpty) {
                    // ignore: prefer_const_constructors
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/image/kosongBelanja.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Belum Ada Daftar Barang",
                              style: GoogleFonts.poppins(
                                  fontSize: 25, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.only(
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 3, color: Colors.grey))),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: FittedBox(
                              child: Expanded(
                                child: DataTable(
                                    showBottomBorder: true,
                                    columnSpacing: 20,
                                    columns: const [
                                      DataColumn(
                                          label: Center(child: Text("QTY")),
                                          numeric: true),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Kode Barang"))),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Nama Barang"))),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Harga Barang"))),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Total Harga"))),
                                    ],
                                    rows: []),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Flexible(
                                child: DataTable(
                                  showBottomBorder: false,
                                  columnSpacing: 20,
                                  headingRowHeight: 0,
                                  columns: const [
                                    DataColumn(
                                      label: Center(
                                        child: Text(
                                          "QTY",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                        label:
                                            Center(child: Text("Kode Barang"))),
                                    DataColumn(
                                        label:
                                            Center(child: Text("Nama Barang"))),
                                    DataColumn(
                                        label: Center(
                                            child: Text("Harga Barang"))),
                                    DataColumn(
                                        label:
                                            Center(child: Text("Total Harga"))),
                                  ],
                                  rows: List<DataRow>.generate(
                                    daftarBarang.length,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(Center(
                                          child: Text(
                                            daftarBarang[index]!['qty']
                                                .toString(),
                                          ),
                                        )),
                                        DataCell(
                                          Center(
                                            child: TextButton.icon(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {},
                                              label: Text(
                                                daftarBarang[index]
                                                    ?['kodebarang'],
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(Center(
                                          child: Text(daftarBarang[index]
                                              ?['namabarang']),
                                        )),
                                        DataCell(Center(
                                          child: Text(daftarBarang[index]![
                                                  'hargaperbarang']
                                              .toString()),
                                        )),
                                        DataCell(Center(
                                          child: Text(
                                              daftarBarang[index]!['totalharga']
                                                  .toString()),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }(),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(secondaryColor),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(10),
                          ),
                        ),
                        onPressed: () {
                          _prosesTransaksi();
                        },
                        icon: Icon(Icons.navigate_next),
                        label: Text("Proses"))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget oke(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tambah Barang",
          style: TextStyle(color: primaryColor),
        ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: TextField(
                          // onTapOutside: null,
                          // onEditingComplete: () {
                          //   setState(() {
                          //     _getData(conKdBarang.text);
                          //   });
                          // },
                          // onSubmitted: (value) {
                          //   setState(() {
                          //     _getData(value);
                          //   });
                          // },
                          onChanged: (value) {
                            setState(() {
                              _getData(value);
                            });
                          },
                          controller: conKdBarang,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(7),
                            border: OutlineInputBorder(),
                            label: Text("Kode Barang"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          onChanged: (value) {
                            if (conKdBarang.text == "") {
                              print("belum ada kode");
                              setState(() {
                                qty = int.parse(value);
                              });
                            } else {
                              setState(() {
                                ttlHarga = int.parse(value) * hrg;
                                qty = int.parse(value);

                                print(qty);
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          focusNode: _qtyfocusNode,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(),
                            label: Text("QTY"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 120,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Barang : $namaBrg",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.black),
                      ),
                      Text("Harga Per Barang : $hrg",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.black)),
                      Text("Total Harga : $ttlHarga",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(10))),
                        onPressed: () {
                          print(stok);
                          if (qty <= stok!) {
                            setState(() {
                              _tambahKeDaftar(conKdBarang.text, namaBrg, hrg,
                                  ttlHarga, qty);
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Kesalahan"),
                                  content: Text(
                                      "Stok Tidak Cukup \nStok Terkini $stok"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          conQTY.clear();
                                          print(qty);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("Tutup"),
                                    )
                                  ],
                                );
                              },
                            );
                            conQTY.clear();
                            _qtyfocusNode.requestFocus();
                          }
                        },
                        icon: Icon(Icons.add_circle_outlined),
                        label: Text("Tambahkan")),
                  ),
                )
              ],
            )),
            Visibility(
              visible: true,
              child: Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: 70,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.all(10)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(secondaryColor)),
                              onPressed: () {
                                showMyDialog(context);
                              },
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
