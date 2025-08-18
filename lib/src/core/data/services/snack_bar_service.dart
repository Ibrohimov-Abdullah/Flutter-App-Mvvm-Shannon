import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  // Static method for success snackbar
  static void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 10,
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeInOut,
    );
  }

  // Static method for error snackbar
  static void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 10,
      icon: Icon(Icons.error, color: Colors.white),
      duration: Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeInOut,
    );
  }

  // Static method for failure snackbar
  static void showFailure(String message) {
    Get.snackbar(
      'Failure',
      message,
      backgroundColor: Colors.orange.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 10,
      icon: Icon(Icons.warning, color: Colors.white),
      duration: Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeInOut,
    );
  }
}