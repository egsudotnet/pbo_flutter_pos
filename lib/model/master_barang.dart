
class Barang {
  final int? id;
  final String nama;
  final double harga;

  Barang({this.id, required this.nama, required this.harga});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'],
      nama: map['nama'],
      harga: map['harga'],
    );
  }
}
