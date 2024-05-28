import 'package:e_commerce/models/transaction/transaction.dart';

import '/app/pages/transaction/detail_transaction/widgets/action_transaction_button.dart';
import '/app/pages/transaction/detail_transaction/widgets/admin_action_transaction_button.dart';
import '/app/pages/transaction/detail_transaction/widgets/customer_information.dart';
import '/app/pages/transaction/detail_transaction/widgets/detail_transaction_product.dart';
import '/app/pages/transaction/detail_transaction/widgets/order_summary_column.dart';
import '/app/pages/transaction/detail_transaction/widgets/payment_summary_column.dart';
import '/app/pages/transaction/detail_transaction/widgets/purchased_date.dart';
import '/app/pages/transaction/detail_transaction/widgets/subtotal_row.dart';
import '/app/pages/transaction/detail_transaction/widgets/transaction_status_row.dart';
import '/config/flavor_config.dart';
import 'package:flutter/material.dart';

class DetailTransactionPage extends StatefulWidget {
  const DetailTransactionPage({super.key});

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  FlavorConfig flavor = FlavorConfig.instance;

  @override
  Widget build(BuildContext context) {
    Transaction transaction = ModalRoute.of(context)!.settings.arguments as Transaction;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaction'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status & ID
                  TransactionStatusRow(
                    status: transaction.transactionStatus!,
                    transactionID: transaction.transactionId,
                  ),
                  const SizedBox(height: 8),

                  // Purchased Date
                  PurchasedDate(
                    date: transaction.createdAt!,
                  ),
                  const SizedBox(height: 12),

                  // Customer Information
                  if (flavor.flavor == Flavor.admin) CustomerInformation(customer: transaction.account!),
                  if (flavor.flavor == Flavor.admin) const SizedBox(height: 12),

                  // Purchased Product
                  Text(
                    'Detail Product',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  ...transaction.purchasedProduct.map(
                    (item) => DetailTransactionProduct(item: item),
                  ),
                  // Subtotal
                  SubtotalRow(
                    subtotal: transaction.subTotal!,
                  ),
                  const SizedBox(height: 16),

                  // Order Summary
                  OrderSummaryColumn(
                    countItems: 4,
                    totalPrice: transaction.totalPrice!,
                    shippingFee: transaction.shippingFee!,
                    shippingAddress: transaction.shippingAddress!,
                  ),
                  const SizedBox(height: 16),

                  // Payment Summary
                  PaymentSummaryColumn(
                    totalBill: transaction.totalBill!,
                    serviceFee: transaction.serviceFee!,
                    totalPay: transaction.totalPay!,
                    paymentMethod: transaction.paymentMethod!,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Action Button
          flavor.flavor == Flavor.admin
              ? AdminActionTransactionButton(
                  transactionID: transaction.transactionId,
                  transactionStatus: transaction.transactionStatus!,
                )
              : ActionTransactionButton(
                  transactionStatus: transaction.transactionStatus!,
                  data: transaction,
                ),
        ],
      ),
    );
  }
}
