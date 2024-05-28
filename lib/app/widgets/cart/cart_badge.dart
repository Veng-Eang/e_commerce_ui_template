import 'package:badges/badges.dart' as bd;
import 'package:e_commerce/utils/extension.dart';
import '/app/widgets/cart/cart_container.dart';
import '/routes/routes.dart';

import 'package:flutter/material.dart';

import '/models/cart/cart.dart';
import '../../../themes/custom_color.dart';

class CartBadge extends StatefulWidget {
  const CartBadge({super.key});

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  int countCart = 0;
  double total = 0;

  @override
  void initState() {
    countCart = 0;
    total = 0;
    for (var element in dummyCart) {
      countCart += element.quantity;
      total += element.quantity * element.product!.productPrice;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bd.Badge(
      badgeContent: Text(
        '$countCart',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
            ),
      ),
      position: bd.BadgePosition.topEnd(),
      badgeStyle: const bd.BadgeStyle(
        badgeColor: CustomColor.error,
      ),
      showBadge: countCart != 0,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Shopping Cart',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        if (dummyCart.isEmpty)
                          Text(
                            'Cart is Empty',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (dummyCart.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...dummyCart.map(
                                (e) => CartContainer(
                                  item: e,
                                  onTapAdd: () {
                                    if (e.quantity >= e.product!.stock) return;

                                    setState(() {
                                      Cart data = e;
                                      data.quantity += 1;
                                      countCart += 1;
                                      total += e.product!.productPrice;
                                    });
                                  },
                                  onTapRemove: () {
                                    if (e.quantity == 0) return;

                                    setState(() {
                                      Cart data = e;
                                      data.quantity -= 1;
                                      countCart -= 1;
                                      total -= e.product!.productPrice;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    total.toCurrency(),
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  NavigateRoute.toCheckout(context: context);
                                },
                                child: Text('Checkout (${countCart.toNumericFormat()})'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.shopping_cart_rounded),
      ),
    );
  }
}
