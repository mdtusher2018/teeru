
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
Future<bool> requestLocationPermission() async {
  if (await Permission.location.isGranted) {
    return true;
  }
  var status = await Permission.location.request();

  if (status.isGranted) {
    return true;
  }

  if (status.isDenied) {
    Get.snackbar(
      "Permission Required",
      "Location access is required to use this app.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    // Close app if denied
    Future.delayed(const Duration(seconds: 2), () {
      SystemNavigator.pop();
    });
    return false;
  }

  if (status.isPermanentlyDenied) {
    Get.snackbar(
      "Permission Required",
      "Please enable Location permission in settings.",
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
    await openAppSettings();
    Future.delayed(const Duration(seconds: 2), () {
      SystemNavigator.pop();
    });
    return false;
  }
  return false;
}
