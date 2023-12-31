import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Class/LaporanPemasukanClass.dart';
import 'package:kasir_euy/Class/LaporanPenjualanClass.dart';
import 'package:kasir_euy/Class/MemberClass.dart';
import 'package:kasir_euy/ClassService.dart/BarangService.dart';
import 'package:kasir_euy/ClassService.dart/LaporanPemasukanService.dart';
import 'package:kasir_euy/ClassService.dart/LaporanPenjualanService.dart';
import 'package:kasir_euy/Layout/komposisi.dart';
import 'package:kasir_euy/Layout/pageview.dart';
import 'package:kasir_euy/main.dart';

import '../Class/BarangClass.dart';
import '../Class/TokoClass.dart';
import '../ClassService.dart/MemberService.dart';
import '../ClassService.dart/TokoService.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TokoService controller = TokoService();
  LaporanPenjualanService penjualancontroller = LaporanPenjualanService();
  BarangService barangcontroller = BarangService();
  MemberService membercontroller = MemberService();
  LaporanPemasukanService pemasukancontroller = LaporanPemasukanService();

  bool isHovered1 = false;
  bool isHovered2 = false;
  bool isHovered3 = false;
  bool isHovered4 = false;
  var namaToko = "";
  var namaAdmin = " ";

  //angka jual
  var jual = [];
  int penjualan = 0;

  //stok
  var stok = [];
  int stokBarang = 0;

  int terbaru = 0;
  //member
  var members = [];

  int member = 0;
  //saldo
  var saldos = [];

  double saldo = 0.0;
  @override
  void initState() {
    super.initState();
    _loadUsers();
    _getJual();
    _getStok();
    _getMember();
    // _getSaldo();
  }

  Future<void> _loadUsers() async {
    List<Toko> tokos =
        await controller.getDataItems(currentUser!.uid.toString());
    setState(() {
      namaAdmin = tokos[0].adminToko;
      saldo = tokos[0].saldo;

      print(tokos[0].adminToko);
      print(tokos[0].urlImage);
    });
  }

  Future<void> _getJual() async {
    List<Barang> _jual =
        await barangcontroller.getItems(currentUser!.uid.toString());
    setState(() {
      jual = _jual;
      print(jual.toList());

      for (int i = 0; i < _jual.length; i++) {
        penjualan += _jual[i].terjual;
      }
      print(penjualan);
    });
  }

  Future<void> _getStok() async {
    List<Barang> _stok =
        await barangcontroller.getItems(currentUser!.uid.toString());
    setState(() {
      stok = _stok;
      for (int i = 0; i < _stok.length; i++) {
        stokBarang += _stok[i].stok;
      }
    });
  }

  Future<void> _getMember() async {
    List<Member> _members =
        await membercontroller.getMembersData(currentUser!.uid.toString());
    setState(() {
      members = _members;
      member = _members.length;
      print(member);
    });
  }

  Future<void> _getSaldo() async {
    List<Toko> _saldo =
        await controller.getDataItems(currentUser!.uid.toString());
    setState(() {
      saldo = _saldo[0].saldo;
      print(saldo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Color.fromRGBO(33, 64, 100, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Center(
                child: PageViewScreen(),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              padding: EdgeInsets.all(10),
              height:350,
              child: Center(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                     
                            margin: EdgeInsets.only(left: 2, right: 2),
                            child: InkWell(
                              onHover: (bool value) {
                                print("oke");
                                setState(() {
                                  isHovered1 = value;
                                });
                              },
              
                              onTap: () {
                                print("hah");
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: DashboardItem(
                                        value: stokBarang.toString(),
                                        ikon: Icons.shopping_cart,
                                        komponen: "Stok Barang",
                                        hover: isHovered1)),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 2, right: 2),
                            child: InkWell(
                              onHover: (bool value) {
                                print("oke");
                                setState(() {
                                  isHovered2 = value;
                                });
                              },
                              onTap: () {
                                print("hah");
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: DashboardItem(
                                        value: penjualan.toString(),
                                        ikon: Icons.check_circle,
                                        komponen: "Barang Terjual",
                                        hover: isHovered2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 2, right: 2),
                            child: InkWell(
                              onHover: (bool value) {
                                print("oke");
                                setState(() {
                                  isHovered3 = value;
                                });
                              },
                              onTap: () {
                                print("hah");
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: DashboardItem(
                                        value: member.toString(),
                                        ikon: Icons.person,
                                        komponen: "Member",
                                        hover: isHovered3)),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 2, right: 2),
                            child: InkWell(
                              onHover: (bool value) {
                                print("oke");
                                setState(() {
                                  isHovered4 = value;
                                });
                              },
                              onTap: () {
                                print("hah");
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: DashboardItem(
                                        value: saldo.toString(),
                                        ikon: Icons.account_balance_wallet_sharp,
                                        komponen: "Saldo",
                                        hover: isHovered4)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              child: Text(
                "Grafik Pemasukan",
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              height: 200,
              padding: EdgeInsets.all(10),
              // child: charts.BarChart(
              //   _createSampleData(),
              //   animate: true,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('laporanPemasukan')
                    .orderBy('date', descending: false)
                    .where('idToko', isEqualTo: currentUser!.uid.toString())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    print("oke");
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    // Membuat map untuk menyimpan total pemasukan berdasarkan kategori waktu (bulan)
                    Map<String, double> incomeByMonth = {};

                    // Mengelompokkan dan menghitung total pemasukan berdasarkan bulan
                    documents.forEach((doc) {
                      DateTime date = doc['date'].toDate();
                      String formattedMonth =
                          '${date.day}/${date.month}/${date.year}';

                      if (incomeByMonth.containsKey(formattedMonth)) {
                        incomeByMonth[formattedMonth] =
                            doc['totalHarga'] + incomeByMonth[formattedMonth]!;
                      } else {
                        incomeByMonth[formattedMonth] = doc['totalHarga'];
                      }
                    });

                    // Membuat series data untuk chart
                    List<charts.Series<IncomeData, String>> seriesList = [
                      charts.Series(
                        id: 'Pemasukan',
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(secondaryColor),
                        data: incomeByMonth.entries.map((entry) {
                          return IncomeData(
                            category: entry.key,
                            value: entry.value.toDouble(),
                          );
                        }).toList(),
                        domainFn: (IncomeData data, _) => data.category,
                        measureFn: (IncomeData data, _) =>
                            data.value.toDouble(),
                        labelAccessorFn: (IncomeData data, _) =>
                            data.value.toString(),
                      ),
                    ];

                    return charts.BarChart(
                      seriesList,
                      animate: true,
                      domainAxis: charts.OrdinalAxisSpec(
                        renderSpec:
                            charts.SmallTickRendererSpec(labelRotation: 45),
                      ),
                    );
                  } else {
                    print("Gak ada Data");
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              child: Text(
                "Grafik Penjualan",
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              height: 200,
              padding: EdgeInsets.all(10),
              // child: charts.BarChart(
              //   _createSampleData(),
              //   animate: true,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('laporanPenjualan')
                    .orderBy('date', descending: false)
                    .where('idToko', isEqualTo: currentUser!.uid.toString())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    print("oke");
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    // Membuat map untuk menyimpan total pemasukan berdasarkan kategori waktu (bulan)
                    Map<String, int> incomeByMonth = {};

                    // Mengelompokkan dan menghitung total pemasukan berdasarkan bulan
                    documents.forEach((doc) {
                      DateTime date = doc['date'].toDate();
                      String formattedMonth =
                          '${date.day}/${date.month}/${date.year}';

                      if (incomeByMonth.containsKey(formattedMonth)) {
                        incomeByMonth[formattedMonth] =
                            doc['totalJual'] + incomeByMonth[formattedMonth]!;
                      } else {
                        incomeByMonth[formattedMonth] = doc['totalJual'];
                      }
                    });

                    // Membuat series data untuk chart
                    List<charts.Series<SaleData, String>> seriesList = [
                      charts.Series(
                        id: 'Penjualan',
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(secondaryColor),
                        data: incomeByMonth.entries.map((entry) {
                          return SaleData(
                            category: entry.key,
                            value: entry.value,
                          );
                        }).toList(),
                        domainFn: (SaleData data, _) => data.category,
                        measureFn: (SaleData data, _) => data.value,
                      ),
                    ];

                    return charts.BarChart(
                      seriesList,
                      animate: true,
                      domainAxis: charts.OrdinalAxisSpec(
                        renderSpec:
                            charts.SmallTickRendererSpec(labelRotation: 45),
                      ),
                    );
                  } else {
                    print("Gak ada Data");
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              child: Text(
                "Grafik Pengeluaran",
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              height: 200,
              padding: EdgeInsets.all(10),
              // child: charts.BarChart(
              //   _createSampleData(),
              //   animate: true,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('laporanPengeluaran')
                    .orderBy('date', descending: false)
                    .where('idToko', isEqualTo: currentUser!.uid.toString())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    print("oke");
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    // Membuat map untuk menyimpan total pemasukan berdasarkan kategori waktu (bulan)
                    Map<String, int> incomeByMonth = {};

                    // Mengelompokkan dan menghitung total pemasukan berdasarkan bulan
                    documents.forEach((doc) {
                      DateTime date = doc['date'].toDate();
                      String formattedMonth =
                          '${date.day}/${date.month}/${date.year}';

                      if (incomeByMonth.containsKey(formattedMonth)) {
                        incomeByMonth[formattedMonth] =
                            doc['totalPengeluaran'] +
                                incomeByMonth[formattedMonth]!;
                      } else {
                        incomeByMonth[formattedMonth] = doc['totalPengeluaran'];
                      }
                    });

                    // Membuat series data untuk chart
                    List<charts.Series<OuterData, String>> seriesList = [
                      charts.Series(
                        id: 'Pengeluaran',
                        colorFn: (_, __) =>
                            charts.ColorUtil.fromDartColor(secondaryColor),
                        data: incomeByMonth.entries.map((entry) {
                          return OuterData(
                            category: entry.key,
                            value: entry.value,
                          );
                        }).toList(),
                        domainFn: (OuterData data, _) => data.category,
                        measureFn: (OuterData data, _) => data.value,
                      ),
                    ];

                    return charts.BarChart(
                      seriesList,
                      animate: true,
                      domainAxis: charts.OrdinalAxisSpec(
                        renderSpec:
                            charts.SmallTickRendererSpec(labelRotation: 45),
                      ),
                    );
                  } else {
                    print("Gak ada Data");
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget DashboardItem({
    String? komponen,
    String? value,
    IconData? ikon,
    bool? hover,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      child: Container(
        height: 300,
        width: 300,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 0),
                blurRadius: 1,
                spreadRadius: 0.5,
              )
            ],
            color: hover! ? Colors.white54 : Colors.white,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Icon(
                      ikon as IconData?,
                      size: 30,
                      color: secondaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Text(
                      value!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(komponen!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  final String month;
  final int amount;

  SalesData(this.month, this.amount);
}

class DashboardMenuItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onPressed;

  const DashboardMenuItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeData {
  final String category;
  final double value;

  IncomeData({required this.category, required this.value});
}

class SaleData {
  final String category;
  final int value;

  SaleData({required this.category, required this.value});
}

class OuterData {
  final String category;
  final int value;

  OuterData({required this.category, required this.value});
}
