import 'package:flutter/material.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  @override
  var kodemember= false;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children : [
        //text field nama barang, kode barang, harga, jumlah (untuk menambah data barang yg ditransaksi)
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Kode Barang"),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Nama barang"),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                          decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Jumlah"),
                          ),
                        ),
              ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Harga"),
              ),
            ),
          ),


            ],
          ),

          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Expanded(
                 child: ElevatedButton(
                  onPressed: () {  },
                  child: Text('Tambah'),
                           ),
               ),
            SizedBox(height: 16.0),
            SizedBox(width: 16),
            Expanded(
            child: ElevatedButton(
                //onPressed: _tampilkan,
                onPressed: () {  },
                child: Text('Tampilkan'),
              ),
          ),
            // SizedBox(height: 16.0),

            ],
          ),
          SizedBox(height: 16.0),
          Visibility(
            visible: kodemember,
            child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Kode Member"),
                ),
              ),
          ),
          
          

        //tabel barang transaksi (5 colom, No, kode barang, harga, jumlah barang, total harga)
        //Expanded(
          SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: Colors.black),
            //     ),
            
            child: DataTable(
               decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                ),
              // decoration: InputDecoration(
                
              //   border: OutlineInputBorder(),
              // ),
              
              columnSpacing: 23,
              columns: [
                DataColumn(label: Text('No')), //nomer dibikin otomatis terisi
                DataColumn(label: Text('Nama Barang')),
                DataColumn(label: Text('Harga')),
                DataColumn(label: Text('Jumlah Barang')),
                DataColumn(label: Text('Total Harga')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')), //nomer dibikin otomatis terisi
                  DataCell(Text('Ale ale')),
                  DataCell(Text('1000')),
                  DataCell(Text('100')),
                  DataCell(Text('100000')),
                ]),
                DataRow(cells: [
                  DataCell(Text('2')), //nomer dibikin otomatis terisi
                  DataCell(Text('Teh Sisri')),
                  DataCell(Text('1000')),
                  DataCell(Text('10')),
                  DataCell(Text('10000')),
                ]),
                DataRow(cells: [
                  DataCell(Text('3')), //nomer dibikin otomatis terisi
                  DataCell(Text('Serly')),
                  DataCell(Text('500000')),
                  DataCell(Text('3')),
                  DataCell(Text('1500000')),
                ]),
              ],
                  //  ),
                  //),
            )
          ),
        SizedBox(height: 16.0),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Expanded(
                 child: ElevatedButton(
                  onPressed: () { 
                    if( kodemember == false ) {
                      setState(() {
                        kodemember = true;
                      });
                    }
                    else{
                      kodemember = false;
                      setState(() {
                        kodemember = false;
                      });
                    }
                   },
                  child: Text('Kode Member'),
                           ),
               ),
            SizedBox(height: 16.0),
            SizedBox(width: 16),
            Expanded(
            child: ElevatedButton(
                //onPressed: _tampilkan,
                onPressed: () {  },
                child: Text('Bayar'),
              ),
          ),

            ],
          ),
          
          
        )
        ]),
        

      );
    
  }
}
