import '../../../../models/transaction/transaction.dart';
import '/app/constants/order_by_value.dart';
import '/app/pages/transaction/list_transaction/widgets/transaction_container.dart';

import '/app/widgets/app_bar_search.dart';
import '/app/widgets/count_and_option.dart';
import '/app/widgets/sort_filter_chip.dart';
import '/config/flavor_config.dart';
import 'package:flutter/material.dart';

class ListTransactionPage extends StatefulWidget {
  const ListTransactionPage({super.key});

  @override
  State<ListTransactionPage> createState() => _ListTransactionPageState();
}

class _ListTransactionPageState extends State<ListTransactionPage> {
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
      // App Bar Search
      appBar: AppBarSearch(
        onChanged: (value) {
          search = value!;
          if (flavor.flavor == Flavor.admin) {
            // TODO: Search all Transaction
          } else {
            // TODO: Search account transaction
          }
        },
        controller: _txtSearch,
        hintText: 'Search Transaction Product',
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
              count: dummyListTransaction.length,
              itemName: 'Transaction',
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
                              if (flavor.flavor == Flavor.admin) {
                              } else {}
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
            if (dummyListTransaction.isEmpty && _txtSearch.text.isEmpty)
              const Center(
                child: Text(
                  'Transaction is empty,\nMake your first transaction',
                  textAlign: TextAlign.center,
                ),
              ),

            if (dummyListTransaction.isEmpty && _txtSearch.text.isNotEmpty)
              const Center(
                child: Text('Transaction not found'),
              ),

            if (dummyListTransaction.isNotEmpty)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    if (flavor.flavor == Flavor.admin) {
                    } else {}
                  },
                  child: ListView.builder(
                    itemCount: dummyListTransaction.length,
                    itemBuilder: (_, index) {
                      final item = dummyListTransaction[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: TransactionContainer(item: item),
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
