import 'package:asi_takvimi/constants/app_colors.dart';
import 'package:asi_takvimi/views/Hastalar/components/hasta_detay.dart';
import 'package:asi_takvimi/views/Hastalar/components/hasta_ekle.dart';
import 'package:asi_takvimi/views/Hastalar/controllers/hastalar_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/hasta.dart';

class Hastalar extends StatelessWidget {
  Hastalar({super.key});
  final HastalarController hc = Get.put(HastalarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyAppColors.darkBlue,
        foregroundColor: MyAppColors.baseColor,
        onPressed: () {
          Get.to(() => HastaEkle(), transition: Transition.rightToLeftWithFade);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Hastalar'),
        actions: [
          Obx(
            () => DropdownButton2(
                value: hc.selectedFilterId(),
                underline: Container(),
                buttonStyleData: ButtonStyleData(
                    height: 44,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8))),
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyAppColors.baseColor),
                    elevation: 4),
                items: const [
                  DropdownMenuItem(value: -1, child: Text('Tumu')),
                  DropdownMenuItem(value: 0, child: Text('0 aylık doğumda')),
                  DropdownMenuItem(value: 1, child: Text('1 Ayın Sonunda')),
                  DropdownMenuItem(value: 2, child: Text('2 Ayın Sonunda')),
                  DropdownMenuItem(value: 3, child: Text('4 Ayın Sonunda')),
                  DropdownMenuItem(value: 4, child: Text('6 Ayın Sonunda')),
                  DropdownMenuItem(value: 5, child: Text('9 Ayın Sonunda')),
                  DropdownMenuItem(value: 6, child: Text('12 Ayın Sonunda')),
                  DropdownMenuItem(value: 7, child: Text('18 Ayın Sonunda')),
                  DropdownMenuItem(value: 8, child: Text('24 Ayın Sonunda')),
                  DropdownMenuItem(value: 9, child: Text('4 Yaşında')),
                  DropdownMenuItem(value: 10, child: Text('13 Yaşında')),
                ],
                onChanged: (e) {
                  hc.selectedFilterId(e);
                }),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: Obx(() => ListView(
            children: [
              if (hc.hastaListIsLoading.value)
                SizedBox(
                  height: 72,
                  child: Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: MyAppColors.darkBlue, size: 32),
                  ),
                ),
              if (hc.hastalar.isEmpty && !hc.hastaListIsLoading.value)
                const SizedBox(
                  height: 72,
                  child: Center(
                    child: Text(
                      'Hasta bulunamadı',
                      style: TextStyle(
                          color: MyAppColors.darkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ...hc.filteredHastalar.map(
                (hasta) => HastaCard(
                  hasta: hasta,
                ),
              ),
            ],
          )),
    );
  }
}

class HastaCard extends StatelessWidget {
  const HastaCard({super.key, required this.hasta});
  final Hasta hasta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () {
          Get.to(
              () => HastaDetay(
                    hasta: hasta,
                  ),
              transition: Transition.rightToLeftWithFade);
        },
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyAppColors.lightBlue),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        hasta.adSoyad,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MyAppColors.darkBlue),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        hasta.telefon,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.darkBlue),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${hasta.konteynerKentIsim} - ${hasta.konteynerKentNumarasi}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.darkBlue),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: MyAppColors.darkBlue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
