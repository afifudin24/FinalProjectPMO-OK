import 'dart:async';

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Class/LaporanPemasukanClass.dart';
import 'package:kasir_euy/Class/LaporanPenjualanClass.dart';
import 'package:kasir_euy/Class/MemberClass.dart';
import 'package:kasir_euy/ClassService.dart/BarangService.dart';
import 'package:kasir_euy/ClassService.dart/LaporanPemasukanService.dart';
import 'package:kasir_euy/ClassService.dart/LaporanPenjualanService.dart';
import 'package:kasir_euy/Layout/pageview.dart';

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

  int saldo = 0;
  @override
  void initState() {
    super.initState();
    _loadUsers();
    _getJual();
    _getStok();
    _getMember();
    _getSaldo();
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Toko> tokos = await controller.getDataItems("123");
    setState(() {
      namaAdmin = tokos[0].adminToko;
      print(tokos[0].adminToko);
    });
  }

  Future<void> _getJual() async {
    List<LaporanPenjualan> _jual = await penjualancontroller.getData("daf");
    setState(() {
      jual = _jual;
      print(jual.toList());

      for (int i = 0; i < _jual.length; i++) {
        penjualan += _jual[i].totalJual;
      }
    });
  }

  Future<void> _getStok() async {
    List<Barang> _stok = await barangcontroller.getItems("546");
    setState(() {
      stok = _stok;
      for (int i = 0; i < _stok.length; i++) {
        stokBarang += _stok[i].stok;
      }
    });
  }

  Future<void> _getMember() async {
    List<Member> _members = await membercontroller.getMembersData("123");
    setState(() {
      members = _members;
      member = _members.length;
      print(member);
    });
  }

  Future<void> _getSaldo() async {
    List<LaporanPemasukan> _saldo = await pemasukancontroller.getData("123");
    setState(() {
      saldos = _saldo;
      for (int i = 0; i < _saldo.length; i++) {
        saldo += _saldo[i].totalHarga;
      }
    });
  }

  List<charts.Series<SalesData, String>> _createSampleData() {
    final data = [
      SalesData('Jan', 30),
      SalesData('Feb', 25),
      SalesData('Mar', 40),
      SalesData('Apr', 45),
      SalesData('May', 50),
      SalesData('Jun', 55),
      SalesData('Jul', 30),
      SalesData('Aug', 25),
      SalesData('Sep', 40),
      SalesData('Okt', 45),
      SalesData('Nov', 50),
      SalesData('Des', 55),
    ];

    return [
      charts.Series<SalesData, String>(
        id: 'Sales',
        domainFn: (SalesData sales, _) => sales.month,
        measureFn: (SalesData sales, _) => sales.amount,
        data: data,
        labelAccessorFn: (SalesData sales, _) => '${sales.amount}',
      ),
    ];
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
              width: double.infinity,
              height: 400,
              child: Center(
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
                                  height: 200,
                                  width: 200,
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
                                  height: 200,
                                  width: 200,
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
                                  height: 200,
                                  width: 200,
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
                                  height: 200,
                                  width: 200,
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
            Container(
              alignment: Alignment.center,
              height: 200,
              padding: EdgeInsets.all(2),
              child: charts.BarChart(
                _createSampleData(),
                animate: true,
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
                      color: Colors.green,
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
