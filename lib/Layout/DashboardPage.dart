import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/pageview.dart';

import '../Class/TokoClass.dart';
import '../ClassService.dart/TokoService.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   TokoService controller = TokoService();
  var namaToko = "";
  var namaAdmin = " ";
  @override
  void initState() {
    super.initState();
    _loadUsers();
    
    print("OK");
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Toko> tokos = await controller.getDataItems("123");
    setState(() {
      namaAdmin = tokos[0].adminToko;
      print(tokos[0].adminToko);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              child: Center(
                child: 
                PageViewScreen(),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(33, 64, 100, 1),
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
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: DashboardMenuItem(
                                            
                            title: 'Total Stok',
                            value: '150',
                            icon: Icons.shopping_cart,
                            onPressed: () {
                              // TODO: Implement sales functionality
                            },
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: DashboardMenuItem(
                            title: 'Laporan Penjualan',
                            value: '25',
                            icon: Icons.insert_chart,
                            onPressed: () {
                              // TODO: Implement inventory functionality
                            },
                          ),
                        ),
                      
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: DashboardMenuItem(
                            title: 'Member',
                            value: '500',
                            icon: Icons.person,
                            onPressed: () {
                              // TODO: Implement customers functionality
                            },
                                                  ),
                          ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: DashboardMenuItem(
                            title: 'Saldo',
                            
                            value: 'Rp 1.000.000' ,
                            icon: Icons.account_balance_wallet,
                            onPressed: () {
                              // TODO: Implement reports functionality
                            },
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
