import 'package:flutter/material.dart';
import 'package:kasir_euy/Layout/ProfilPage.dart';
import 'DashboardPage.dart';
import 'MenuPage.dart';
import 'TransaksiPage.dart';

List menu = [DashboardScreen(), TransaksiScreen(), MenuScreen(), Profil()];
List visibilitasLeading = [false, false, false, true];
List title = ["Dashboard", "Transaksi", "Menu", "Profil"];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[_selectedNavbar]),
        actions: [
          Visibility(
            visible: visibilitasLeading[_selectedNavbar],
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Visibility(
            visible: visibilitasLeading[_selectedNavbar],
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                // Tombol Edit ditekan
              },
            ),
          ),
          Visibility(
            visible: visibilitasLeading[_selectedNavbar],
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                // Tombol Log Out ditekan
              },
            ),
          ),
        ],
      ),
      body: menu[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.computer), label: "Transaksi"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "Profil"),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
