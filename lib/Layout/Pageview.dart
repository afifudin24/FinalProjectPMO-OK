import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir_euy/ClassService.dart/BarangService.dart';
import 'komposisi.dart';
import '../Class/BarangClass.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<PageViewScreen> {
  List<Barang> dataBarang = [];
  var vsb = false;
  BarangService barangController = BarangService();
  final PageController _pageController = PageController(initialPage: 1);

  Future<void> _getBarang() async {
    List<Barang> dtBarang = await barangController.getItems("546");
    dataBarang = dtBarang;
    setState(() {
      dataBarang.sort((a, b) => b.terjual.compareTo(a.terjual));
      vsb = true;
    });
  }

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (dataBarang.length < 2) {
      return Container(
        height: 200,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/image/nolaris.png"),
            Text("Belum ada \n barang terlaris",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 15, color: primaryColor))
          ],
        ),
      );
    } else {
      return Visibility(
        visible: vsb,
        child: PageView.builder(
          controller: _pageController,
          itemCount: 2,
          itemBuilder: (context, index) {
            return elemenPage(dataBarang[index]);
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getBarang();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget elemenPage(Barang data) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.only(left: 3, right: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 0.5,
          )
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
            ),
            Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.namabarang,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      data.harga.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text("Terjual : " + data.terjual.toString()),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
