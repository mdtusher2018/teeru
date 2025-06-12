import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:trreu/AppTranslations.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/splash_page.dart';

import 'payment/keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',

      translations: AppTranslations(), // <-- Add this
      locale: const Locale('en', 'US'), // default language
      fallbackLocale: const Locale('en', 'US'), // fallback if wrong locale

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}


//https://chatgpt.com/c/682d4bd8-03c0-8010-b789-a81fc2496dbe