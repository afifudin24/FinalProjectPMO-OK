import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Class/DonasiClass.dart';
import 'package:kasir_euy/Layout/BarangList.dart';
import 'package:kasir_euy/Layout/DonasiData.dart';
import 'package:kasir_euy/Layout/LaporanLayout.dart';
import 'package:kasir_euy/Layout/Memberlayout.dart';
import 'package:kasir_euy/Layout/PenyaluranDonasi.dart';
import 'package:kasir_euy/Layout/Supplier/SupplierMenu.dart';
import 'komposisi.dart';

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

    void pindahMember() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CrudMemberClass()),
      );
    }

    void pindahSupplier() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SupplierMenu()),
      );
    }

    void pindahLaporan() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Laporan()),
      );
    }

    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 700,
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                _buildMenuItem(Icons.inventory, 'Stok Barang', pindah),
                _buildMenuItem(Icons.person, 'Member', pindahMember),
                _buildMenuItem(Icons.money, 'Donasi', pindahDonasi),
                _buildMenuItem(Icons.stacked_line_chart, 'Laporan Penjualan',
                    pindahLaporan),
                _buildMenuItem(Icons.send_to_mobile, 'Penyaluran Donasi',
                    pindahSalurkanDonasi),
                _buildMenuItem(
                    Icons.view_comfy_alt_outlined, 'Supplier', pindahSupplier),
              ],
            ),
          ),
        ),
      ),
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
              color: primaryColor,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
