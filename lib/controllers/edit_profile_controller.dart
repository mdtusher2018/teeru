import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trreu/controllers/profile_controller.dart';
import 'package:trreu/services/local_storage_service.dart';
import 'package:trreu/services/user_service.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class EditProfileController extends GetxController {
  final UserService _userService = UserService();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  var profileImage = Rxn<File>();
  var coverImage = Rxn<File>();

  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  final ProfileController controller = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = controller.userProfile.value!.fullName;
    emailController.text = controller.userProfile.value!.email;
    phoneController.text = controller.userProfile.value!.phone;
    locationController.text = controller.userProfile.value!.address;
  }

  Future<void> pickProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickCoverImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfile() async {
    if (fullNameController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Error',
        message: 'Full name is required',
        backgroundColor: Colors.red,
      );
      return;
    }
    // Add more validations if needed

    try {
      isLoading.value = true;

      final profileData = {
        'fullName': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': locationController.text.trim(),
      };

      final token = await LocalStorageService().getToken() ?? '';

      log(token);

      final response = await _userService.updateProfile(
        data: profileData,
        profileImage: profileImage.value,
        coverImage: coverImage.value,
        token: token,
      );

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );
      } else {
        commonSnackbar(
          title: 'Failed',
          message: response.message,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
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
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
