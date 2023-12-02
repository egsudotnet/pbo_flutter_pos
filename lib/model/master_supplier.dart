class Supplier {
  final int? id;
  final String nama;
  final String alamat;

  Supplier({this.id, required this.nama, required this.alamat});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      nama: map['nama'],
      alamat: map['alamat'],
    );
  }
}
