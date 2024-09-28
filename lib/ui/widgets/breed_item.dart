import 'package:flutter/material.dart';

import 'package:catbreeds/data/models/breed_model.dart';
import 'package:catbreeds/ui/pages/breed_detail_page.dart';
import 'package:catbreeds/ui/widgets/breed_image.dart';

class BreedItem extends StatelessWidget {
  final BreedModel breed;
  const BreedItem({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BreedDetailPage(
              breed: breed,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              breed.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          BreedImage(imageUrl: breed.imageUrl, height: 350.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  breed.origin,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Intelligence: ${breed.intelligence}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
