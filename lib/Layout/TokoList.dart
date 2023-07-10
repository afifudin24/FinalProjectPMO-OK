import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasir_euy/ClassService.dart/TokoService.dart';

import '../Class/TokoClass.dart';

class CrudToko extends StatefulWidget {
  const CrudToko({super.key});

  @override
  State<CrudToko> createState() => _CrudTokoState();
}

class _CrudTokoState extends State<CrudToko> {
  TokoService controller = TokoService();
  List<Toko> _toko = [];
  List<String> _id = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _loadID();
    print("OK");
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Toko> tokos = await controller.getItems();
    setState(() {
      _toko = tokos;
    });
  }

  Future<void> _loadID() async {
    List<String> documentIds = await controller.getDocumentIds();
    print('Document IDs: $documentIds');
    setState(() {
      _id = documentIds;
    });
    print(_id);
  }

  int getItemCount() {
    return _toko.length; // Mengembalikan panjang data sebagai jumlah item
  }

  @override
  Widget build(BuildContext context) {
    String? nullableValue = null; // Replace `null` with your actual value
    String nonNullableValue = nullableValue != null ? nullableValue : '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengguna'),
      ),
      body: buildView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            Toko newItem = Toko(
                idtoko: '128;;klk3gjh',
                email: 'Itemoojjlk 1hgjh',
                namatoko: 'Deslcr;kkiptjhgion 1',
                mottotoko: 'ok',
                adminToko: "Afif",
                urlImage:
                    "https://tse2.mm.bing.net/th?id=OIP.4gkSTMRl_8DsEquU0WTELgHaE8&pid=Api&P=0&h=180",
                alamat: 'ach',
                saldo: 0);
            controller.addItem(newItem);
            print("okbng");
            _loadUsers();
            refreshPage();
          });
        },
      ),
    );
  }

  Widget buildView() {
    return ListView.builder(
      itemCount: _toko.length,
      itemBuilder: (context, index) {
        Toko toko = _toko[index];

        return ListTile(
          title: Text(_id[index]),
          subtitle: Text(toko.namatoko),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              controller.deleteItem(_id[index]);
              _loadUsers();
              refreshPage();
            },
          ),
        );
      },
    );
  }

  void refreshPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CrudToko()),
    );
  }
}
