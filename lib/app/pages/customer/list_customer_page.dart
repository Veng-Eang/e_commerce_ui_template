import 'package:e_commerce/models/account/account.dart';

import '/app/pages/customer/widgets/customer_container.dart';
import 'package:flutter/material.dart';

import '../../constants/order_by_value.dart';
import '../../widgets/app_bar_search.dart';
import '../../widgets/count_and_option.dart';
import '../../widgets/sort_filter_chip.dart';

class ListCustomerPage extends StatefulWidget {
  const ListCustomerPage({super.key});

  @override
  State<ListCustomerPage> createState() => _ListCustomerPageState();
}

class _ListCustomerPageState extends State<ListCustomerPage> {
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
          // TODO : Search Customer
        },
        controller: _txtSearch,
        hintText: 'Search Customer',
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
              count: dummyListAccount.length,
              itemName: 'Customer',
              isSort: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SortFilterChip(
                          dataEnum: OrderByEnum.values.take(2).toList(),
                          onSelected: (value) {
                            setState(() {
                              orderByEnum = value;
                              orderByValue = getEnumValue(value);
                              // TODO : Sort List Customer
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
            if (dummyListAccount.isEmpty && _txtSearch.text.isEmpty)
              const Center(
                child: Text(
                  'Customer is empty,\ncustomer will be shown here',
                  textAlign: TextAlign.center,
                ),
              ),

            if (dummyListAccount.isEmpty && _txtSearch.text.isNotEmpty)
              const Center(
                child: Text('Customer not found'),
              ),

            if (dummyListAccount.isNotEmpty)
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    itemCount: dummyListAccount.length,
                    itemBuilder: (_, index) {
                      final customer = dummyListAccount[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomerContainer(customer: customer),
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
