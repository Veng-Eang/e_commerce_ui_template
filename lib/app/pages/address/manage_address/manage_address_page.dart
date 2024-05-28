import '/app/widgets/radio_card.dart';
import '/models/address/address.dart';
import '/routes/routes.dart';
import 'package:flutter/material.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  bool returnAddress = false;

  Address? selectedAddress;

  bool _isLoading = false;

  @override
  void initState() {
    Future.microtask(
      () {
        returnAddress = ModalRoute.of(context)!.settings.arguments as bool;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Address'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.kAddAddress);
            },
            child: const Text('Add Address'),
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
                  if (dummyAddress.isEmpty)
                    Center(
                      child: Text(
                        'Address is Empty,\nAdd your address for shipping purpose',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (dummyAddress.isNotEmpty)
                    ...dummyAddress.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: RadioCard<Address>(
                          title: e.name,
                          subtitle: '${e.address} ${e.city} ${e.zipCode}',
                          value: e,
                          selectedValue: selectedAddress,
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value;
                            });
                          },
                          onDelete: () {
                            // TODO: Delete Address
                          },
                          onEdit: () {
                            NavigateRoute.toEditAddress(context: context, address: e);
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),

          // Button
          if (dummyAddress.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: ElevatedButton(
                onPressed: selectedAddress == null
                    ? null
                    : () async {
                        if (_isLoading) return;

                        if (returnAddress) {
                          Navigator.of(context).pop(selectedAddress);
                          return;
                        }

                        setState(() {
                          _isLoading = true;
                        });

                        // TODO: Change Primary Address
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
                    : returnAddress
                        ? const Text('Select Address')
                        : const Text('Change Primary Address'),
              ),
            ),
        ],
      ),
    );
  }
}
