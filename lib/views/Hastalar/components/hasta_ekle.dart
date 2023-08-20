import 'package:asi_takvimi/constants/input_borders.dart';
import 'package:flutter/material.dart';

class HastaEkle extends StatelessWidget {
  const HastaEkle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasta Ekle'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              decoration: InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Ad Soyad'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              decoration: InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Ad Soyad'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              decoration: InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Ad Soyad'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              decoration: InputDecoration(
                  border: MyInputBorders.baslikBorderRounded,
                  labelText: 'Ad Soyad'),
            ),
          ),
        ],
      )),
    );
  }
}
