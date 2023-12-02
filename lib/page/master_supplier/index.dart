import 'package:flutter/material.dart';
import '/helper/database.dart';
import '../../model/master_supplier.dart';
import 'create.dart';
import 'update.dart';

class HomeSupplierScreen extends StatefulWidget {
  const HomeSupplierScreen({super.key});

  @override
  _HomeSupplierScreenState createState() => _HomeSupplierScreenState();
}

class _HomeSupplierScreenState extends State<HomeSupplierScreen> {
  List<Supplier> suppliers = [];
  var instance = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Supplier> result = await instance.queryAllSuppliers();
    setState(() {
      suppliers = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Supplier'),
      ),
      body: ListView.builder(
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          Supplier supplier = suppliers[index];
          return ListTile(
            title: Text(supplier.nama),
            subtitle: Text('${supplier.alamat}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteSupplier(context,supplier.id!);
              },
            ),
            onLongPress: (){              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UpdateSupplierScreen(supplier: supplier,)),
              ).then((result) {
                if (result == true) {
                  fetchData(); // Memuat ulang daftar supplier
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // // Navigasi ke halaman tambah supplier baru
          // // Contoh:
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddSupplierScreen()),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSupplierScreen()),
          ).then((result) {
            if (result == true) {
              fetchData(); // Memuat ulang daftar supplier
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteSupplier(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus supplier ini?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
            },
          ),
          TextButton(
            child: const Text('Hapus'),
            onPressed: () async {
              // Hapus supplier dari database
              int result = await instance.deleteSupplier(id);
              if (result > 0) {
                fetchData(); // Memuat ulang daftar supplier setelah penghapusan
                Navigator.of(context).pop(); // Tutup dialog
              }
            },
          ),
        ],
      );
    },
  );
}

}
