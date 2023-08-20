import 'package:asi_takvimi/constants/app_colors.dart';
import 'package:asi_takvimi/constants/utils.dart';
import 'package:asi_takvimi/models/hasta.dart';
import 'package:asi_takvimi/views/Hastalar/components/hasta_guncelle.dart';
import 'package:asi_takvimi/views/Hastalar/controllers/hastalar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HastaDetay extends StatelessWidget {
  HastaDetay({super.key, required this.hasta});
  final HastalarController hc = Get.find();
  final Hasta hasta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasta Detay'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => HastaGuncelle(hasta: hasta),
                  transition: Transition.rightToLeftWithFade);
            },
            icon: const Icon(Icons.edit),
            color: MyAppColors.darkBlue,
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Uyarı',
                titleStyle: const TextStyle(
                    color: MyAppColors.darkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                middleText: 'Hasta silinecektir emin misiniz?',
                middleTextStyle: const TextStyle(
                    color: MyAppColors.darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                cancel: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyAppColors.midBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    Get.back();
                  },
                  child: const SizedBox(
                      width: 60,
                      child: Text(
                        'Hayır',
                        textAlign: TextAlign.center,
                      )),
                ),
                confirm: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    hc.deleteHasta(hasta.id!);
                  },
                  child: SizedBox(
                    width: 60,
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          hc.hastaUpdateIsLoading.value
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: LoadingAnimationWidget.discreteCircle(
                                      color: Colors.white, size: 20),
                                )
                              : Container(),
                          const Text('Evet'),
                        ],
                      );
                    }),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete),
            color: MyAppColors.darkBlue,
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Ad Soyad'),
            subtitle: Text(hasta.adSoyad),
          ),
          ListTile(
            title: const Text('Telefon'),
            subtitle: Text(hasta.telefon),
          ),
          ListTile(
            title: const Text('Doğum Tarihi'),
            subtitle: Text(MyUtils.formatedDate(hasta.dogumTarihi)),
          ),
          ListTile(
            title: const Text('TC No'),
            subtitle: Text(hasta.tc),
          ),
          ListTile(
            title: const Text('Konteyner Kent İsim'),
            subtitle: Text(hasta.konteynerKentIsim),
          ),
          ListTile(
            title: const Text('Konteyner Kent Numarası'),
            subtitle: Text(hasta.konteynerKentNumarasi),
          ),
        ],
      ),
    );
  }
}
