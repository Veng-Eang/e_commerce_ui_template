import 'package:flutter/material.dart';

class DetailProductImage extends StatelessWidget {
  final String imgUrl;
  final int index;
  const DetailProductImage({super.key, required this.imgUrl, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Hero(
                tag: 'detail_image' '$index',
                child: InteractiveViewer(
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
