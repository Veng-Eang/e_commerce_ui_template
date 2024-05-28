import '/app/pages/transaction/detail_transaction/widgets/transaction_status_checkbox.dart';
import '/models/transaction/transaction.dart';
import 'package:flutter/material.dart';

class AdminActionTransactionButton extends StatelessWidget {
  final String transactionID;
  final int transactionStatus;
  const AdminActionTransactionButton({
    super.key,
    required this.transactionStatus,
    required this.transactionID,
  });

  @override
  Widget build(BuildContext context) {
    TransactionStatus status = TransactionStatus.values.where((element) => element.value == transactionStatus).first;

    void Function()? onPressed;
    String labelText = '';

    switch (status) {
      case TransactionStatus.done:
        labelText = 'Done';
        break;
      case TransactionStatus.reviewed:
        labelText = 'Reviewed';
        break;
      default:
        labelText = 'Change Status';
        onPressed = () async {
          await showModalBottomSheet<TransactionStatus>(
            context: context,
            builder: (context) {
              return TransactionStatusCheckbox(selectedStatus: status);
            },
          ).then((status) {
            if (status != null) {
              // TODO: Change Status
            }
          });
        };
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
