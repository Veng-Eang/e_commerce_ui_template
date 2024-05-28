import '/app/widgets/radio_card.dart';
import '/models/payment_method/payment_method.dart';
import '/routes/routes.dart';
import 'package:flutter/material.dart';

class ManagePaymentMethodPage extends StatefulWidget {
  const ManagePaymentMethodPage({super.key});

  @override
  State<ManagePaymentMethodPage> createState() => _ManagePaymentMethodPageState();
}

class _ManagePaymentMethodPageState extends State<ManagePaymentMethodPage> {
  bool returnPaymentMethod = false;

  PaymentMethod? selectedPaymentMethod;

  bool _isLoading = false;

  @override
  void initState() {
    Future.microtask(
      () {
        returnPaymentMethod = ModalRoute.of(context)!.settings.arguments as bool;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Payment'),
        actions: [
          TextButton(
            onPressed: () {
              NavigateRoute.toAddPaymentMethod(context: context);
            },
            child: const Text('Add Method'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Address List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                children: [
                  if (dummyListPaymentMethod.isEmpty)
                    Center(
                      child: Text(
                        'Payment Method is Empty,\nAdd your payment method for payment purpose',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (dummyListPaymentMethod.isNotEmpty)
                    ...dummyListPaymentMethod.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RadioCard<PaymentMethod>(
                          title: e.cardholderName,
                          subtitle: e.cardNumber,
                          value: e,
                          selectedValue: selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentMethod = value;
                            });
                          },
                          onDelete: () {
                            // TODO: Delete Payment Method
                          },
                          onEdit: () {
                            NavigateRoute.toEditPaymentMethod(context: context, paymentMethod: e);
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),

          // Button
          if (dummyListPaymentMethod.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: ElevatedButton(
                onPressed: selectedPaymentMethod == null
                    ? null
                    : () async {
                        if (_isLoading) return;

                        if (returnPaymentMethod) {
                          Navigator.of(context).pop(selectedPaymentMethod);
                          return;
                        }

                        setState(() {
                          _isLoading = true;
                        });

                        // TODO: Change Primary Payment Method
                        Navigator.of(context).pop();
                      },
                child: _isLoading
                    ? const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        ),
                      )
                    : returnPaymentMethod
                        ? const Text('Select Payment Method')
                        : const Text('Change Primary Payment Method'),
              ),
            ),
        ],
      ),
    );
  }
}
