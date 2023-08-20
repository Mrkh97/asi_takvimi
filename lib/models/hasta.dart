class Hasta {
  int? id;
  String adSoyad;
  String telefon;
  DateTime dogumTarihi;
  String tc;
  String konteynerKentIsim;
  String konteynerKentNumarasi;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      if (id != null) 'id': id,
      'adSoyad': adSoyad,
      'telefon': telefon,
      'dogumTarihi': dogumTarihi.toIso8601String(),
      'tc': tc,
      'konteynerKentIsim': konteynerKentIsim,
      'konteynerKentNumarasi': konteynerKentNumarasi,
    };
    return map;
  }

  Hasta(
      {this.id,
      required this.adSoyad,
      required this.telefon,
      required this.dogumTarihi,
      required this.tc,
      required this.konteynerKentIsim,
      required this.konteynerKentNumarasi});

  factory Hasta.fromMap(Map<String, Object?> map) => Hasta(
        id: map['id'] as int,
        adSoyad: map['adSoyad'] as String,
        telefon: map['telefon'] as String,
        dogumTarihi: DateTime.parse(map['dogumTarihi'] as String),
        tc: map['tc'] as String,
        konteynerKentIsim: map['konteynerKentIsim'] as String,
        konteynerKentNumarasi: map['konteynerKentNumarasi'] as String,
      );
}
