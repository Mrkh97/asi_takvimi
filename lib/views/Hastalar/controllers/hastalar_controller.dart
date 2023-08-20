import 'package:asi_takvimi/constants/snack_bars.dart';
import 'package:asi_takvimi/models/hasta.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HastalarController extends GetxController {
  @override
  void onReady() async {
    await openDb('asi_takvimi.db');
    getHastalar();
    filterWorker = ever(selectedFilterId, (callback) {
      var today = DateTime.now();
      if (selectedFilterId.value == -1) {
        filteredHastalar.value = hastalar;
      }
      if (selectedFilterId.value == 0) {
        //     "0":"0 aylık doğumda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year, element.dogumTarihi.month,
                      element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 1,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 1) {
        //     "1":"1 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 1, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 2,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 2) {
        //     "2":"2 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 2, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 3,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 3) {
        //     "3":"4 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 3, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 5,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 4) {
        //     "4":"6 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 5, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 7,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 5) {
        //     "5":"9 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 7, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 10,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 6) {
        //     "6":"12 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 10, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 13,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 7) {
        //     "7":"18 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 13, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 19,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 8) {
        //     "8":"24 Ayın Sonunda",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 19, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year, element.dogumTarihi.month + 25,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 9) {
        //     "9":"4 Yaşında",
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year,
                      element.dogumTarihi.month + 25, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year + 4, element.dogumTarihi.month,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
      if (selectedFilterId.value == 10) {
        //     "10":"13 Yaşında"
        filteredHastalar.value = hastalar.where((element) {
          return DateTime(element.dogumTarihi.year + 4,
                      element.dogumTarihi.month, element.dogumTarihi.day)
                  .isBefore(today) &&
              DateTime(element.dogumTarihi.year + 14, element.dogumTarihi.month,
                      element.dogumTarihi.day - 1)
                  .isAfter(today);
        }).toList();
      }
    });
    super.onReady();
  }

  late Database db;

  var hastaInsertIsLoading = false.obs;
  var hastaUpdateIsLoading = false.obs;
  var hastaDeleteIsLoading = false.obs;
  var hastaListIsLoading = false.obs;

  var selectedFilterId = (-1).obs;

  RxList<Hasta> hastalar = <Hasta>[].obs;
  RxList<Hasta> filteredHastalar = <Hasta>[].obs;

  late Worker filterWorker;

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
      filteredHastalar.value = hastalar;
      selectedFilterId.value = -1;
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
