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

  @override
  void initState() {
    super.initState();
    _loadUsers();
    print("OK");
  }

  Future<void> _loadUsers() async {
    print("lah");
    List<Toko> tokos = await controller.getItems();
    setState(() {
      _toko = tokos;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? nullableValue = null; // Replace `null` with your actual value
    String nonNullableValue = nullableValue != null ? nullableValue : '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengguna'),
      ),
      body: ListView.builder(
        itemCount: _toko.length,
        itemBuilder: (context, index) {
          Toko toko = _toko[index];
          return ListTile(
            title: Text(toko.idtoko),
            subtitle: Text(toko.namatoko),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                controller.deleteItem(toko.idtoko);
                _loadUsers();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("OK");
        },
      ),
    );
  }
}
