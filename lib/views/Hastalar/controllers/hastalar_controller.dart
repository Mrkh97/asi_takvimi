import 'package:asi_takvimi/models/hasta.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HastalarController extends GetxController {
  @override
  void onReady() async {
    await openDb('asi_takvimi.db');
    hastalar.value = await getHastalar();
    super.onReady();
  }

  late Database db;

  RxList<Hasta> hastalar = <Hasta>[].obs;

  Future openDb(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table hastalar ( 
          id integer primary key autoincrement, 
          adSoyad text not null,
          dogumTarihi text not null,
          konteynerKentIsim text not null,
          konteynerKentNumarasi integer not null)
        ''');
    });
  }

  Future<Hasta> insertHasta(Hasta hasta) async {
    hasta.id = await db.insert('hastalar', hasta.toMap());
    return hasta;
  }

  Future<Hasta?> getHasta(int id) async {
    List<Map<String, Object?>> maps = await db.query('hastalar',
        columns: [
          'id',
          'adSoyad',
          'dogumTarihi',
          'konteynerKentIsim',
          'konteynerKentNumarasi'
        ],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Hasta.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Hasta>> getHastalar() async {
    List<Map<String, Object?>> maps = await db.query('hastalar', columns: [
      'id',
      'adSoyad',
      'dogumTarihi',
      'konteynerKentIsim',
      'konteynerKentNumarasi'
    ]);
    if (maps.isNotEmpty) {
      return maps.map((e) => Hasta.fromMap(e)).toList();
    }
    return [];
  }

  Future<int> deleteHasta(int id) async {
    return await db.delete('hastalar', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateHasta(Hasta hasta) async {
    return await db.update('hastalar', hasta.toMap(),
        where: 'id = ?', whereArgs: [hasta.id]);
  }

  Future close() async => db.close();
}
