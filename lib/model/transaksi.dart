class Transaksi {
  final int? id;
  final int barangId;
  final int jumlah;
  final double harga;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barangId': barangId,
      'jumlah': jumlah,
      'harga': harga,
    };
  }

  Transaksi({this.id, required this.barangId, required this.jumlah, required this.harga});
}
