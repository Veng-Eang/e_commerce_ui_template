import 'package:e_commerce/models/wishlist/wishlist.dart';

import '/app/pages/wishlist/widgets/wishlist_container.dart';
import 'package:flutter/material.dart';

import '../../constants/order_by_value.dart';
import '../../widgets/app_bar_search.dart';
import '../../widgets/count_and_option.dart';
import '../../widgets/sort_filter_chip.dart';

class ListWishlistPage extends StatefulWidget {
  const ListWishlistPage({super.key});

  @override
  State<ListWishlistPage> createState() => _ListWishlistPageState();
}

class _ListWishlistPageState extends State<ListWishlistPage> {
  // Text Editing Controller
  final TextEditingController _txtSearch = TextEditingController();

  // Sort
  OrderByEnum orderByEnum = OrderByEnum.newest;
  OrderByValue orderByValue = getEnumValue(OrderByEnum.newest);

  // Search
  String search = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar Search
      appBar: AppBarSearch(
        onChanged: (value) {
          // TODO: Search Wishlist
        },
        controller: _txtSearch,
        hintText: 'Search Wishlist',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            // Product Count & Filter
            CountAndOption(
              count: dummyListWishlist.length,
              itemName: 'Wishlists',
              isSort: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SortFilterChip(
                          dataEnum: OrderByEnum.values.take(4).toList(),
                          onSelected: (value) {
                            setState(() {
                              orderByEnum = value;
                              orderByValue = getEnumValue(value);
                              // TODO: Sort Wishlist
                            });
                          },
                          selectedEnum: orderByEnum,
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // Product List
            if (dummyListWishlist.isEmpty && _txtSearch.text.isEmpty)
              const Center(
                child: Text(
                  'Wishlist is empty,\nwishlist will be shown here',
                  textAlign: TextAlign.center,
                ),
              ),

            if (dummyListWishlist.isEmpty && _txtSearch.text.isNotEmpty)
              const Center(
                child: Text('Wishlist not found'),
              ),

            if (dummyListWishlist.isNotEmpty)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    itemCount: dummyListWishlist.length,
                    itemBuilder: (_, index) {
                      final item = dummyListWishlist[index];

                      return WishlistContainer(
                        wishlist: item,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
