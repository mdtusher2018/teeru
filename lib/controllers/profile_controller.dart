import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/models/profile_model.dart';

import 'package:trreu/services/user_service.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class ProfileController extends GetxController {
  final UserService _userService = UserService();

  var isLoading = false.obs;
  var userProfile = Rxn<UserProfile>();

  Future<void> fetchProfile() async {
    log("hi");
    try {
      isLoading.value = true;
      final response = await _userService.fetchProfile();

      if (response.success) {
        userProfile.value = response.data;
      } else {
        commonSnackbar(
          title: 'Error',
          message: response.message,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      log(e.toString());
      commonSnackbar(
        title: 'Error',
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
}
