import 'dart:js';

import 'package:flutter/material.dart';
import 'package:kasir_euy/Layout/BarangList.dart';
import 'package:kasir_euy/Layout/TokoList.dart';
import 'HomeScreen.dart';

class KasirMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void pindah() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Kocak()),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      children: [
        _buildMenuItem(Icons.inventory, 'Stok Barang', pindah),
        _buildMenuItem(Icons.person, 'Member', '/login'),
        _buildMenuItem(Icons.money, 'Donasi', '/home'),
        _buildMenuItem(Icons.stacked_line_chart, 'Laporan Penjualan', '/home'),
      ],
    );
  }

  Widget _buildMenuItem(IconData iconData, String title, VoidCallbackAction) {
    return InkWell(
      onTap: () {
        // Tambahkan logika ketika item menu diklik

        VoidCallbackAction();
        print('ok');
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
}
