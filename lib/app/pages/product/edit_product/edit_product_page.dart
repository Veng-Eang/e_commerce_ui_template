import 'dart:io';

import '/app/constants/validation_type.dart';
import '/utils/compress_image.dart';
import 'widgets/image_product_preview.dart';

import '/app/widgets/error_banner.dart';
import '/app/widgets/pick_image_source.dart';
import '/models/product/product.dart';
import '/utils/numeric_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  // Product to Edit
  Product? dataProduct;

  // Form Key (For validation)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _txtProductName = TextEditingController();
  final TextEditingController _txtPrice = TextEditingController();
  final TextEditingController _txtDescription = TextEditingController();
  final TextEditingController _txtStock = TextEditingController();

  // FocusNode
  final FocusNode _fnProductName = FocusNode();
  final FocusNode _fnPrice = FocusNode();
  final FocusNode _fnDescription = FocusNode();
  final FocusNode _fnStock = FocusNode();

  // Images
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _productImages = [];

  // Validation
  ValidationType validation = ValidationType.instance;

  @override
  void initState() {
    Future.microtask(() {
      setState(() {
        dataProduct = ModalRoute.of(context)!.settings.arguments as Product;

        _txtProductName.text = dataProduct!.productName;
        _txtPrice.text = '${dataProduct!.productPrice}';
        _txtDescription.text = dataProduct!.productDescription;
        _txtStock.text = NumberFormat('#,###').format(dataProduct!.stock);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _txtProductName.dispose();
    _txtPrice.dispose();
    _txtDescription.dispose();
    _txtStock.dispose();

    _fnProductName.dispose();
    _fnPrice.dispose();
    _fnDescription.dispose();
    _fnStock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: dataProduct == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                          // Input Product Name
                          TextFormField(
                            controller: _txtProductName,
                            focusNode: _fnProductName,
                            validator: validation.emptyValidation,
                            keyboardType: TextInputType.name,
                            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnPrice),
                            decoration: const InputDecoration(
                              hintText: 'Type your product name',
                              labelText: 'Product Name',
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Input Price
                          TextFormField(
                            controller: _txtPrice,
                            focusNode: _fnPrice,
                            validator: validation.emptyValidation,
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnDescription),
                            decoration: const InputDecoration(
                              hintText: 'Type your product price',
                              labelText: 'Product Price',
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Input Description
                          TextFormField(
                            controller: _txtDescription,
                            focusNode: _fnDescription,
                            validator: validation.emptyValidation,
                            keyboardType: TextInputType.multiline,
                            minLines: 2,
                            maxLines: 10,
                            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_fnStock),
                            decoration: const InputDecoration(
                              hintText: 'Type product description',
                              labelText: 'Description',
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Input Product Stock
                          TextFormField(
                            controller: _txtStock,
                            focusNode: _fnStock,
                            validator: validation.emptyValidation,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              NumericTextFormatter(),
                            ],
                            onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                            decoration: const InputDecoration(
                              hintText: 'Type your product stock',
                              labelText: 'Stock',
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Product Images
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Product Image'),
                              TextButton(
                                onPressed: () async {
                                  int countImage = dataProduct!.productImage.length;
                                  countImage += _productImages.length;
                                  if (_productImages.isNotEmpty && countImage >= 5) return;

                                  ImageSource? pickImageSource = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const PickImageSource();
                                    },
                                  );

                                  if (pickImageSource != null) {
                                    XFile? image = await _picker.pickImage(source: pickImageSource);
                                    if (image != null) {
                                      setState(() {
                                        _productImages.add(image);
                                      });
                                    }
                                  }
                                },
                                child: const Text('Add Image'),
                              ),
                            ],
                          ),
                          _productImages.isEmpty && (dataProduct!.productImage.isEmpty)
                              ? Text(
                                  'Maximum 5 images',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              : Wrap(
                                  children: [
                                    ...dataProduct!.productImage.map(
                                      (e) => ImageProductPreview(
                                        image: Image.network(
                                          e,
                                          fit: BoxFit.cover,
                                          width: 64,
                                          height: 64,
                                          loadingBuilder: (_, child, loadingProgress) {
                                            if (loadingProgress == null) return child;

                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                        onTap: () {
                                          setState(() {
                                            dataProduct!.productImage.remove(e);
                                          });
                                        },
                                      ),
                                    ),
                                    ..._productImages.map((e) {
                                      return ImageProductPreview(
                                        image: Image.file(
                                          File(e.path),
                                          fit: BoxFit.cover,
                                          width: 64,
                                          height: 64,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _productImages.remove(e);
                                          });
                                        },
                                      );
                                    })
                                  ],
                                ),
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
                    child: const Text('Edit Product'),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (_productImages.isEmpty && (dataProduct!.productImage.length + _productImages.length) == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You must add at least 1 to 5 product images'),
                          ),
                        );
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        try {
                          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

                          List<String> productImage = [];

                          productImage.addAll(dataProduct!.productImage);

                          List<Uint8List> images = [];

                          for (var element in _productImages) {
                            Uint8List image = await element.readAsBytes();

                            image = await CompressImage.startCompress(image);

                            images.add(image);
                          }

                          // Example Data
                          // Dont forget to import
                          // Product data = Product(
                          //   productId: dataProduct!.productId,
                          //   productName: _txtProductName.text,
                          //   productPrice: NumberFormat().parse(_txtPrice.text).toDouble(),
                          //   productDescription: _txtDescription.text,
                          //   productImage: productImage,
                          //   totalReviews: dataProduct!.totalReviews,
                          //   rating: dataProduct!.rating,
                          //   isDeleted: false,
                          //   stock: int.parse(_txtStock.text),
                          //   createdAt: dataProduct!.createdAt,
                          //   updatedAt: DateTime.now(),
                          // );

                          // TODO: Edit Product
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product Edited Successfully'),
                            ),
                          );
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                            ScaffoldMessenger.of(context).showMaterialBanner(
                              errorBanner(context: context, msg: e.toString()),
                            );
                          }
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
