import '/app/pages/payment/widgets/select_payment_method.dart';
import '/app/widgets/error_banner.dart';
import '/models/payment_method/payment_method.dart';
import '/routes/routes.dart';
import '/themes/custom_color.dart';
import 'package:flutter/material.dart';
import '/utils/extension.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod? paymentMethod = dummyListPaymentMethod[0];

  double subTotal = 27.36;
  int countItems = 4;
  double shippingFee = 2;
  double serviceFee = 2;
  double totalBill = 29.36;
  double totalPrice = 27.36;
  double totalPay = 27.36;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Method
                  SelectPaymentMethod(
                    paymentMethod: paymentMethod,
                    selectPaymentMethod: () async {
                      var result = await NavigateRoute.toManagePaymentMethod(context: context, returnPaymentMethod: true);
                      setState(() {
                        paymentMethod = result;
                      });
                    },
                    removePaymentMethod: () {
                      setState(() {
                        paymentMethod = null;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Payment Summary
                  Text(
                    'Payment Summary',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Bill',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        totalBill.toCurrency(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service Fee',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        serviceFee.toCurrency(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Total Pay & Pay
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pay',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalPay.toCurrency(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: CustomColor.error,
                          ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: paymentMethod == null
                      ? null
                      : () async {
                          try {
                            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                            paymentMethod = paymentMethod;

                            // TODO: Pay

                            Navigator.of(context).popUntil((route) => route.isFirst);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Transaction Success, check your transaction status on transaction page',
                                ),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                            ScaffoldMessenger.of(context).showMaterialBanner(
                              errorBanner(context: context, msg: e.toString()),
                            );
                          }
                        },
                  child: const Text('Pay'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
