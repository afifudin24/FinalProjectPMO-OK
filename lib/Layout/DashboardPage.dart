import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            transformAlignment: Alignment.center,
            height: 520,
            child: Center(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  DashboardMenuItem(
                    title: 'Total Stok',
                    value: '150',
                    icon: Icons.shopping_cart,
                    onPressed: () {
                      // TODO: Implement sales functionality
                    },
                  ),
                  DashboardMenuItem(
                    title: 'Laporan Penjualan',
                    value: '25',
                    icon: Icons.insert_chart,
                    onPressed: () {
                      // TODO: Implement inventory functionality
                    },
                  ),
                  DashboardMenuItem(
                    title: 'Member',
                    value: '500',
                    icon: Icons.person,
                    onPressed: () {
                      // TODO: Implement customers functionality
                    },
                  ),
                  DashboardMenuItem(
                    title: 'Saldo',
                    value: 'Rp 10.000.000',
                    icon: Icons.account_balance_wallet,
                    onPressed: () {
                      // TODO: Implement reports functionality
                    },
                  ),
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
