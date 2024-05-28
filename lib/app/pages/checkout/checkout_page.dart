import 'package:e_commerce/models/cart/cart.dart';

import '/app/pages/checkout/widgets/checkout_product_container.dart';
import '/app/pages/checkout/widgets/select_shipping_address.dart';
import '/models/address/address.dart';
import '/routes/routes.dart';
import '/themes/custom_color.dart';
import 'package:flutter/material.dart';
import '/utils/extension.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Address? shippingAddress = dummyAddress[0];

  double subTotal = 27.36;
  int countItems = 4;
  double shippingFee = 2;
  double totalBill = 29.36;
  double totalPrice = 27.36;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
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
                  // Shipping Address
                  SelectShippingAddress(
                    shippingAddress: shippingAddress,
                    selectAddress: () async {
                      var result = await NavigateRoute.toManageAddress(context: context, returnAddress: true);
                      setState(() {
                        shippingAddress = result;
                      });
                    },
                    removeAddress: () {
                      setState(() {
                        shippingAddress = null;
                      });
                    },
                  ),

                  // Purchased Product
                  ...dummyCart.take(4).map(
                        (item) => CheckoutProductContainer(item: item),
                      ),
                  const SizedBox(height: 8),

                  // Subtotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        subTotal.toCurrency(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Order Summary
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price ($countItems Items)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        totalPrice.toCurrency(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  if (shippingAddress != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping Fee',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          shippingFee.toCurrency(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          // Total Bill & Select Payment
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
                      'Total Bill',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      totalBill.toCurrency(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: CustomColor.error,
                          ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: shippingAddress == null
                      ? null
                      : () {
                          NavigateRoute.toPayment(context: context);
                        },
                  child: const Text('Select Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
