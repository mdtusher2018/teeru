// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: commonTextfield(
                    height: 40.0,
                    enable: false,
                    searchController,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.cancel),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
