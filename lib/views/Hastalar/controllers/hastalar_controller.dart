import 'package:asi_takvimi/constants/snack_bars.dart';
import 'package:asi_takvimi/models/hasta.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HastalarController extends GetxController {
  @override
  void onReady() async {
    await openDb('asi_takvimi.db');
    getHastalar();
    super.onReady();
  }

  late Database db;

  var hastaInsertIsLoading = false.obs;
  var hastaUpdateIsLoading = false.obs;
  var hastaDeleteIsLoading = false.obs;
  var hastaListIsLoading = false.obs;

  RxList<Hasta> hastalar = <Hasta>[].obs;

  Future openDb(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table hastalar ( 
          id integer primary key autoincrement, 
          adSoyad text not null,
          telefon text not null,
          dogumTarihi text not null,
          tc text not null,
          konteynerKentIsim text not null,
          konteynerKentNumarasi text not null)
        ''');
    });
  }

  Future insertHasta(Hasta hasta) async {
    try {
      hastaInsertIsLoading.value = true;
      hasta.id = await db.insert('hastalar', hasta.toMap());
      hastaInsertIsLoading.value = false;
      Get.until((route) => Get.currentRoute == '/');
      MySnackBars.showSuccessSnackBar('Başarılı', 'Hasta eklendi');
      getHastalar();
    } catch (e) {
      MySnackBars.showErrorSnackBar('Hata', e.toString());
      hastaInsertIsLoading.value = false;
    }
  }

  Future<Hasta?> getHasta(int id) async {
    List<Map<String, Object?>> maps = await db.query('hastalar',
        columns: [
          'id',
          'adSoyad',
          'telefon',
          'dogumTarihi',
          'tc',
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

  Future getHastalar() async {
    hastaListIsLoading.value = true;
    List<Map<String, Object?>> maps = await db.query('hastalar', columns: [
      'id',
      'adSoyad',
      'telefon',
      'dogumTarihi',
      'tc',
      'konteynerKentIsim',
      'konteynerKentNumarasi'
    ]);
    hastaListIsLoading.value = false;
    if (maps.isNotEmpty) {
      hastalar.value = maps.map((e) => Hasta.fromMap(e)).toList();
    } else {
      hastalar.clear();
    }
  }

  Future deleteHasta(int id) async {
    try {
      hastaDeleteIsLoading.value = true;
      await db.delete('hastalar', where: 'id = ?', whereArgs: [id]);
      MySnackBars.showSuccessSnackBar('Başarılı', 'Hasta silindi');
      getHastalar();
      hastaDeleteIsLoading.value = false;
      Get.until((route) => Get.currentRoute == '/');
    } catch (e) {
      hastaDeleteIsLoading.value = false;
      MySnackBars.showErrorSnackBar('Hata', e.toString());
    }
  }

  Future updateHasta(Hasta hasta) async {
    try {
      hastaUpdateIsLoading.value = true;
      await db.update('hastalar', hasta.toMap(),
          where: 'id = ?', whereArgs: [hasta.id]);
      MySnackBars.showSuccessSnackBar('Başarılı', 'Hasta güncellendi');
      getHastalar();
      hastaUpdateIsLoading.value = false;
      Get.until((route) => Get.currentRoute == '/');
    } catch (e) {
      MySnackBars.showErrorSnackBar('Hata', e.toString());
      hastaUpdateIsLoading.value = false;
    }
  }

  Future close() async => db.close();
}
