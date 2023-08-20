class Hasta {
  int id;
  String adSoyad;
  String telefon;
  DateTime dogumTarihi;
  String konteynerKentIsim;
  int konteynerKentNumarasi;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'adSoyad': adSoyad,
      'telefon': telefon,
      'dogumTarihi': dogumTarihi,
      'konteynerKentIsim': konteynerKentIsim,
      'konteynerKentNumarasi': konteynerKentNumarasi,
    };
    return map;
  }

  Hasta(
      {required this.id,
      required this.adSoyad,
      required this.telefon,
      required this.dogumTarihi,
      required this.konteynerKentIsim,
      required this.konteynerKentNumarasi});

  factory Hasta.fromMap(Map<String, Object?> map) => Hasta(
        id: map['id'] as int,
        adSoyad: map['adSoyad'] as String,
        telefon: map['telefon'] as String,
        dogumTarihi: DateTime.parse(map['dogumTarihi'] as String),
        konteynerKentIsim: map['konteynerKentIsim'] as String,
        konteynerKentNumarasi: map['konteynerKentNumarasi'] as int,
      );
}
