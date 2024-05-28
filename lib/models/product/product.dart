import 'package:e_commerce/utils/extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  String productId;

  @JsonKey(name: 'product_name')
  String productName;

  @JsonKey(name: 'product_price')
  double productPrice;

  @JsonKey(name: 'product_description')
  String productDescription;

  @JsonKey(name: 'product_image')
  List<String> productImage;

  @JsonKey(name: 'total_reviews')
  int totalReviews;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'stock')
  int stock;

  @JsonKey(name: 'is_deleted')
  bool isDeleted;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
    required this.totalReviews,
    required this.rating,
    required this.stock,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

final List<Product> dummyProduct = [
  Product(
    productId: ''.generateUID(),
    productName: 'Staghorn Fern',
    productPrice: 19.99,
    productDescription:
        'Native to Java and southeastern Australia, the Birds Nest \'Staghorn\' fern has a fuzzy texture to the leaves that can get very large if taken care of. The name bifurcatum means forked, referring to the leaves that split and resemble stag or elk horns. It can grow up to 31-35 in tall and wide, and care is easy as long as they\'re provided with low to medium light and moderate moisture like most ferns.',
    productImage: [
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker1933680301980883892.jpg?alt=media&token=ad767add-3825-4b0f-9a92-7273505ab9b4',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker6188535163206997742.jpg?alt=media&token=91dff8fc-1f70-4474-84f7-a95bac3a7249',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker3168884614803703985.jpg?alt=media&token=c528714b-334b-4165-9079-eda5bbdbbaeb',
    ],
    totalReviews: 52,
    rating: 4.8,
    stock: 40,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    productId: ''.generateUID(),
    productName: 'Blue Hydrnagea',
    productPrice: 22.99,
    productDescription:
        'Hardy and long-lasting, with blooms that burst in brilliant blue. Will arrive blooming.The small bush blooms in early summer, then re-blooms again late summer or early fall if planted outside. The sturdy stems ensure the flowers are help upright, and make the blooms perfect for cut flower arrangements and indoor decoration. ',
    productImage: [
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker3738666044237351753.jpg?alt=media&token=ffccc96a-018e-4d79-b1d9-500d855f92a0',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker5073163067396448156.jpg?alt=media&token=72b1a65d-9cc5-4d6b-b4ea-473c7ad673bc',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker3343863492185177624.jpg?alt=media&token=c8763a3d-572c-4e8a-83f2-458dc417e1fa',
    ],
    totalReviews: 66,
    rating: 4.6,
    stock: 20,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    productId: ''.generateUID(),
    productName: 'Dracaena \'Tornado\'',
    productPrice: 20.99,
    productDescription:
        'This variety of Dracaena has Dark green leaves which grow in a spiral formation from its thin stem. The foliage has a bright greenish-yellow variegation on the edges of each leaf',
    productImage: [
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker7724044900729067435.jpg?alt=media&token=cbbaa14c-90bf-4194-8b5d-86bf225b483e',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker2860327271293701228.jpg?alt=media&token=285c6454-ac79-40a5-9be2-fa8697b52fb0',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker598370747490752216.jpg?alt=media&token=b7dc3050-b3c5-403d-b1dd-7ab7088c54cc',
    ],
    totalReviews: 322,
    rating: 4.2,
    stock: 20,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    productId: ''.generateUID(),
    productName: 'Philodendron \'Dragon Tail\'',
    productPrice: 29.99,
    productDescription:
        'The Dragon Tail is an evergreen vine that can grow over 1m tall. The Dragon Tail can climb by means of aerial roots which adhere to surfaces. Young leaves are elliptical to arrow-shaped with entire margins.',
    productImage: [
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker6954449475767974962.jpg?alt=media&token=328efb19-c06c-4e24-8a7b-386659527c61',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker4185170870639562812.jpg?alt=media&token=84d07717-ddc2-44ed-875f-216734d22df8',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker2846716285825924446.jpg?alt=media&token=81f05cd3-07bd-4bbc-b1c6-1631844171b8',
    ],
    totalReviews: 42,
    rating: 4.8,
    stock: 20,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Product(
    productId: ''.generateUID(),
    productName: 'Succulent Haworthia \'Fasciata\'',
    productPrice: 13.99,
    productDescription:
        'They have thick, dark green leaves with bumps of white tubercles on the outer surface, and are clustered together giving it a “Zebra” effect.',
    productImage: [
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker434454071243575356.jpg?alt=media&token=168b08c7-2205-4e3c-a6f2-3781810e76c3',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker3623884558553987082.jpg?alt=media&token=495f4a41-02ef-44fc-befa-26ecd220f5d8',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-95893.appspot.com/o/Products%2Fimage_picker2470227012435901721.jpg?alt=media&token=52f210ea-bc73-4287-b63c-a4f70f93ed52',
    ],
    totalReviews: 69,
    rating: 5,
    stock: 30,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
