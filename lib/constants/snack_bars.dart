import 'package:asi_takvimi/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBars {
  static showErrorSnackBar(String title, String message) {
    Get.showSnackbar(GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(8),
      titleText: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      messageText: Text(
        message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      duration: const Duration(seconds: 4),
      borderRadius: 12,
      barBlur: 8,
      backgroundColor: Colors.red.shade300.withOpacity(0.7),
    ));
  }

  static showSuccessSnackBar(String title, String message) {
    Get.showSnackbar(GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(8),
      titleText: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      messageText: Text(
        message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      duration: const Duration(seconds: 4),
      borderRadius: 12,
      barBlur: 8,
      backgroundColor: Colors.green.shade300.withOpacity(0.6),
    ));
  }

  static showSnackBar(String title, String message) {
    Get.showSnackbar(GetSnackBar(
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(8),
      titleText: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyAppColors.baseColor),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
            color: MyAppColors.baseColor,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      duration: const Duration(seconds: 4),
      borderRadius: 12,
      barBlur: 8,
      backgroundColor: MyAppColors.midBlue.withOpacity(0.5),
    ));
  }
}
