import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLanguageController extends GetxController {
  void changeLanuage(var param) {
    var locate = Locale(param);
    Get.updateLocale(locate);
  }
}
