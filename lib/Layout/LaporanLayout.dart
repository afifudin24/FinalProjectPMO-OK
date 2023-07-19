import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/LaporanPengeluaran.dart';
import 'package:kasir_euy/Class/LaporanPenjualanClass.dart';
import 'package:kasir_euy/ClassService.dart/LaporanPenjualanService.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import 'package:kasir_euy/main.dart';

import '../Class/LaporanPemasukanClass.dart';
import '../ClassService.dart/LaporanPemasukanService.dart';
import '../ClassService.dart/LaporanPengeluaranService.dart';

class Laporan extends StatefulWidget {
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  String pilihlaporan = 'Pilih jenis Laporan';
  String pilihkategori = 'Pilih Kategori Laporan';
  List<LaporanPenjualan> penjualan = [];
  List<LaporanPemasukan> pemasukan = [];
  List<LaporanPengeluaran> pengeluaran = [];
  LaporanPenjualanService penjualanController = LaporanPenjualanService();
  LaporanPemasukanService pemasukanController = LaporanPemasukanService();
  LaporanPengeluaranService pengeluaranController = LaporanPengeluaranService();
  int totalTerjual = 0;
  int totalBarang = 0;
  double totalmasuk = 0;
  double totalkeluar = 0;
  int totalHarga = 0;
  // List<String> jenislaporan = [
  //   'Pilih jenis Laporan',
  //   'Harian',
  //   'Bulanan',
  //   'Tahunan'
  // ];
  List<String> kategorilaporan = [
    'Pilih Kategori Laporan',
    'Laporan Pemasukan',
    'Laporan Penjualan',
    'Laporan Pengeluaran'
  ];
  Future<void> getData() async {
    List<LaporanPenjualan> lapjual =
        await penjualanController.getData(currentUser!.uid.toString());
    setState(() {
      penjualan = lapjual;
      print(penjualan);
      lapjual.forEach((element) {
        totalTerjual = totalTerjual + element.totalJual;
      });
    });
  }

  Future<void> getMasuk() async {
    List<LaporanPemasukan> lapmasuk =
        await pemasukanController.getData(currentUser!.uid.toString());
    setState(() {
      pemasukan = lapmasuk;
      print(pemasukan);
      lapmasuk.forEach((element) {
        totalmasuk = totalmasuk + element.totalHarga;
      });
    });
  }

  Future<void> getKeluar() async {
    List<LaporanPengeluaran> lapkeluar =
        await pengeluaranController.getData(currentUser!.uid.toString());
    setState(() {
      pengeluaran = lapkeluar;
      print(pemasukan);
      lapkeluar.forEach((element) {
        totalkeluar = totalkeluar + element.totalPengeluaran;
      });
    });
  }

  List<Map<String, dynamic>> selectedLapData = [];
  List<Map<String, dynamic>> pilihjenislap = [];

  var visibilitas1 = false;
  var visibilitas2 = false;
  var visibilitas3 = false;
  var visibilitas4 = false;
  @override
  void initState() {
    super.initState();
    getData();
    getMasuk();
    getKeluar();

    // selectedLapData = datalaporanPemasukan;
  }

  @override
  Widget build(BuildContext context) {
    int totalJumlahTerjual = 0;
    int totalHarga = 0;

    for (var data in selectedLapData) {
      final jumlahTerjual = data['jumlah terjual'] as int;
      final harga = data['harga'] as int;
      totalJumlahTerjual += jumlahTerjual;
      totalHarga += jumlahTerjual * harga;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(33, 64, 100, 1)),
        centerTitle: true,
        title: Text(
          'Laporan',
          style: TextStyle(
            color: Color.fromRGBO(33, 64, 100, 1),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: Center(
              child: drpdown(),
            ),
          ),
          Visibility(
            visible: visibilitas1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: FittedBox(
                      child: DataTable(
                          showBottomBorder: true,
                          // columnSpacing: 20,
                          columns: const [
                            DataColumn(
                              label: Center(
                                child: Text(
                                  "Kd Brg",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(label: Center(child: Text("Tanggal"))),
                            DataColumn(
                                label: Center(child: Text("Nama Barang"))),
                            DataColumn(
                                label: Center(child: Text("Jumlah Terjual"))),
                          ],
                          rows: []),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: SingleChildScrollView(
                        child: FittedBox(
                          child: DataTable(
                            showBottomBorder: true,
                            // columnSpacing: 70,
                            headingRowHeight: 0,
                            columns: const [
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    "Kd Brg",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              DataColumn(label: Center(child: Text("Tanggal"))),
                              DataColumn(
                                  label: Center(child: Text("Nama Barang"))),
                              DataColumn(
                                  label: Center(child: Text("Jumlah Terjual"))),
                            ],
                            rows: List<DataRow>.generate(penjualan.length,
                                (index) {
                              DateTime tanggal = penjualan[index].date.toDate();
                              String waktu =
                                  '${tanggal.day}/${tanggal.month}/${tanggal.year}';
                              return DataRow(cells: [
                                DataCell(Center(
                                  child: Text(
                                    penjualan[index].kdbarang.toString(),
                                  ),
                                )),
                                DataCell(
                                  Center(child: Text(waktu)),
                                ),
                                DataCell(Center(
                                  child: Text(penjualan[index].namaBarang),
                                )),
                                DataCell(Center(
                                  child: Text(
                                      penjualan[index].totalJual.toString()),
                                )),
                              ]);
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Total Terjual : $totalTerjual',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),

          Visibility(
            visible: visibilitas2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  FittedBox(
                    child: DataTable(
                        showBottomBorder: true,
                        // columnSpacing: 20,
                        columns: const [
                          DataColumn(label: Center(child: Text("No"))),
                          DataColumn(label: Center(child: Text("Tanggal"))),
                          // DataColumn(label: Center(child: Text("Transaksi"))),
                          DataColumn(
                              label: Center(child: Text("Jumlah Barang"))),
                          DataColumn(label: Center(child: Text("Total harga"))),
                        ],
                        rows: []),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: DataTable(
                        showBottomBorder: false,
                        // columnSpacing: 70,
                        headingRowHeight: 0,
                        columns: const [
                          DataColumn(label: Center(child: Text("No"))),
                          DataColumn(label: Center(child: Text("idTanggal"))),
                          // DataColumn(label: Center(child: Text("Transaksi"))),
                          DataColumn(label: Center(child: Text("jumlBarang "))),
                          DataColumn(label: Center(child: Text("totalHarga"))),
                        ],
                        rows: List<DataRow>.generate(pemasukan.length, (index) {
                          DateTime tanggal = pemasukan[index].date.toDate();
                          String waktu =
                              '${tanggal.day}/${tanggal.month}/${tanggal.year}';
                          return DataRow(cells: [
                            DataCell(
                              Center(child: Text((index + 1).toString())),
                            ),
                            DataCell(
                              Center(child: Text(waktu)),
                            ),
                            DataCell(Center(
                              child:
                                  Text(pemasukan[index].jumlBarang.toString()),
                            )),
                            DataCell(Center(
                              child:
                                  Text(pemasukan[index].totalHarga.toString()),
                            )),
                          ]);
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Total Pemasukan : $totalmasuk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: visibilitas4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  DataTable(
                      showBottomBorder: true,
                      // columnSpacing: 20,
                      columns: const [
                        DataColumn(label: Center(child: Text("No"))),
                        DataColumn(label: Center(child: Text("Tanggal"))),
                        // DataColumn(label: Center(child: Text("Transaksi"))),
                        // DataColumn(label: Center(child: Text("Jumlah Barang"))),
                        DataColumn(
                            label: Center(child: Text("Total Pengeluaran"))),
                      ],
                      rows: []),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: SingleChildScrollView(
                        child: DataTable(
                          showBottomBorder: false,
                          // columnSpacing: 70,
                          headingRowHeight: 0,
                          columns: const [
                            DataColumn(label: Center(child: Text("No"))),
                            DataColumn(label: Center(child: Text("idTanggal"))),
                            // DataColumn(label: Center(child: Text("Transaksi"))),
                            // DataColumn(label: Center(child: Text("jumlBarang "))),
                            DataColumn(
                                label:
                                    Center(child: Text("Total Pengeluaran"))),
                          ],
                          rows: List<DataRow>.generate(pengeluaran.length,
                              (index) {
                            DateTime tanggal = pengeluaran[index].date.toDate();
                            String waktu =
                                '${tanggal.day}/${tanggal.month}/${tanggal.year}';
                            return DataRow(cells: [
                              DataCell(
                                Center(child: Text((index + 1).toString())),
                              ),
                              DataCell(
                                Center(child: Text(waktu)),
                              ),
                              DataCell(Center(
                                child: Text(pengeluaran[index]
                                    .totalPengeluaran
                                    .toString()),
                              )),
                              // DataCell(Center(
                              //   child:
                              //       Text(pemasukan[index].totalHarga.toString()),
                              // )),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 35,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Total Pengeluaran : $totalkeluar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),

          // Visibility(
          //   visible: visibilitas2,
          //   child: Column(children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Table(
          //         border: TableBorder.all(),
          //         children: [
          //           TableRow(
          //             children: [
          //               TableCell(
          //                 child: Text('Transaksi'),
          //               ),
          //               TableCell(
          //                 child: Text('Jumlah Barang'),
          //               ),
          //               TableCell(
          //                 child: Text('Total Harga'),
          //               ),
          //             ],
          //           ),
          //           TableRow(
          //             children: [
          //               TableCell(
          //                 child: Text('Transaksi 1'),
          //               ),
          //               TableCell(
          //                 child: Text('10'),
          //               ),
          //               TableCell(
          //                 child: Text('100,000'),
          //               ),
          //             ],
          //           ),
          //           TableRow(
          //             children: [
          //               TableCell(
          //                 child: Text('Transaksi 2'),
          //               ),
          //               TableCell(
          //                 child: Text('5'),
          //               ),
          //               TableCell(
          //                 child: Text('50,000'),
          //               ),
          //             ],
          //           ),
          //           // Tambahkan baris tabel sesuai dengan data Anda
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Text('Total Jumlah: 15'),
          //           SizedBox(width: 20),
          //           Text('Total Harga: 150,000'),
          //         ],
          //       ),
          //     ),
          //   ]),
          // ),

          Visibility(
            visible: visibilitas3,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text('Tanggal'),
                        ),
                        TableCell(
                          child: Text('Pendapatan'),
                        ),
                        TableCell(
                          child: Text('Pengeluaran'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Text('12 nov 2023'),
                        ),
                        TableCell(
                          child: Text('1000000'),
                        ),
                        TableCell(
                          child: Text('2000'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Text('13 nov 2023'),
                        ),
                        TableCell(
                          child: Text('5000000'),
                        ),
                        TableCell(
                          child: Text('1000'),
                        ),
                      ],
                    ),
                    // Tambahkan baris tabel sesuai dengan data Anda
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Total Jumlah: 15'),
                    SizedBox(width: 20),
                    Text('Total Harga: 150,000'),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Container drpdown() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          border: Border.all(color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Flexible(
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(10)),
            //     child: DropdownButtonFormField<String>(
            //       dropdownColor: Colors.white,
            //       hint: Text("Pilih Jenis Laporan"),
            //       value: pilihlaporan,
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(),
            //       ),
            //       onChanged: (String? newValue) {
            //         setState(() {
            //           pilihlaporan = newValue!;
            //           if (pilihlaporan == 'Harian') {
            //             // pilihjenislap = data;
            //             visibilitas3;
            //           } else if (pilihlaporan == 'Bulanan') {
            //             // pilihjenislap = data;
            //             visibilitas3 = true;
            //             visibilitas3 = false;
            //           } else if (pilihlaporan == 'Tahunan') {
            //             // pilihjenislap = data;
            //             visibilitas3 = true;
            //             visibilitas3 = false;
            //           } else {
            //             visibilitas3 = false;
            //             visibilitas3 = false;
            //           }
            //         });
            //       },
            //       items: jenislaporan.map((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 40,
            // ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  hint: Text("Pilih Kategori Laporan"),
                  value: pilihkategori,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      pilihkategori = newValue!;
                      if (pilihkategori == 'Laporan Pemasukan') {
                        // selectedLapData = datalaporanPemasukan;
                        visibilitas1 = false;
                        visibilitas2 = true;
                        visibilitas4 = false;
                      } else if (pilihkategori == 'Laporan Penjualan') {
                        // selectedLapData = datalaporanPenjualan;
                        visibilitas2 = false;
                        visibilitas1 = true;
                        visibilitas4 = false;
                      } else if (pilihkategori == 'Laporan Pengeluaran') {
                        visibilitas4 = true;
                        visibilitas1 = false;
                        visibilitas2 = false;
                      } else {
                        visibilitas4 = false;
                        visibilitas1 = false;
                        visibilitas2 = false;
                      }
                    });
                  },
                  items: kategorilaporan.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Donation {
//   final String donatur;
//   final int jumlah;
//   final String yayasan;
//   final String gambar;

//   Donation({
//     required this.donatur,
//     required this.jumlah,
//     required this.yayasan,
//     required this.gambar,
//   });
// }
