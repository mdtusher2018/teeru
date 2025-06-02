import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<bool> payWithPayDunya({
  required double amount,
  required String description,
  required String customerName,
  required String customerEmail,
  required String customerPhone,
}) async {
  // Replace these with your sandbox/test keys
  // const masterKey = 'E85ehlMB-YnKq-cJ3h-rFiz-FXrZEmLiBN8e';
  // const privateKey = 'test_private_xIcOAh3CzcVIcPzOlb5upIrv7o8';
  // const token = 'Wn707X5atpK1Kb5qOHvV';

  try {
    final response = await http.post(
      Uri.parse(
        'https://app.paydunya.com/sandbox-api/v1/checkout-invoice/create',
      ),
      headers: {
        'Content-Type': 'application/json',
        'PAYDUNYA-MASTER-KEY': 'UGxLuI18-F4vy-94iW-MTR0-rdvBhzHP8njr',
        'PAYDUNYA-PRIVATE-KEY': 'test_private_clJv8fVNZA2jvkJyBkTjxTLyjjk',
        'PAYDUNYA-TOKEN': 'L4SQORz9g3TX9EtsQbJo',
      },
      body: jsonEncode({
        'invoice': {'total_amount': amount, 'description': 'Test'},
        'store': {'name': 'Test Store'},
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final paymentUrl = data['response_text']; // URL to redirect user

      if (paymentUrl != null && await canLaunch(paymentUrl)) {
        await launch(paymentUrl);
        return true;
      } else {
        log('Could not launch payment URL.');
        return false;
      }
    } else {
      log(
        'Failed to create invoice. Status: ${response.statusCode}, Body: ${response.body}',
      );
      return false;
    }
  } catch (e) {
    log('Error during payment: $e');
    return false;
  }
}
