import 'package:get/get.dart';
import 'package:trreu/services/review_service.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:flutter/material.dart';

class ReviewController extends GetxController {
  final ReviewService _reviewService = ReviewService();

  var isLoading = false.obs;
  TextEditingController commentController = TextEditingController();

  var rating = 0.0.obs; // you can bind rating stars here if you want

  Future<void> submitReview() async {
    if (rating.value <= 0) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Please provide a rating',
        backgroundColor: Colors.red,
      );
      return;
    }
    if (commentController.text.trim().isEmpty) {
      commonSnackbar(
        title: 'Validation Error',
        message: 'Please write a comment',
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isLoading.value = true;
      final response = await _reviewService.addReview({
        'rating': rating.value,
        'comment': commentController.text.trim(),
      });

      if (response.success) {
        commonSnackbar(
          title: 'Success',
          message: response.message,
          backgroundColor: Colors.green,
        );
        commentController.clear();
        rating.value = 0.0;
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
    commentController.dispose();
    super.onClose();
  }
}
