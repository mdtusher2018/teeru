// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:pay/pay.dart';
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
  log(googlePaySupported.toString());
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

Future<String?> startApplePay({
  required BuildContext context,
  required String amount,
  required String paymentCurrency,
  required String merchantName,
  required String merchantCountryCode,
  required String merchantCurrencyCode,
}) async {
  Map<String, dynamic>? intentPaymentData;
  intentPaymentData = null;
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
    // 2. Present Apple Pay sheet and confirm payment
    final paymentIntent = await Stripe.instance.confirmPlatformPayPaymentIntent(
      clientSecret: intentPaymentData!["client_secret"],
      confirmParams: PlatformPayConfirmParams.applePay(
        applePay: ApplePayParams(
          cartItems: [],
          merchantCountryCode: merchantCountryCode,
          currencyCode: merchantCurrencyCode,
        ),
      ),
    );
    commonSnackbar(
      title: "Success",
      message: "Apple Pay payment successfully completed",
    );
    // The PaymentIntent ID is your transaction ID
    return paymentIntent.id;
  } catch (e) {
    if (e is StripeException) {
      log(
        'Error during apple pay',
        error: e.error,
        stackTrace: StackTrace.current,
      );
      commonSnackbar(
        title: "Error",
        message: e.error.message ?? e.error.toString(),
      );
    } else {
      log(
        'Error during apple pay',
        error: e,
        stackTrace: (e as Error?)?.stackTrace,
      );
      commonSnackbar(title: "Error", message: e.toString());
    }
    return null;
  }
}

const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.sams.fish",
    "displayName": "Sam's Fish",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "US",
    "currencyCode": "USD",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
      {
        "amount": "0.00",
        "detail": "Available within an hour",
        "identifier": "in_store_pickup",
        "label": "In-Store Pickup"
      },
      {
        "amount": "4.99",
        "detail": "5-8 Business Days",
        "identifier": "flat_rate_shipping_id_2",
        "label": "UPS Ground"
      },
      {
        "amount": "29.99",
        "detail": "1-3 Business Days",
        "identifier": "flat_rate_shipping_id_1",
        "label": "FedEx Priority Mail"
      }
    ]
  }
}''';

const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "exampleGatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Payment Page')),
      body: Column(
        children: [
          ApplePayButton(
            paymentConfiguration: PaymentConfiguration.fromJsonString(
              defaultApplePay,
            ),
            paymentItems: _paymentItems,

            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onApplePayResult,
            loadingIndicator: const Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: 50),
          GooglePayButton(
            theme: GooglePayButtonTheme.light,

            paymentConfiguration: PaymentConfiguration.fromJsonString(
              defaultGooglePay,
            ),
            paymentItems: _paymentItems,
            type: GooglePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
    print('Apple Pay result: $paymentResult');
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    print('Google Pay result: $paymentResult');
  }
}
