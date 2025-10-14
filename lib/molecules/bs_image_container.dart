import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../tokens/bs_spacing.dart';

class BsImageContainer extends StatelessWidget {
  const BsImageContainer({
    super.key,
    required this.placeHolderPath,
    required this.imageUrl,
    required this.imageNotFoundPath,
    this.fit = BoxFit.cover,
    this.fadeInDuration = const Duration(milliseconds: 150),
    this.fadeOutDuration = const Duration(milliseconds: 150),
  });

  final String placeHolderPath;
  final String imageUrl;
  final String imageNotFoundPath;
  final BoxFit fit;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (BuildContext context, String url) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BsSpacing.SPACE_MEDIUM,
          ),
          child: Image.asset(placeHolderPath, fit: BoxFit.cover),
        );
      },
      imageUrl: imageUrl,
      fit: fit,
      errorWidget: (BuildContext context, String url, Object error) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BsSpacing.SPACE_MEDIUM,
          ),
          child: Image.asset(imageNotFoundPath, fit: BoxFit.cover),
        );
      },
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
    );
  }
}
