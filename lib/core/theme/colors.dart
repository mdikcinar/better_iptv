import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorTable {}

Color get getTextColor => Get.isDarkMode ? Colors.white : const Color.fromARGB(255, 107, 107, 107);
Color get getReversedTextColor => Get.isDarkMode ? Colors.black : Colors.white;
