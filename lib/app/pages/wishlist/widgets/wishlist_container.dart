import '../../../../routes/routes.dart';
import '/models/wishlist/wishlist.dart';
import '/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../../themes/custom_color.dart';

class WishlistContainer extends StatelessWidget {
  final Wishlist wishlist;
  const WishlistContainer({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        NavigateRoute.toDetailProduct(
          context: context,
          product: wishlist.product!,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                wishlist.product!.productImage.first,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      wishlist.product!.productName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wishlist.product!.productPrice.toCurrency(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // TODO: Delete WIshlist
                        },
                        icon: const Icon(Icons.delete_rounded),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: wishlist.product!.stock > 0
                            ? () async {
                                // Add Cart
                                // Example Data
                                // Dont forget to import
                                // Cart data = Cart(
                                //   cartId: ''.generateUID(),
                                //   product: wishlist.product,
                                //   productId: wishlist.productId,
                                //   quantity: 1,
                                //   total: wishlist.product!.productPrice,
                                //   createdAt: DateTime.now(),
                                //   updatedAt: DateTime.now(),
                                // );

                                // TODO: Add Cart
                              }
                            : null,
                        child: wishlist.product!.stock > 0 ? const Text('Add to Cart') : const Text('Out of Stock'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (wishlist.product!.rating != 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: CustomColor.warning,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${wishlist.product!.rating}' ' ' '(${wishlist.product!.totalReviews} Reviews)',
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
