import 'package:asi_takvimi/constants/app_colors.dart';
import 'package:asi_takvimi/views/Hastalar/components/hasta_ekle.dart';
import 'package:asi_takvimi/views/Hastalar/controllers/hastalar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/hasta.dart';

class Hastalar extends StatelessWidget {
  Hastalar({super.key});
  final HastalarController hs = Get.put(HastalarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => HastaEkle(), transition: Transition.rightToLeftWithFade);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Hastalar'),
      ),
      body: Obx(() => ListView(
            children: [
              ...hs.hastalar.map((hasta) => HastaCard(
                    hasta: hasta,
                  ))
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
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyAppColors.baseColor),
      ),
    );
  }
}
