import 'package:e_commerce/models/product/product.dart';

import '/app/constants/order_by_value.dart';

import '/app/widgets/app_bar_search.dart';
import '/app/widgets/count_and_option.dart';
import '/app/widgets/sort_filter_chip.dart';
import '/config/flavor_config.dart';
import '/routes/routes.dart';
import 'package:flutter/material.dart';

import 'widgets/product_container.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  // Flavor
  FlavorConfig flavor = FlavorConfig.instance;

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
      floatingActionButton: flavor.flavor == Flavor.admin
          ? FloatingActionButton(
              onPressed: () {
                NavigateRoute.toAddProduct(context: context);
              },
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
            )
          : null,
      // App Bar Search
      appBar: AppBarSearch(
        onChanged: (value) {
          search = value!;
          // TODO: Search Product
        },
        controller: _txtSearch,
        hintText: 'Search Product',
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
              count: dummyProduct.length,
              itemName: 'Products',
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
                              // TODO: Sort Product
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
            if (dummyProduct.isEmpty && _txtSearch.text.isEmpty)
              const Center(
                child: Text(
                  'Products is empty,\navailable product will be shown here',
                  textAlign: TextAlign.center,
                ),
              ),

            if (dummyProduct.isEmpty && _txtSearch.text.isNotEmpty)
              const Center(
                child: Text('Products not found'),
              ),

            if (dummyProduct.isNotEmpty)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: GridView.builder(
                    itemCount: dummyProduct.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 8,
                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
                    ),
                    itemBuilder: (_, index) {
                      final item = dummyProduct[index];

                      return ProductContainer(
                        item: item,
                        onTap: () {
                          NavigateRoute.toDetailProduct(
                            context: context,
                            product: item,
                          );
                        },
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
