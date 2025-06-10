// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trreu/models/common_model.dart';
import 'package:trreu/payment.dart';
import 'package:trreu/payment/stripe_payment.dart';
import 'package:trreu/services/TicketService.dart';
import 'package:trreu/utils/app_constants.dart';
import 'package:trreu/views/colors.dart';
import 'package:trreu/views/congratulations_ticket_punched.dart';
import 'package:trreu/views/res/commonWidgets.dart';

class CheckoutPage extends StatefulWidget {
  final Event event;
  final Map<String, int> quantities;
  final int amount;

  CheckoutPage({
    super.key,
    required this.event,
    required this.quantities,
    required this.amount,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? selectedPaymentMethod;
  bool isLoading = false;

  // Example payment methods keys to identify
  final List<String> paymentMethods = [
    'Wave',
    'OrangeMoney',
    'Apple',
    'Google',
    'Card',
    // 'stripe',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Checkout".tr),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match Card (same as your code)
              Material(
                elevation: 4,
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          getFullImageUrl(widget.event.category.image),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              widget.event.name,
                              size: 16,
                              isBold: true,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 14),
                                const SizedBox(width: 4),
                                commonText(
                                  "${widget.event.time}    ${widget.event.date.toLocal().toString().split(' ')[0]}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 14),
                                const SizedBox(width: 4),
                                commonText(widget.event.location),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // commonText(
                            //   "Seat Info: Please, see options below",
                            //   fontWeight: FontWeight.w500,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Total Price Row
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText("Total Prix".tr, isBold: true, size: 16),
                    commonText(
                      "${widget.amount} FCFA",
                      isBold: true,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: commonText("Payment Methods".tr, isBold: true, size: 16),
              ),
              const SizedBox(height: 12),

              // Payment buttons dynamically with selection
              Column(
                children:
                    paymentMethods.map((method) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedPaymentMethod = method;
                          });
                        },
                        child: PaymentButton(
                          icon: _getPaymentIcon(method),
                          label: method,
                          isSelected: selectedPaymentMethod == method,
                        ),
                      );
                    }).toList(),
              ),

              const SizedBox(height: 24),

              if (isLoading) Center(child: CircularProgressIndicator()),

              commonButton("Buy".tr, onTap: isLoading ? null : _onBuyPressed),

              const SizedBox(height: 12),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "By continuing, you agree to our ".tr,
                    style: const TextStyle(fontSize: 12),
                    children: [
                      TextSpan(
                        text: "Terms of Use".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      TextSpan(text: " and ".tr),
                      TextSpan(
                        text: "Privacy Policy.".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\nAll payments are encrypted and 100% secure.".tr,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  void _onBuyPressed() async {
    if (selectedPaymentMethod == null) {
      commonSnackbar(
        title: "Error",
        message: "Please select a payment method",
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // 1. Make payment and get transactionId
      String? transactionId;
      if (selectedPaymentMethod == "Card") {
        transactionId = await startCardPayment(
          context: context,
          amount: widget.amount.toString(),
          currency: "USD",
        );
      } else if (selectedPaymentMethod == "Google") {
        transactionId = await startGooglePay(
          context: context,
          paymentCurrency: "USD",
          amount: widget.amount.toString(),
          merchantName: 'Your Merchant Name',
          merchantCountryCode: 'US',
          matchentCurrencyCode: 'USD',
        );
      } else {
        // In your button press or wherever you want to start payment
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (_) => PayDunyaPaymentPage(
                  amount: widget.amount.toDouble(),
                  description: 'Test Payment',
                  customerName: 'John Doe',
                  customerEmail: 'john@example.com',
                  customerPhone: '771111111',
                ),
          ),
        );

        if (result != null && result['status'] == 'success') {
          transactionId = result['transactionId'];
        } else if (result != null && result['status'] == 'cancelled') {
          print('Payment cancelled');
        } else {
          print('Payment flow exited without explicit result');
        }
      }

      if (transactionId == null) {
        // Payment failed or cancelled, stop here
        setState(() => isLoading = false);
        return;
      }

      final body = {
        "eventId": widget.event.id,
        "tickets":
            widget.quantities.entries
                .map((e) => {"type": e.key, "seat": e.value})
                .toList(),
        "amount": widget.amount,
        "transactionId": transactionId,
        "paymentMethod": selectedPaymentMethod,
      };

      final ticketService = TicketService();
      final response = await ticketService.buyTickets(body);

      if (response.success) {
        commonSnackbar(
          title: "Success",
          message: response.message,
          backgroundColor: Colors.green,
        );
        Get.to(
          () => CongratulationTicketPunchedScreen(tcketData: response.data,event:widget.event),
        );
      } else {
        commonSnackbar(
          title: "Failed",
          message: response.message,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      commonSnackbar(
        title: "Error",
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _getPaymentIcon(String method) {
    switch (method) {
      case 'Wave':
        return 'assets/images/Payment-Wave.png';
      case 'OrangeMoney':
        return 'assets/images/Payment-Orange money.png';
      case 'Apple':
        return 'assets/images/Payment-ApplePay.png';
      case 'Google':
        return 'assets/images/Payment-GooglePay.png';
      case 'Card':
        return 'assets/images/Payment-Add Card.png';
      default:
        return 'assets/images/Payment-Add Card.png';
    }
  }
}

class PaymentButton extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;

  const PaymentButton({
    required this.icon,
    required this.label,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? AppColors.primaryColor.withOpacity(0.2) : null,
      ),
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(width: 12),
          commonText(label, size: 15),
        ],
      ),
    );
  }
}
