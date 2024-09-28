import 'package:flutter/material.dart';

class BreedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  const BreedImage({super.key, required this.imageUrl, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: LinearProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            )
          : Image.asset(
              'assets/images/image_not_found.png',
              fit: BoxFit.cover,
            ),
    );
  }
}
