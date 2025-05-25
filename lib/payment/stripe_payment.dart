// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:trreu/payment/keys.dart';
import 'package:trreu/views/res/commonWidgets.dart';

clientSecriteKey() {}

Future<String?> startCardPayment({
  required BuildContext context,
  required String amount,
  required String currency,
}) async {
  Map<String, dynamic>? intentPaymentData;
  intentPaymentData = null;
  try {
    // 1. Create PaymentIntent
    Map<String, dynamic> paymentInfo = {
      "amount": amount,
      "currency": currency,
      "payment_method_types[]": "card",
    };

    http.Response response = await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      body: paymentInfo,
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to create PaymentIntent");
    }

    intentPaymentData = jsonDecode(response.body);
    print("Stripe PaymentIntent: $intentPaymentData");

    // 2. Initialize Payment Sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: intentPaymentData!["client_secret"],
        style: ThemeMode.system,
        merchantDisplayName: "Terru",
      ),
    );

    // 3. Present Payment Sheet
    await Stripe.instance.presentPaymentSheet();

    return intentPaymentData["id"];
  } on StripeException catch (e) {
    log("StripeException: $e");
    commonSnackbar(title: "Payment Cancelled", message: e.toString());
    return null;
  } catch (e) {
    log("Error in makePayment: $e");
    commonSnackbar(title: "Error", message: e.toString());
    return null;
  }
}

Future<String?> startGooglePay({
  required BuildContext context,
  required String amount,
  required String paymentCurrency,
  required String merchantName,
  required String merchantCountryCode,
  required String matchentCurrencyCode,
}) async {
  final googlePaySupported = await Stripe.instance.isPlatformPaySupported(
    googlePay: IsGooglePaySupportedParams(),
  );
  Map<String, dynamic>? intentPaymentData;
  intentPaymentData = null;
  if (googlePaySupported) {
    try {
      // 1. Create PaymentIntent
      Map<String, dynamic> paymentInfo = {
        "amount": amount,
        "currency": paymentCurrency,
        "payment_method_types[]": "card",
      };

      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to create PaymentIntent");
      }

      intentPaymentData = jsonDecode(response.body);
      print("Stripe PaymentIntent: $intentPaymentData");

      // 2. present google pay sheet and confirm payment
      final paymentIntent = await Stripe.instance
          .confirmPlatformPayPaymentIntent(
            clientSecret: intentPaymentData!["client_secret"],
            confirmParams: PlatformPayConfirmParams.googlePay(
              googlePay: GooglePayParams(
                testEnv: true,
                merchantName: merchantName,
                merchantCountryCode: merchantCountryCode,
                currencyCode: matchentCurrencyCode,
              ),
            ),
          );

      commonSnackbar(
        title: "Success",
        message: "Google Pay payment successfully completed",
      );

      // The PaymentIntent ID is your transaction ID
      return paymentIntent.id;
    } catch (e) {
      if (e is StripeException) {
        log(
          'Error during google pay',
          error: e.error,
          stackTrace: StackTrace.current,
        );
        commonSnackbar(
          title: "Error",
          message: e.error.message ?? e.error.toString(),
        );
      } else {
        log(
          'Error during google pay',
          error: e,
          stackTrace: (e as Error?)?.stackTrace,
        );
        commonSnackbar(title: "Error", message: e.toString());
      }
      return null;
    }
  } else {
    commonSnackbar(
      title: "Error",
      message: "Google Pay is not supported on this device",
    );
    return null;
  }
}


// Future<String?> startApplePay({
//   required BuildContext context,
//   required String amount,
//   required String paymentCurrency,
//   required String merchantName,
//   required String merchantCountryCode,
//   required String matchentCurrencyCode,
// }) async {
//   final applePaySupported = await Stripe.instance.isPlatformPaySupported(
//     applePay: IsApplePaySupportedParams(),
//   );
//   Map<String, dynamic>? intentPaymentData;
//   intentPaymentData = null;
//   if (applePaySupported) {
//     try {
//       // 1. Create PaymentIntent
//       Map<String, dynamic> paymentInfo = {
//         "amount": amount,
//         "currency": paymentCurrency,
//         "payment_method_types[]": "card",
//       };
//       http.Response response = await http.post(
//         Uri.parse("https://api.stripe.com/v1/payment_intents"),
//         body: paymentInfo,
//         headers: {
//           "Authorization": "Bearer $secretKey", // Use your Stripe secret key
//           "Content-Type": "application/x-www-form-urlencoded",
//         },
//       );
//       if (response.statusCode != 200) {
//         throw Exception("Failed to create PaymentIntent");
//       }
//       intentPaymentData = jsonDecode(response.body);
//       print("Stripe PaymentIntent: $intentPaymentData");
//       // 2. Present Apple Pay sheet and confirm payment
//       final paymentIntent = await Stripe.instance.confirmPlatformPayPaymentIntent(
//         clientSecret: intentPaymentData!["client_secret"],
//         confirmParams: PlatformPayConfirmParams.applePay(
//           applePay: ApplePayParams(
//             testEnv: true,
//             merchantCountryCode: merchantCountryCode,
//             currencyCode: matchentCurrencyCode,
//           ),
//         ),
//       );
//       commonSnackbar(
//         title: "Success",
//         message: "Apple Pay payment successfully completed",
//       );
//       // The PaymentIntent ID is your transaction ID
//       return paymentIntent.id;
//     } catch (e) {
//       if (e is StripeException) {
//         log(
//           'Error during Apple Pay',
//           error: e.error,
//           stackTrace: StackTrace.current,
//         );
//         commonSnackbar(
//           title: "Error",
//           message: e.error.message ?? e.error.toString(),
//         );
//       } else {
//         log(
//           'Error during Apple Pay',
//           error: e,
//           stackTrace: (e as Error?)?.stackTrace,
//         );
//         commonSnackbar(title: "Error", message: e.toString());
//       }
//       return null;
//     }
//   } else {
//     commonSnackbar(
//       title: "Error",
//       message: "Apple Pay is not supported on this device",
//     );
//     return null;
//   }
// }



