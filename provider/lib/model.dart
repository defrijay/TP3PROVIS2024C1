class Event {
  final int id;
  final String namaAcara;
  final String tanggalWaktu;
  final String lokasi;
  final String deskripsi;
  final List<Artist> artis;

  Event({
    required this.id,
    required this.namaAcara,
    required this.tanggalWaktu,
    required this.lokasi,
    required this.deskripsi,
    required this.artis,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      namaAcara: json['informasi_acara']['nama_acara'],
      tanggalWaktu: json['informasi_acara']['tanggal_waktu'],
      lokasi: json['informasi_acara']['lokasi'],
      deskripsi: json['informasi_acara']['deskripsi'],
      artis: (json['daftar_artis'] as List<dynamic>).map((artist) => Artist.fromJson(artist)).toList(),
    );
  }
}

class Artist {
  final String nama;
  final String genre;

  Artist({required this.nama, required this.genre});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      nama: json['nama'],
      genre: json['genre'],
    );
  }
}