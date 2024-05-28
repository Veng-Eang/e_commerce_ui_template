import 'package:e_commerce/models/product/product.dart';
import 'package:e_commerce/models/review/review.dart';

import '/app/pages/product/detail_product/widgets/detail_action_button.dart';
import '/app/pages/product/detail_product/widgets/detail_product_image_card.dart';
import '/app/pages/product/detail_product/widgets/detail_rating_review.dart';
import '/app/pages/product/detail_product/widgets/detail_text_space_between..dart';
import '/app/pages/product/detail_product/widgets/user_action_button.dart';
import '/app/widgets/cart/cart_badge.dart';
import '/app/widgets/product_review_card.dart';
import '/config/flavor_config.dart';
import '/routes/routes.dart';
import '/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final FlavorConfig _flavorConfig = FlavorConfig.instance;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        actions: _flavorConfig.flavor == Flavor.user
            ? [
                const CartBadge(),
                const SizedBox(width: 32),
              ]
            : null,
      ),
      body: Column(
        children: [
          // Detail
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // List Product Image
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...product.productImage.map((imgUrl) {
                          int index = product.productImage.indexOf(imgUrl);
                          return DetailProductImageCard(imgUrl: imgUrl, index: index);
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Name & Price
                  DetailTextSpaceBetween(
                    leftText: product.productName,
                    rightText: NumberFormat.compactCurrency(locale: 'en_US', symbol: '\$').format(product.productPrice),
                  ),
                  const SizedBox(height: 12),

                  // Product Stock
                  DetailTextSpaceBetween(
                    leftText: 'Stock Left',
                    rightText: product.stock.toNumericFormat(),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    product.productDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),

                  // Rating (Reviews)
                  DetailRatingReview(
                    rating: product.rating,
                    totalReview: product.totalReviews,
                    onTapSeeAll: () {
                      NavigateRoute.toProductReview(context: context, productReview: dummyListReview);
                    },
                  ),
                  const SizedBox(height: 12),

                  // Review List
                  if (dummyListReview.isEmpty)
                    Center(
                      child: Text(
                        'There are no reviews for this product yet',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  if (dummyListReview.isNotEmpty)
                    Column(
                      children: [
                        ...dummyListReview.map((item) {
                          return ProductReviewCard(item: item);
                        })
                      ],
                    ),
                ],
              ),
            ),
          ),

          // Action Button
          _flavorConfig.flavor == Flavor.user
              ? UserActionButton(
                  // TODO: Check If Wishlisted
                  isWishlisted: false,
                  onTapFavorite: () async {
                    // Example Data
                    // Dont forget to import
                    // var data = Wishlist(
                    //   wishlistId: ''.generateUID(),
                    //   productId: product.productId,
                    //   createdAt: DateTime.now(),
                    //   updatedAt: DateTime.now(),
                    // );

                    // TODO: Add Wishlist
                  },
                  onTapAddToCart: product.stock == 0
                      ? null
                      : () async {
                          // Add Cart
                          // Example Data
                          // Dont forget to import
                          // Cart data = Cart(
                          //   cartId: ''.generateUID(),
                          //   product: product,
                          //   productId: product.productId,
                          //   quantity: 1,
                          //   total: product.productPrice,
                          //   createdAt: DateTime.now(),
                          //   updatedAt: DateTime.now(),
                          // );

                          // TODO: Add Cart
                        },
                )
              : DetailActionButton(
                  onTapDeleteProduct: () async {
                    var response = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete this product?'),
                          content: const Text('This product will be deleted permanently'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Abort'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Continue'),
                            ),
                          ],
                        );
                      },
                    );

                    if (response != null) {
                      // TODO: Delete Product
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product Deleted Successfully'),
                        ),
                      );
                    }
                  },
                  onTapEditProduct: () {
                    NavigateRoute.toEditProduct(context: context, product: product);
                  },
                ),
        ],
      ),
    );
  }
}
