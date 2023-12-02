import 'package:flutter/material.dart';

import '../../helper/database.dart';
import '../../model/master_barang.dart';

// void main() {
//   runApp(TransaksiPenjualan());
// }

class SaleItem {
  final String name;
  final double price;

  SaleItem(this.name, this.price);
}

class TransaksiPenjualan extends StatefulWidget {

  TransaksiPenjualan({super.key});

  @override
  State<TransaksiPenjualan> createState() => _TransaksiPenjualanState();
}

class _TransaksiPenjualanState extends State<TransaksiPenjualan> {
  final List<SaleItem> _sales = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  var instance = DatabaseHelper.instance;
  List<Barang> daftarBarang = [];
  List<Barang> listBarangDipilih = [];
  
  Barang? barangDipilih; // Variabel untuk menyimpan barang yang dipilih



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


  double calculateTotal() {
    double total = 0.0;
    for (var item in _sales) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplikasi Penjualan'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[ 

                  Expanded(
                    child: DropdownButton<Barang>(
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
                  ),


                  // TextField(
                  //   controller: _priceController,
                  //   decoration: const InputDecoration(labelText: 'Harga Item'),
                  //   keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  // ),
                  IconButton(
                    onPressed: () {
                      String name = _nameController.text;
                      double price = double.tryParse(_priceController.text) ?? 0.0;
                      if (name.isNotEmpty && price > 0) {
                        _sales.add(SaleItem(name, price));
                        _nameController.clear();
                        _priceController.clear();

                        
                      setState(() {
                        listBarangDipilih.add(Barang(nama: name, harga: price));
                      });
                        // setState(() {}); // Memperbarui tampilan
                      }
                    },
                    color: Colors.blue,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _sales.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_sales[index].name),
                    subtitle: Text('Harga: \$${_sales[index].price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Text('Total Penjualan: \$${calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
