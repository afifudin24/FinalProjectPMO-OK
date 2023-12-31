import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: [
          _buildMenuItem(Icons.inventory, 'Stok Barang'),
          _buildMenuItem(Icons.person, 'Member'),
          _buildMenuItem(Icons.money, 'Donasi'),
          _buildMenuItem(Icons.stacked_line_chart, 'Laporan Penjualan'),
        ],
      );
    
  }

 
}

 Widget _buildMenuItem(IconData iconData, String title) {
    return GestureDetector(
      onTap: () {
        // Tambahkan logika ketika item menu diklik
        print('Menu $title diklik');
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 48.0,
              color: Colors.blue,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  
  }