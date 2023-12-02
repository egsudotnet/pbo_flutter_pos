import 'package:flutter/material.dart';

import 'page/master_barang/index.dart';
import 'page/master_supplier/index.dart';
import 'page/transaksi_penjualan/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Flutter'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/flutter_image.jpg"),
                      fit: BoxFit.cover)),
              accountName: Text(""),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/contoh-image.jpg'), // Ganti dengan gambar profil Anda sendiri
              ),
            ),
            const Divider(), // Garis pemisah
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Master Barang'),
              onTap: () {
                // Tambahkan logika untuk keluar dari aplikasi di sini
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeBarangScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Master Supplier'),
              onTap: () {
                // Tambahkan logika untuk keluar dari aplikasi di sini
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeSupplierScreen()));
              },
            ),
            const Divider(), // Garis pemisah
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Penjualan'),
              onTap: () {
                // Tambahkan logika untuk keluar dari aplikasi di sini
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransaksiPenjualan()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Konten Utama Aplikasi'),
      ),
    );
  }
}
