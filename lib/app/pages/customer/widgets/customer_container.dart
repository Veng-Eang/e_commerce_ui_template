import '/models/account/account.dart';
import '/utils/extension.dart';
import 'package:flutter/material.dart';

class CustomerContainer extends StatelessWidget {
  final Account customer;
  const CustomerContainer({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.transparent,
            backgroundImage: customer.photoProfileUrl.isNotEmpty ? NetworkImage(customer.photoProfileUrl) : null,
            child: customer.photoProfileUrl.isEmpty
                ? const Icon(
                    Icons.person,
                    size: 32,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  customer.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  customer.emailAddress,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  customer.phoneNumber.separateCountryCode(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    customer.banStatus
                        ? OutlinedButton(
                            onPressed: () {
                              // TODO: Unban Customer
                            },
                            child: const Text('Unban Customer'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              // TODO: Ban Customer
                            },
                            child: const Text('Ban Customer'),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
