import 'package:e_commerce/utils/extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  @JsonKey(name: 'review_id')
  String reviewId;

  @JsonKey(name: 'product_id')
  String productId;

  @JsonKey(name: 'product')
  Product product;

  @JsonKey(name: 'account_id')
  String accountId;

  @JsonKey(name: 'reviewer_name')
  String reviewerName;

  @JsonKey(name: 'star')
  int star;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Review({
    required this.reviewId,
    required this.productId,
    required this.product,
    required this.accountId,
    required this.star,
    required this.createdAt,
    required this.updatedAt,
    required this.reviewerName,
    this.description,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

final List<Review> dummyListReview = [
  Review(
    reviewId: ''.generateUID(),
    productId: ''.generateUID(),
    product: dummyProduct[0],
    accountId: ''.generateUID(),
    star: 5,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
    reviewerName: 'John',
  ),
  Review(
    reviewId: ''.generateUID(),
    productId: ''.generateUID(),
    product: dummyProduct[0],
    accountId: ''.generateUID(),
    star: 4,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
    reviewerName: 'John Doe',
  ),
  Review(
    reviewId: ''.generateUID(),
    productId: ''.generateUID(),
    product: dummyProduct[0],
    accountId: ''.generateUID(),
    star: 3,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
    reviewerName: 'Karen',
  ),
  Review(
    reviewId: ''.generateUID(),
    productId: ''.generateUID(),
    product: dummyProduct[0],
    accountId: ''.generateUID(),
    star: 2,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
    reviewerName: 'Dante',
  ),
  Review(
    reviewId: ''.generateUID(),
    productId: ''.generateUID(),
    product: dummyProduct[0],
    accountId: ''.generateUID(),
    star: 1,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
    reviewerName: 'Unknown',
  ),
  Review(
    reviewId: ''.generateUID(),
    productId: ''.generateUID(),
    product: dummyProduct[0],
    accountId: ''.generateUID(),
    star: 5,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
    reviewerName: 'Richard',
  ),
];
