import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/Layout/Supplier/BarangSupplier.dart';
import 'package:kasir_euy/Layout/Supplier/BeliBarangSupplier.dart';

import '../komposisi.dart';

class SupplierMenu extends StatefulWidget {
  const SupplierMenu({super.key});

  @override
  State<SupplierMenu> createState() => _SupplierMenuState();
}

class _SupplierMenuState extends State<SupplierMenu> {
  void dataBarang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BarangSupp()),
    );
  }

  void beliBarang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BeliBarangSupplier()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        backgroundColor: Colors.white,
        title: Text(
          "Menu Supplier",
          style: GoogleFonts.poppins(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: primaryColor,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: GridView.count(
          padding: EdgeInsets.all(5),
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          crossAxisCount: 1,
          children: [
            _buildMenuItem(Icons.inventory, 'Data barang', dataBarang),
            _buildMenuItem(
                Icons.shopping_cart_sharp, 'Beli Barang', beliBarang),
          ],
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
