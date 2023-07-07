import 'package:flutter/material.dart';
import 'package:kasir_euy/Class/DonasiClass.dart';
import 'package:kasir_euy/Layout/BarangList.dart';
import 'package:kasir_euy/Layout/DonasiData.dart';
import 'package:kasir_euy/Layout/PenyaluranDonasi.dart';

class KasirMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void pindah() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Kocak()),
      );
    }

    void pindahSalurkanDonasi() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PenyaluranDonasi()),
      );
    }
    void pindahDonasi() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DonasiData()),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      children: [
        _buildMenuItem(Icons.inventory, 'Stok Barang', pindah),
        _buildMenuItem(Icons.person, 'Member', '/login'),
        _buildMenuItem(Icons.money, 'Donasi', pindahDonasi),
        _buildMenuItem(Icons.stacked_line_chart, 'Laporan Penjualan', '/home'),
        _buildMenuItem(Icons.send_to_mobile, 'Penyaluran Donasi', pindahSalurkanDonasi),
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
