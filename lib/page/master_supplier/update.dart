import 'package:flutter/material.dart';
import '../../helper/database.dart';
import '../../model/master_supplier.dart';

class UpdateSupplierScreen extends StatefulWidget {
  final Supplier supplier;

  UpdateSupplierScreen({required this.supplier});

  @override
  _UpdateSupplierScreenState createState() => _UpdateSupplierScreenState();
}

class _UpdateSupplierScreenState extends State<UpdateSupplierScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  var instance = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    namaController.text = widget.supplier.nama;
    alamatController.text = widget.supplier.alamat.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Supplier'),
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
                perbaruiSupplier();
              },
              child: const Text('Perbarui Supplier'),
            ),
          ],
        ),
      ),
    );
  }

  void perbaruiSupplier() {
    String nama = namaController.text;
    String alamat = alamatController.text;

    if (nama.isNotEmpty && alamat.isNotEmpty) {
      // Perbarui supplier di database      
      instance.updateSupplier(Supplier(id: widget.supplier.id, nama: nama,alamat: alamat));

      // Kembali ke halaman sebelumnya setelah memperbarui
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
