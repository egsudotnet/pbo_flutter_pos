import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../helper/database.dart';
import '../../model/master_supplier.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({super.key});

  @override
  _AddSupplierScreenState createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  var instance = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Supplier Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Supplier'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                tambahSupplier();
              },
              child: const Text('Tambah Supplier'),
            ),
          ],
        ),
      ),
    );
  }

  void tambahSupplier() {
    String nama = namaController.text;
    String alamat = alamatController.text;

    if (nama.isNotEmpty && alamat.isNotEmpty) {
      // Tambahkan supplier ke database
      instance.insertSupplier(Supplier(nama: nama,alamat: alamat));

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
