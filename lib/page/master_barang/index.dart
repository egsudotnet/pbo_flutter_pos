import 'package:flutter/material.dart';
import 'package:praktikum_flutter_pbo_pos/helper/database.dart';
import '../../model/master_barang.dart';
import 'create.dart';
import 'update.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Barang> barangs = [];
  var instance = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Barang> result = await instance.queryAllBarangs();
    setState(() {
      barangs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
      ),
      body: ListView.builder(
        itemCount: barangs.length,
        itemBuilder: (context, index) {
          Barang barang = barangs[index];
          return ListTile(
            title: Text(barang.nama),
            subtitle: Text('Harga: Rp.${barang.harga.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteBarang(context,barang.id!);
              },
            ),
            onLongPress: (){              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UpdateBarangScreen(barang: barang,)),
              ).then((result) {
                if (result == true) {
                  fetchData(); // Memuat ulang daftar barang
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // // Navigasi ke halaman tambah barang baru
          // // Contoh:
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddBarangScreen()),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBarangScreen()),
          ).then((result) {
            if (result == true) {
              fetchData(); // Memuat ulang daftar barang
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // void deleteBarang(int id) async {
  //   int result = await DatabaseHelper.instance.deleteBarang(id);
  //   if (result > 0) {
  //     fetchData();
  //   }
  // }
  void deleteBarang(BuildContext context, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus barang ini?'),
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
              // Hapus barang dari database
              int result = await instance.deleteBarang(id);
              if (result > 0) {
                fetchData(); // Memuat ulang daftar barang setelah penghapusan
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
