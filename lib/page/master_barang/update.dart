import 'package:flutter/material.dart';
import '../../helper/database.dart';
import '../../model/master_barang.dart';

class UpdateBarangScreen extends StatefulWidget {
  final Barang barang;

  UpdateBarangScreen({required this.barang});

  @override
  _UpdateBarangScreenState createState() => _UpdateBarangScreenState();
}

class _UpdateBarangScreenState extends State<UpdateBarangScreen> {
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  var instance = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    namaController.text = widget.barang.nama;
    hargaController.text = widget.barang.harga.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Barang'),
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
                perbaruiBarang();
              },
              child: const Text('Perbarui Barang'),
            ),
          ],
        ),
      ),
    );
  }

  void perbaruiBarang() {
    String nama = namaController.text;
    double harga = double.tryParse(hargaController.text) ?? 0.0;

    if (nama.isNotEmpty && harga > 0) {
      // Perbarui barang di database      
      instance.updateBarang(Barang(id: widget.barang.id, nama: nama,harga: harga));

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
