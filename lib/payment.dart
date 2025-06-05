import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trreu/views/res/commonWidgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PayDunyaPaymentPage extends StatefulWidget {
  final double amount;
  final String description;
  final String customerName;
  final String customerEmail;
  final String customerPhone;

  const PayDunyaPaymentPage({
    Key? key,
    required this.amount,
    required this.description,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  }) : super(key: key);

  @override
  _PayDunyaPaymentPageState createState() => _PayDunyaPaymentPageState();
}

class _PayDunyaPaymentPageState extends State<PayDunyaPaymentPage> {
  late final WebViewController controller;
  String? paymentUrl;

  @override
  void initState() {
    super.initState();
    createInvoice();
  }

  Future<void> createInvoice() async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://app.paydunya.com/sandbox-api/v1/checkout-invoice/create',
        ),
        headers: {
          'Content-Type': 'application/json',
          'PAYDUNYA-MASTER-KEY': 'E85ehlMB-YnKq-cJ3h-rFiz-FXrZEmLiBN8e',
          'PAYDUNYA-PRIVATE-KEY': 'test_private_7mw0PskYwDRVbxCWY1y0qdfL5Jv',
          'PAYDUNYA-TOKEN': 'bOX44IY9joN7pZO2WKA2',
        },
        body: jsonEncode({
          'invoice': {
            'total_amount': widget.amount,
            'description': widget.description,
            'customer': {
              'name': widget.customerName,
              'email': widget.customerEmail,
              'phone': widget.customerPhone,
            },
            "channels": ["card", "mtn-benin", "orange-money-senegal", "wave"],
          },
          'store': {'name': 'Test Store'},
          'actions': {
            // Custom scheme URLs to detect inside the WebView
            'return_url': 'myapp://payment-success',
            'cancel_url': 'myapp://payment-cancel',
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("Invoice creation response: $data");
        final url = data['response_text'];
        final transactionId = data['token'];
        log("1." + transactionId.toString());

        if (url != null) {
          setState(() {
            paymentUrl = url;
          });
          // Initialize the WebView controller once URL is ready
          setupWebView(url, transactionId);
        } else {
          log('No payment URL received');
        }
      } else {
        log(
          'Failed to create invoice. Status: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (e) {
      log('Error creating invoice: $e');
    }
  }

  void setupWebView(String url, String transactionId) {
    // Initialize WebViewController with platform-specific params
    late final PlatformWebViewControllerCreationParams params;

    params = const PlatformWebViewControllerCreationParams();

    controller =
        WebViewController.fromPlatformCreationParams(params)
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (NavigationRequest request) {
                log('Navigating to ${request.url}');

                // Detect success or cancellation URL inside WebView navigation
                if (request.url.startsWith('myapp://payment-success')) {
                  log(1.toString());
                  Navigator.of(context).pop({
                    'status': 'success',
                    'transactionId': transactionId.toString(),
                  });
                  return NavigationDecision.prevent;
                }
                if (request.url.startsWith('myapp://payment-cancel')) {
                  Navigator.of(context).pop({'status': 'cancelled'});
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
              onPageStarted: (url) => log('Page started loading: $url'),
              onPageFinished: (url) => log('Page finished loading: $url'),
              onWebResourceError:
                  (error) => log('WebView error: ${error.description}'),
            ),
          )
          ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar('PayDunya Payment'),
      body:
          paymentUrl == null
              ? Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: controller),
    );
  }
}
