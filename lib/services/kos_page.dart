import 'package:flutter/material.dart';
import '../services/api_service.dart';

class KostPage extends StatefulWidget {
  @override
  State<KostPage> createState() => _KostPageState();
}

class _KostPageState extends State<KostPage> {
  List kost = [];

  @override
  void initState() {
    super.initState();
    loadKost();
  }

  void loadKost() async {
    final data = await ApiService.getKost();
    setState(() {
      kost = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Kost')),
      body: ListView.builder(
        itemCount: kost.length,
        itemBuilder: (context, i) {
          final k = kost[i];
          return ListTile(
            title: Text(k['nama_kost']),
            subtitle: Text(k['kategori']['nama_kategori']),
            trailing: Text("Rp ${k['harga']}"),
          );
        },
      ),
    );
  }
}