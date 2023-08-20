import 'package:asi_takvimi/constants/app_colors.dart';
import 'package:asi_takvimi/constants/input_borders.dart';
import 'package:asi_takvimi/constants/snack_bars.dart';
import 'package:asi_takvimi/views/Hastalar/controllers/hastalar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../models/hasta.dart';

class HastaGuncelle extends StatelessWidget {
  HastaGuncelle({super.key, required this.hasta}) {
    adSoyadController.text = hasta.adSoyad;
    telefonController.text = hasta.telefon;
    tcController.text = hasta.tc;
    konteynerKentIsimController.text = hasta.konteynerKentIsim;
    konteynerKentNumaraController.text = hasta.konteynerKentNumarasi;
    dogumTarihi.value = hasta.dogumTarihi;
  }
  final HastalarController hc = Get.find();

  final Hasta hasta;

  final TextEditingController adSoyadController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController tcController = TextEditingController();
  final TextEditingController konteynerKentIsimController =
      TextEditingController();
  final TextEditingController konteynerKentNumaraController =
      TextEditingController();
  final Rx<DateTime> dogumTarihi = DateTime.now().obs;

  bool validateForm() {
    if (adSoyadController.text.isEmpty) {
      MySnackBars.showErrorSnackBar('Uyarı', 'Ad Soyad boş bırakılamaz');
      return false;
    }
    if (telefonController.text.isEmpty) {
      MySnackBars.showErrorSnackBar('Uyarı', 'Telefon boş bırakılamaz');
      return false;
    }
    if (tcController.text.isEmpty) {
      MySnackBars.showErrorSnackBar('Uyarı', 'TC\'no boş bırakılamaz');
      return false;
    }
    if (konteynerKentIsimController.text.isEmpty) {
      MySnackBars.showErrorSnackBar(
          'Uyarı', 'Konteyner Kent Isim boş bırakılamaz');
      return false;
    }
    if (konteynerKentNumaraController.text.isEmpty) {
      MySnackBars.showErrorSnackBar(
          'Uyarı', 'Konteyner Kent Numarasi boş bırakılamaz');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MyAppColors.darkBlue,
        foregroundColor: MyAppColors.baseColor,
        onPressed: () {
          if (validateForm()) {
            hc.updateHasta(Hasta(
                id: hasta.id,
                adSoyad: adSoyadController.text,
                telefon: telefonController.text,
                dogumTarihi: dogumTarihi.value,
                tc: tcController.text,
                konteynerKentIsim: konteynerKentIsimController.text,
                konteynerKentNumarasi: konteynerKentNumaraController.text));
          }
        },
        label: const Text('Güncelle'),
        icon: Obx(() => hc.hastaUpdateIsLoading()
            ? LoadingAnimationWidget.discreteCircle(
                color: MyAppColors.baseColor, size: 20)
            : const Icon(Icons.edit)),
      ),
      appBar: AppBar(
        title: const Text('Hasta Güncelle'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: adSoyadController,
              decoration: const InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Ad Soyad'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: telefonController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Telefon'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: GestureDetector(
              onTap: () async {
                var tempDate = DateTime.now();
                var datePickerRes = await showDatePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                            appBarTheme: const AppBarTheme(
                                backgroundColor: MyAppColors.midBlue,
                                foregroundColor: MyAppColors.baseColor)),
                        child: child!,
                      );
                    },
                    context: context,
                    initialDate: dogumTarihi.value,
                    firstDate: DateTime(
                        tempDate.year - 100, tempDate.month, tempDate.day),
                    lastDate: tempDate);
                if (datePickerRes == null) {
                  MySnackBars.showSnackBar('Uyarı', 'Tarih seçilmedi');
                } else {
                  dogumTarihi.value = datePickerRes;
                }
              },
              child: Container(
                height: 68,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Expanded(
                        child: Obx(
                      () => Text(
                        'Doğum Tarrihi: ${dogumTarihi.value.day}/${dogumTarihi.value.month}/${dogumTarihi.value.year}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey.shade800),
                      ),
                    )),
                    Icon(Icons.date_range_rounded, color: Colors.grey.shade600)
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: tcController,
              decoration: const InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'TC\'no'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: konteynerKentIsimController,
              decoration: const InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Konteyner Kent Isim'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: konteynerKentNumaraController,
              decoration: const InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Konteyner Kent Numarasi'),
            ),
          ),
        ],
      )),
    );
  }
}
