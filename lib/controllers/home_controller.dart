import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/services/ads_service.dart';
import 'package:trreu/services/event_and_category_service.dart';
import 'package:geolocator/geolocator.dart'; // 👈 add this

class HomeController extends GetxController {
  final EventService _eventService = EventService();
  final AdsService _adsService = AdsService();

  var slidingText=''.obs;

  var isLoadingCategories = false.obs;
  var isLoadingEvents = false.obs;

  var categories = <Category>[].obs;
  var upcomingEvents = <Event>[].obs;
  var address = 'Address Loading...'.obs;

  @override
  void onInit() {
    super.onInit();
        fetchCurrentAddress(); 
    fetchCategories();
    fetchUpcomingEvents();
    fetchSlidingText();
  }



  Future<void> fetchCurrentAddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value =
            "${place.administrativeArea}, ${place.country}";
        log("User Address: ${address.value}");
      } else {
        address.value = "Address not found";
      }
    } catch (e) {
      debugPrint("Error fetching address: $e");
      address.value = "N/A";
    }
  }

  fetchSlidingText() async {
    try {
      final response = await _adsService.fetchSlidingText();
      if (response.success) {
        slidingText.value = response.data.text;
      } else {
        log('Failed to fetch sliding text: ${response.message}');
      }
    } catch (e) {
      log('Error fetching sliding text: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final response = await _eventService.fetchCategories();
      // categories.value = response.data.result;
categories.addAll(response.data.result);
      log(response.data.result.length.toString());
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> fetchUpcomingEvents() async {
    try {
      log(">>>>>>>>>>>>>>>>location");
         // 👇 Get current location before API call
      Position position = await Geolocator.getCurrentPosition();
      log(position.longitude.toString()+">>>>>>>>>>>>>>>>location");
      isLoadingEvents.value = true;
      final response = await _eventService.fetchUpcomingEvents(position.longitude,position.latitude);
      upcomingEvents.value = response.data;
    } catch (e) {
      debugPrint('Error fetching upcoming events: $e');
    } finally {
      isLoadingEvents.value = false;
    }
  }
}
