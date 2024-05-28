import '/app/constants/validation_type.dart';
import '/app/widgets/error_banner.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  // Form Key (For validation)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtAddress = TextEditingController();
  final TextEditingController _txtCity = TextEditingController();
  final TextEditingController _txtZipCode = TextEditingController();

  // FocusNode
  final FocusNode _fnName = FocusNode();
  final FocusNode _fnAddress = FocusNode();
  final FocusNode _fnCity = FocusNode();
  final FocusNode _fnZipCode = FocusNode();

  // Validation
  ValidationType validation = ValidationType.instance;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _txtName.dispose();
    _txtAddress.dispose();
    _txtCity.dispose();
    _txtZipCode.dispose();

    _fnName.dispose();
    _fnAddress.dispose();
    _fnCity.dispose();
    _fnZipCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Form
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Address Name
                    TextFormField(
                      controller: _txtName,
                      focusNode: _fnName,
                      textCapitalization: TextCapitalization.words,
                      validator: validation.emptyValidation,
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnAddress),
                      decoration: const InputDecoration(
                        hintText: 'Type your address name (ex: Home)',
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Street Address
                    TextFormField(
                      controller: _txtAddress,
                      focusNode: _fnAddress,
                      validator: validation.emptyValidation,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                      minLines: 2,
                      maxLines: 10,
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnCity),
                      decoration: const InputDecoration(
                        hintText: 'Type your street address',
                        labelText: 'Address',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Address City
                    TextFormField(
                      controller: _txtCity,
                      focusNode: _fnCity,
                      validator: validation.emptyValidation,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnZipCode),
                      decoration: const InputDecoration(
                        hintText: 'Type address city',
                        labelText: 'City',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Address Zip Code
                    TextFormField(
                      controller: _txtZipCode,
                      focusNode: _fnZipCode,
                      validator: validation.emptyValidation,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                        hintText: 'Type your address zip code',
                        labelText: 'Zip Code',
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Add Product Button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: ElevatedButton(
              child: const Text('Add Address'),
              onPressed: () async {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState!.validate() && !_isLoading) {
                  try {
                    setState(() {
                      _isLoading = true;
                    });

                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                    // Example Data
                    // Address data = Address(
                    //   addressId: ''.generateUID(),
                    //   name: _txtName.text,
                    //   address: _txtAddress.text,
                    //   city: _txtCity.text,
                    //   zipCode: _txtZipCode.text,
                    //   createdAt: DateTime.now(),
                    //   updatedAt: DateTime.now(),
                    // );

                    // TODO: Add Address

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Address Added Successfully'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      errorBanner(context: context, msg: e.toString()),
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
