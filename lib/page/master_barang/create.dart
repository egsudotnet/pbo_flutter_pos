import 'package:flutter/material.dart';

import '../../helper/database.dart';
import '../../model/master_barang.dart';

class AddBarangScreen extends StatefulWidget {
  const AddBarangScreen({super.key});

  @override
  _AddBarangScreenState createState() => _AddBarangScreenState();
}

class _AddBarangScreenState extends State<AddBarangScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  var instance = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Barang'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(labelText: 'Harga (contoh: 10.00)'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                tambahBarang();
              },
              child: const Text('Tambah Barang'),
            ),
          ],
        ),
      ),
    );
  }

  void tambahBarang() {
    String nama = namaController.text;
    double harga = double.tryParse(hargaController.text) ?? 0.0;

    if (nama.isNotEmpty && harga > 0) {
      // Tambahkan barang ke database
      instance.insertBarang(Barang(nama: nama,harga: harga));

      // Kembali ke halaman sebelumnya setelah menambahkan
      // Navigator.pop(context);
      Navigator.pop(context, true);
    } else {
      // Tampilkan pesan kesalahan jika input tidak valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua kolom dengan benar.'),
        ),
      );
    }
  }
}
