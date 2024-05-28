import '/app/pages/transaction/detail_transaction/widgets/review_product_form.dart';
import '/models/account/account.dart';
import '/models/review/review.dart';
import '/models/transaction/transaction.dart';
import '/utils/extension.dart';
import 'package:flutter/material.dart';

class ActionTransactionButton extends StatelessWidget {
  final int transactionStatus;
  final Transaction data;
  const ActionTransactionButton({super.key, required this.transactionStatus, required this.data});

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed;
    String labelText = '';
    TransactionStatus status = TransactionStatus.values.where((element) => element.value == transactionStatus).first;

    switch (status) {
      case TransactionStatus.processed:
        labelText = 'Processed';
        break;
      case TransactionStatus.sent:
        labelText = 'Sent';
        break;
      case TransactionStatus.arrived:
        labelText = 'Accepted';
        onPressed = () {
          // TODO: Accept
        };
        break;
      case TransactionStatus.done:
        labelText = 'Add Review';
        onPressed = () async {
          List<Review> dataReview = [];

          Account currentUser = dummyAccount;

          dataReview.addAll(
            data.purchasedProduct.map(
              (e) => Review(
                reviewId: ''.generateUID(),
                productId: e.productId,
                product: e.product!,
                accountId: data.accountId,
                star: 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                reviewerName: currentUser.fullName,
              ),
            ),
          );

          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...dataReview.map(
                          (review) => ReviewProductForm(
                            data: review,
                            onTapStar: (star) {
                              setState(() {
                                review.star = star;
                              });
                            },
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: ElevatedButton(
                            onPressed: dataReview.every((element) => element.star > 0)
                                ? () async {
                                    // TODO: Submit Review
                                    Navigator.of(context).pop();
                                  }
                                : null,
                            child: const Text('Add Review'),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              );
            },
          );
        };
        break;
      case TransactionStatus.rejected:
        labelText = 'Rejected';
        break;
      case TransactionStatus.reviewed:
        labelText = 'Reviewed';
        break;
      default:
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(labelText),
      ),
    );
  }
}
