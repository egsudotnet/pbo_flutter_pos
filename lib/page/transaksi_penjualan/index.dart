import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../helper/database.dart';
import '../../model/master_barang.dart';
import '../../model/transaksi.dart';
 
 
// class TransaksiPenjualan extends StatelessWidget {
//   final List<Barang> daftarBarang = [
//     Barang(id: 1, nama: 'Item 1', harga: 10.0),
//     Barang(id: 2, nama: 'Item 2', harga: 15.0),
//     // Tambahkan barang lain sesuai kebutuhan
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TransaksiPenjualan(daftarBarang: daftarBarang),
//     );
//   }
// }

class TransaksiPenjualan extends StatefulWidget {
  const TransaksiPenjualan({super.key});

  @override
  _TransaksiPenjualanState createState() => _TransaksiPenjualanState();
}

class _TransaksiPenjualanState extends State<TransaksiPenjualan> {
  Barang? barangDipilih;
  int jumlahBarang = 0;
  var instance = DatabaseHelper.instance;
  List<Barang> daftarBarang = [];
  
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  
  void fetchData() async {
    List<Barang> result = await instance.queryAllBarangs();
    setState(() {
      daftarBarang = result;
    });
  }

  void tambahTransaksi() async {
    if (barangDipilih != null && jumlahBarang > 0) {
      // // // var uuid = Uuid();
      // // // String uniqueId = uuid.v4();
      Transaksi transaksi = Transaksi(barangId: barangDipilih!.id!, jumlah: jumlahBarang, harga : barangDipilih!.harga);
      int id = await instance.insertTransaksi(transaksi);
      print('Transaksi baru ditambahkan dengan ID: $id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Penjualan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<Barang>(
              value: barangDipilih,
              onChanged: (Barang? newValue) {
                setState(() {
                  barangDipilih = newValue;
                });
              },
              items: daftarBarang.map((Barang barang) {
                return DropdownMenuItem<Barang>(
                  value: barang,
                  child: Text(barang.nama),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jumlah Barang'),
              onChanged: (value) {
                setState(() {
                  jumlahBarang = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                tambahTransaksi();
                // Kosongkan pilihan barang dan jumlah setelah transaksi ditambahkan
                setState(() {
                  barangDipilih = null;
                  jumlahBarang = 0;
                });
              },
              child: const Text('Tambah Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
