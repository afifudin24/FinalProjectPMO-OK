import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Class/LaporanPemasukanClass.dart';
import 'package:kasir_euy/Layout/AddTransaksi.dart';
import '../../../Class/BarangClass.dart';

import '../../Class/BarangSupplierClass.dart';
import '../../Class/LaporanPengeluaran.dart';
import '../../Class/TokoClass.dart';
import '../../ClassService.dart/BarangService.dart';
import '../../ClassService.dart/BarangSupplierService.dart';
import '../../ClassService.dart/LaporanPengeluaranService.dart';
import '../../ClassService.dart/TokoService.dart';
import '../../main.dart';

import '../HomeScreen.dart';
import '../komposisi.dart';

import 'package:need_resume/need_resume.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'package:flutter/material.dart';

class BeliBarangSupplier extends StatefulWidget {
  const BeliBarangSupplier({super.key});

  @override
  State<BeliBarangSupplier> createState() => _BeliBarangSupplierState();
}

class _BeliBarangSupplierState extends State<BeliBarangSupplier> {
  @override
  String namaBrg = " ";
  int hrg = 0;
  int ttlHarga = 0;
  double hargaJual = 0.0;
  int qty = 0;
  int? stok = 0;
  int totalSeluruhHarga = 0;
  bool tampilProses = false;
  int totalbayar = 0;
  int kembalian = 0;
  String pdfFile = " ";
  var lokasi;
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
  var tampilSimpanPDF = true;
  var tampilBukaPDF = false;
  void initState() {
    super.initState();
    _getBarang();
  }

  TextEditingController conKdBarang = TextEditingController();
  TextEditingController conQTY = TextEditingController();
  TextEditingController qtyPilihController = TextEditingController();
  TextEditingController conStok = TextEditingController();
  TextEditingController _nominal = TextEditingController();
  final FocusNode _qtyfocusNode = FocusNode();
  final FocusNode _kdfocusNode = FocusNode();
  TokoService tokoController = TokoService();
  BarangService barangController = BarangService();
  BarangSupplierService barangSuppController = BarangSupplierService();
  LaporanPengeluaranService pengeluaranController = LaporanPengeluaranService();
  List<BarangSupplier> barangData = [];
  List<BarangSupplier> dataBarang = [];
  int? hargaPer;
  Future<void> _getBarang() async {
    List<BarangSupplier> barangs =
        await barangSuppController.getItems(currentUser!.uid.toString());
    setState(() {
      dataBarang = barangs;
    });
  }

  Future<void> _getData(String kd) async {
    List<BarangSupplier> barangPilih = await barangSuppController.getData(kd);
    if (barangPilih.length > 0) {
      setState(() {
        barangData = barangPilih;
        print(barangData[0].namabarang);
        namaBrg = barangData[0].namabarang;
        hrg = barangData[0].hargabarang;
        ttlHarga = hrg * qty;
      });
    }
  }

  Future<void> _inputDataPengeluaran() async {
    setState(() {
      int? ttlhrga = totalSeluruhHarga;
      DateTime now = DateTime.now();
      Timestamp timestamp = Timestamp.fromDate(now);
      String randomId =
          FirebaseFirestore.instance.collection('laporanPengeluaran').doc().id;
      // var ttlkeluar? = totalSeluruhHarga;
      LaporanPengeluaran data = LaporanPengeluaran(
          idPengeluaran: randomId,
          totalPengeluaran: ttlhrga,
          date: timestamp,
          idToko: currentUser!.uid.toString());
      pengeluaranController.addItem(randomId, data).then((result) {
        // Blok then akan dijalankan jika operasi berhasil
        print("sip");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Beli Barang Berhasil')),
        );
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

  Future<void> _updateSaldo() async {
    print(currentUser!.uid.toString());
    var toko;
    var saldo;
    var saldoTerkini;

    List<Toko> tokoPilih =
        await tokoController.getDataItems(currentUser!.uid.toString());
    toko = tokoPilih[0];
    saldo = tokoPilih[0].saldo;
    saldoTerkini = saldo - totalSeluruhHarga;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('toko');
    Query query =
        collectionRef.where('idtoko', isEqualTo: currentUser!.uid.toString());
    // Data yang ingin diperbarui
    Map<String, dynamic> data = {
      'saldo': saldoTerkini,
      // Tambahkan field dan nilai baru sesuai kebutuhan
    };
    // Memperbarui data di Firestore
    query.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference
            .update(data)
            .then((value) => print('Saldo berhasil diperbarui'))
            .catchError((error) => print('Terjadi error: $error'));
      });
    });

    // FirebaseFirestore.instance
    //     .collection(
    //         'toko') // Ganti dengan nama koleksi sesuai dengan struktur Firestore Anda
    //     .doc(currentUser!.uid
    //         .toString()) // Ganti dengan ID produk yang ingin Anda update
    //     .update({
    //   'saldo': saldoTerkini
    // }) // Update properti 'stock' dengan nilai baru
    //     .then((value) {
    //   print('Saldo berhasil diupdate');
    //   setState(() {
    //     cek = true;
    //   });
    // }).catchError((error) {
    //   print('Terjadi kesalahan: $error');
    //   setState(() {
    //     cek = false;
    //   });
    // });
  }

  Future<void> _updateBarang() async {
    daftarBarang.forEach((element) async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('barang')
          .where('kdbarang', isEqualTo: element?['kodebarang'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Data ada');

        querySnapshot.docs.forEach((document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          var stokBaru = data["stok"] + element?['qty'];
          if (data["harga"] == element?['hargaJual']) {
            Map<String, dynamic> dataku = {
              'stok': stokBaru,
              // Tambahkan field dan nilai baru sesuai kebutuhan
            };
            document.reference
                .update(dataku)
                .then((value) => print("Stok Berhasil Diupdate"))
                .catchError((onError) => print("Terjadi Kesalahan"));
          } else {
            var hargaBaru = (data["harga"] + element?["hargaJual"]) / 2;
            print(element?["hargaJual"]);
            print(data['harga']);
            Map<String, dynamic> dataku = {
              'stok': stokBaru,
              'harga': hargaBaru,
              // Tambahkan field dan nilai baru sesuai kebutuhan
            };
            document.reference
                .update(dataku)
                .then((value) => print("Stok Berhasil Diupdate"))
                .catchError((onError) => print("Terjadi Kesalahan"));
          }

          // Menampilkan data
        });
      } else {
        Barang data = Barang(
          harga: element?["hargaJual"],
          kdbarang: element?["kodebarang"],
          idtoko: currentUser!.uid.toString(),
          stok: element?["qty"],
          namabarang: element?["namabarang"],
          terjual: 0,
          urlImage: 'default.png',
        );
        barangController.addItem(element?["kodebarang"], data).then((value) {
          print("Berhasil menambahkan barang baru");
        }).catchError((onError) {
          print("Gagal Euy");
        });
        print('Data tidak ada');
      }
    });
    // print(currentUser!.uid.toString());
    // var toko;
    // var saldo;
    // var saldoTerkini;

    // List<Toko> tokoPilih =
    //     await tokoController.getDataItems(currentUser!.uid.toString());
    // toko = tokoPilih[0];
    // saldo = tokoPilih[0].saldo;
    // saldoTerkini = saldo - totalSeluruhHarga;
    // CollectionReference collectionRef =
    //     FirebaseFirestore.instance.collection('toko');
    // Query query =
    //     collectionRef.where('idtoko', isEqualTo: currentUser!.uid.toString());
    // // Data yang ingin diperbarui
    // Map<String, dynamic> data = {
    //   'saldo': saldoTerkini,
    //   // Tambahkan field dan nilai baru sesuai kebutuhan
    // };
    // Memperbarui data di Firestore
    // query.get().then((querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     doc.reference
    //         .update(data)
    //         .then((value) => print('Saldo berhasil diperbarui'))
    //         .catchError((error) => print('Terjadi error: $error'));
    //   });
    // });

    // FirebaseFirestore.instance
    //     .collection(
    //         'toko') // Ganti dengan nama koleksi sesuai dengan struktur Firestore Anda
    //     .doc(currentUser!.uid
    //         .toString()) // Ganti dengan ID produk yang ingin Anda update
    //     .update({
    //   'saldo': saldoTerkini
    // }) // Update properti 'stock' dengan nilai baru
    //     .then((value) {
    //   print('Saldo berhasil diupdate');
    //   setState(() {
    //     cek = true;
    //   });
    // }).catchError((error) {
    //   print('Terjadi kesalahan: $error');
    //   setState(() {
    //     cek = false;
    //   });
    // });
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
        row?['hargaJual'].toString(),
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
                    'Harga Jual',
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
                pw.Text("Total Pengeluaran : $totalSeluruhHarga"),
              ]));
        },
      ),
    );

    // Dapatkan path penyimpanan di perangkat
    final directory = await getExternalStorageDirectory();
    final path = '${directory?.path}/belibarang-$formattedDate.pdf';

    lokasi = path;
    print(lokasi);

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
      if (daftarBarang.isEmpty) {
        tampilProses = false;
      }
    });
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
  }

  void ubahData(String nama, harga, kd) {
    setState(() {
      namaBrg = nama;
      hrg = harga;
      conKdBarang.text = kd;

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

  void _ubahNilai(String nilai) {
    namaBrg = nilai;
    print(namaBrg);
  }

  void _tambahKeDaftar(String kd, String nmbrg, int hrgpr, int totalHarga,
      int qty, double hargaJual) {
    setState(() {
      Map<String, dynamic> data = {
        "kodebarang": kd,
        "namabarang": nmbrg,
        "hargaperbarang": hrgpr,
        "totalharga": totalHarga,
        "qty": qty,
        "hargaJual": hargaJual,
      };
      daftarBarang.add(data);

      print(daftarBarang.toString());
      Navigator.pop(context);
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
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.edit_square),
                  label: Text("Update")),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () {
                    _hapusDaftarBarang(daftarBarang, kdBarang);
                    Navigator.of(context).pop();
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
                    BarangSupplier dtBrg = dataBarang[index];
                    return ListTile(
                      title: Text(dtBrg.kodebarang.toString()),
                      subtitle: Text(dtBrg.namabarang),
                      hoverColor: Colors.grey,
                      trailing: FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            ubahData(dtBrg.namabarang, dtBrg.hargabarang,
                                dtBrg.kodebarang);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Beli Barang"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
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
                                        // DataColumn(
                                        //     label: Center(
                                        //         child: Text("Total Harga"))),
                                        DataColumn(
                                            label: Center(
                                                child: Text("Harga Jual"))),
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
                                          label: Center(
                                              child: Text("Kode Barang"))),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Nama Barang"))),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Harga Barang"))),
                                      // DataColumn(
                                      //     label: Center(
                                      //         child: Text("Total Harga"))),
                                      DataColumn(
                                          label: Center(
                                              child: Text("Harga Jual"))),
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
                                                      daftarBarang[index]![
                                                          'qty'],
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
                                          // DataCell(Center(
                                          //   child: Text(daftarBarang[index]![
                                          //           'totalharga']
                                          //       .toString()),
                                          // )),
                                          DataCell(Center(
                                            child: Text(daftarBarang[index]![
                                                    'hargaJual']
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Text("Detail Transaksi",
                                            style: GoogleFonts.poppins(
                                              fontSize: 26,
                                            )),
                                      ),
                                      content: Container(
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                "Total Bayar : $totalSeluruhHarga",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 24,
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        primaryColor)),
                                            onPressed: () {},
                                            icon: Icon(Icons.file_download),
                                            label: Text("Simpan PDF")),
                                        ElevatedButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.green)),
                                            onPressed: () {
                                              _updateSaldo();
                                              _updateBarang();
                                              _inputDataPengeluaran();
                                              setState(() {
                                                Navigator.pop(context);
                                                daftarBarang.clear();
                                                tampilProses = false;
                                              });
                                            },
                                            icon:
                                                Icon(Icons.check_circle_sharp),
                                            label: Text("Selesaikan Transaksi"))
                                      ],
                                    );
                                  });
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ProsesTransaksi(
                              //             context, totalSeluruhHarga)));
                            },
                            icon: Icon(Icons.navigate_next),
                            label: Text("Proses"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
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
                                var marginUntung = 0.2 * ttlHarga;
                                var jualSeluruh = marginUntung + ttlHarga;
                                qty = int.parse(value);
                                hargaJual = jualSeluruh.toDouble() / qty;
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
                      Text("Total Harga Beli : $ttlHarga",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.black)),
                      Text("Harga Jual : $hargaJual",
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

                          _tambahKeDaftar(conKdBarang.text, namaBrg, hrg,
                              ttlHarga, qty, hargaJual);
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
                                    height: 250,
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
                                        onPressed: () {},
                                        icon: Icon(Icons.file_download),
                                        label: Text("Simpan PDF")),
                                    ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.check_circle_sharp),
                                        label: Text("Selesaikan Transaksi"))
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
