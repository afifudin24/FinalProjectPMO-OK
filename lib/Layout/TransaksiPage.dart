import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Class/LaporanPemasukanClass.dart';
import 'package:kasir_euy/Layout/AddTransaksi.dart';
import '../Class/BarangClass.dart';
import '../Class/LaporanPenjualanClass.dart';
import '../ClassService.dart/BarangService.dart';
import '../ClassService.dart/LaporanPemasukanService.dart';
import '../ClassService.dart/LaporanPenjualanService.dart';
import 'komposisi.dart';
import 'AddTransaksi.dart';
import 'package:need_resume/need_resume.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'HomeScreen.dart';
import '../main.dart';

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
  int? stok = 0;
  int? totalSeluruhHarga;
  bool tampilProses = false;
  int totalbayar = 0;
  int kembalian = 0;
  String pdfFile = " ";
  @override
  var kodemember = false;
  List<Map<String, dynamic>?> daftarBarang = [];

  List namaBarang = [];
  var cek = true;
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
  TextEditingController qtyPilihController = TextEditingController();
  TextEditingController conStok = TextEditingController();
  TextEditingController _nominal = TextEditingController();
  final FocusNode _qtyfocusNode = FocusNode();
  final FocusNode _kdfocusNode = FocusNode();
  BarangService barangController = BarangService();
  LaporanPemasukanService pemasukanController = LaporanPemasukanService();
  LaporanPenjualanService penjualanController = LaporanPenjualanService();
  List<Barang> barangData = [];
  List<Barang> dataBarang = [];
  int? hargaPer;
  Future<void> _getBarang() async {
    List<Barang> barangs = await barangController.getItems(currentUser!.uid.toString());
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
        conStok.text = barangData[0].stok.toString();
      });
    }
  }

  
  Future<void> _inputDataPemasukan() async {
  

     setState(() {
            int? ttlhrga = totalSeluruhHarga;
      int jml = daftarBarang
          .map((data) => data?['qty']!)
          .reduce((a, b) => a + b);
      DateTime now = DateTime.now();
       Timestamp timestamp = Timestamp.fromDate(now);
        String randomId = FirebaseFirestore.instance.collection('laporanPemasukan').doc().id;
     LaporanPemasukan data =   LaporanPemasukan(idToko: "123", idTransaksi: randomId, jumlBarang: jml, totalHarga: ttlHarga, date: timestamp);
       pemasukanController.addItem(randomId, data).then((result) {
    // Blok then akan dijalankan jika operasi berhasil
    print("oke");
     setState(() {
      cek = true;
    });
  }).catchError((error) {
    // Blok catchError akan dijalankan jika terjadi kesalahan
    print('Terjadi kesalahan: $error');
     setState(() {
      cek = false;
    });
  });

  });
  
}
 

  Future<void> _inputDataPenjualan() async {
  daftarBarang.forEach((element) {
      DateTime now = DateTime.now();
       Timestamp timestamp = Timestamp.fromDate(now);
        String randomId = FirebaseFirestore.instance.collection('laporanPenjualan').doc().id;
        daftarBarang.forEach((element) {
          LaporanPenjualan data = LaporanPenjualan(idJual: randomId, kdbarang: element?['kodebarang'], namaBarang: element?['namabarang'], idToko: "123", totalJual: element?['qty'], date: timestamp);
          penjualanController.addItem(randomId, data).then((result) {
    // Blok then akan dijalankan jika operasi berhasil
    print("sip");
    setState(() {
      cek = true;
    });
  }).catchError((error) {
    // Blok catchError akan dijalankan jika terjadi kesalahan
    print('Terjadi kesalahan: $error');
      setState(() {
      cek = false;
    });
  });
;
        
        });

        
  },);
  
}
 
  Future<void> _updateTerjual() async {
  daftarBarang.forEach((element) {
    var stok;
    var terjual;
        daftarBarang.forEach((element) async {
           List<Barang> barangPilih = await barangController.getData(element?['kodebarang']);
         stok = barangPilih[0].stok - element?['qty'];
         terjual = barangPilih[0].terjual + element?['qty'];
          FirebaseFirestore.instance
      .collection('barang') // Ganti dengan nama koleksi sesuai dengan struktur Firestore Anda
      .doc(element?['kodebarang']) // Ganti dengan ID produk yang ingin Anda update
      .update({'stok': stok}) // Update properti 'stock' dengan nilai baru
      .then((value) {
    print('Stok berhasil diupdate');
      setState(() {
      cek = true;
    });
  })
  .catchError((error) {
    print('Terjadi kesalahan: $error');
     setState(() {
      cek = false;
    });
  });
          
          FirebaseFirestore.instance
      .collection('barang') // Ganti dengan nama koleksi sesuai dengan struktur Firestore Anda
      .doc(element?['kodebarang']) // Ganti dengan ID produk yang ingin Anda update
      .update({'terjual': terjual}) // Update properti 'stock' dengan nilai baru
      .then((value) {
    print('Terjual berhasil diupdate');
      setState(() {
      cek = true;
    });
  })
  .catchError((error) {
    print('Terjadi kesalahan: $error');
     setState(() {
      cek = false;
    });
  });
          
  });
;
        
        });

        
  }
 

  //savePdf
Future<void> savePdf() async {
  final pdf = pw.Document();
  DateTime now = DateTime.now();
  String formattedDate = '${now.day}-${now.month}-${now.year}';



  // Membuat List<List<String>> dari data
  final List<List<String?>> tableData = daftarBarang.map((row) {
    return [
      row?['qty'].toString(),
      row?['kodebarang'].toString(),
      row?['namabarang'].toString(),
      row?['hargaperbarang'].toString(),
      row?['totalharga'].toString(),
    ];
  }).toList();

     // Tambahkan header tabel dengan tab
  // final List<String> headerRow = ['QTY\tKode Barang\tNama Barang\tHarga Barang\tTotal Harga'];
  // tableData.insert(0, headerRow);
  // Tambahkan konten PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Container(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
            pw.Text(namatoko),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text(now.toString()),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray( 
          context: context,
          data: tableData,
          headers: <String>[
            'QTY',
            'Kode Barang',
            'Nama Barang',
            'Harga Barang',
            'Total Harga',
            // Daftar judul kolom di sini
          ],
          headerCount: 1,
          border: pw.TableBorder.all(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellAlignment: pw.Alignment.centerLeft,
          cellAlignments: {
            0: pw.Alignment.center,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
            3: pw.Alignment.center,
            4: pw.Alignment.center,
          },
        ),
         pw.SizedBox(height: 10),
        pw.Text("Total Harga : $totalSeluruhHarga"),
        pw.SizedBox(height: 10),
        pw.Text("Total Bayar : $totalbayar"),
        pw.SizedBox(height: 10),
        pw.Text("Total Kembalian : $kembalian"),
        pw.SizedBox(height: 10),

            ]
            
    )
    
    );
    },
    ),
  );            
   

  // Dapatkan path penyimpanan di perangkat
  final directory = await getExternalStorageDirectory();
  final path = '${directory?.path}/transaksi-$formattedDate.pdf';

  // Simpan file PDF di path yang ditentukan
  final file = File(path);
  await file.writeAsBytes(await pdf.save());

  // Tampilkan notifikasi keberhasilan
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('File PDF disimpan di: $path')),
  );
}

//buka PDF
  Future<void> openPDF(String filePath) async {
    File file = File(filePath);
    if (await file.exists()) {
      // File exists, proceed to open it
      if (await canLaunch(filePath)) {
        await launch(filePath);
      } else {
        throw "Cannot launch PDF viewer";
      }
    } else {
      throw 'PDF file does not exist';
    }
  }

  void _hapusDaftarBarang(List<Map<String, dynamic>?> daftarBarang, String kd) {
    setState(() {
      daftarBarang.removeWhere((data) => data?['kodebarang'] == kd);
    });
    Navigator.pop(context);
  }

  void _updateDaftarBarang(
      List<Map<String, dynamic>?> daftarBarang, String kd) {
    daftarBarang.forEach((data) {
      if (data?["kodebarang"] == kd) {
        setState(() {
          data?['qty'] = int.parse(qtyPilihController.text);
          data?['totalharga'] =
              int.parse(qtyPilihController.text) * data?['hargaperbarang'];
        });
      }
    });
    Navigator.pop(context);
  }

  void ubahData(String nama, harga, kd, stok) {
    setState(() {
      namaBrg = nama;
      hrg = harga;
      conKdBarang.text = kd;
      stok = stok;
      conStok.text = stok.toString();
    });
    print(stok);
  }

  void _prosesTransaksi() {
    setState(() {
      totalSeluruhHarga = daftarBarang
          .map((data) => data?['totalharga']!)
          .reduce((a, b) => a + b);
      print(totalSeluruhHarga);
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Proses Transaksi"),
          content: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text("Total Belanja",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void dispose() {
    super.dispose();
  }

  void updateAutofillAnchor(BuildContext context) {
    const platform = MethodChannel('android/view/autofill');

    // Dapatkan informasi halaman aktif
    final routeName = ModalRoute.of(context)?.settings.name;

    if (routeName != null) {
      // Kirim permintaan ke kode platform Android untuk memperbarui anchor Autofill
      platform.invokeMethod('updateAutofillAnchor', {'anchor': routeName});
    }
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
    });
  }

  void showDataTable(
      BuildContext context, String kdBarang, int qty, String namaBarang) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Data Barang"),
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kode Barang :" + kdBarang),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Nama Barang : " + namaBrg),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: qtyPilihController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("QTY"),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    _updateDaftarBarang(daftarBarang, kdBarang);
                  },
                  icon: Icon(Icons.edit_square),
                  label: Text("Update")),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    _hapusDaftarBarang(daftarBarang, kdBarang);
                  },
                  icon: Icon(Icons.delete_outlined),
                  label: Text("Hapus")),
            ],
          );
        });
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              // Kondisi khusus untuk menutup AlertDialog tanpa mengubah nilai anchor Autofill
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              return false; // Mengembalikan false agar tidak menutup halaman utama jika ada
            },
            child: AlertDialog(
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
                          setState(() {
                            ubahData(dtBrg.namabarang, dtBrg.harga,
                                dtBrg.kdbarang, dtBrg.stok);
                          });
                          print(hrg);
                          Navigator.pop(context);
                          _kdfocusNode.requestFocus();
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
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            ));
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
                    setState(() {
                      tampilProses = true;
                    });
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
                                              onPressed: () {
                                                setState(() {
                                                  qtyPilihController.text =
                                                      daftarBarang[index]![
                                                              'qty']
                                                          .toString();
                                                });
                                                showDataTable(
                                                    context,
                                                    daftarBarang[index]
                                                        ?['kodebarang'],
                                                    daftarBarang[index]!['qty'],
                                                    daftarBarang[index]
                                                        ?['namabarang']);
                                              },
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
              Visibility(
                visible: tampilProses,
                child: Container(
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
                            setState(() {
                              totalSeluruhHarga = daftarBarang
                                  .map((data) => data?['totalharga']!)
                                  .reduce((a, b) => a + b);
                              print(totalSeluruhHarga);
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProsesTransaksi(
                                        context, totalSeluruhHarga)));
                          },
                          icon: Icon(Icons.navigate_next),
                          label: Text("Proses"))
                    ],
                  ),
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
                          focusNode: _kdfocusNode,
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
                          print(conStok.text);
                          if (int.parse(conStok.text) > qty) {
                            setState(() {
                              _tambahKeDaftar(conKdBarang.text, namaBrg, hrg,
                                  ttlHarga, qty);
                            });
                            Navigator.pop(context, TransaksiScreen());
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

  Widget ProsesTransaksi(BuildContext context, int? totalSeluruhHarga) {
    print(daftarBarang.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Proses Transaksi"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text("Total Bayar",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 70,
                              child: Text(
                                totalSeluruhHarga.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text("Nominal Uang",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 150,
                              height: 70,
                              child: TextField(
                                controller: _nominal,
                                decoration: InputDecoration(
                                    // label: Text("Nominal"),
                                    border: OutlineInputBorder()),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                          label: Text("Kode Member"),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 20),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.amber)),
                          onPressed: () {},
                          child: Text("Kode Member")),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 10),
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.navigate_next_sharp),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          onPressed: () {
                            setState(() {
                              totalbayar = int.parse(_nominal.text);
                              kembalian =
                                  int.parse(_nominal.text) - totalSeluruhHarga!;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Detail Transaksi",
                                      style: GoogleFonts.poppins(
                                        fontSize: 26,
                                      )),
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Total Bayar : $totalSeluruhHarga",
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Uang Bayar : " + _nominal.text,
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                            )),
                                        Text("Kembalian : $kembalian",
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                            )),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.green)),
                                        onPressed: () {
                                          savePdf();
                                        },
                                        icon: Icon(Icons.file_open_rounded),
                                        label: Text("Simpan PDF")),
                                    ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    primaryColor)),
                                        onPressed: () {
                                          _inputDataPemasukan();
                                          _inputDataPenjualan();
                                          _updateTerjual();
                                          if(cek == true){
                                            setState(() {
                                              daftarBarang.clear();
                                              tampilProses = false;
                                            });
                                         
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                           
                                            ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Transaksi Berhasil')),
  );

                                          }else{
                                            print("Gagal");
                                          }
                                        },
                                        icon: Icon(Icons.done_outline_rounded),
                                        label: Text("Selesaikan Transaksi")),
                                  ],
                                );
                              },
                            );
                          },
                          label: Text("Proses")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
