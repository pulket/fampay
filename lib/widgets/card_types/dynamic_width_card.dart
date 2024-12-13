
// lib/widgets/card_types/dynamic_width_card.dart

import 'package:fampay/models/card_models.dart';
import 'package:fampay/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DynamicWidthCard extends StatelessWidget {
  final ContextualCard card;

  const DynamicWidthCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (card.bgImage?.imageUrl == null) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: card.bgImage!.imageUrl!,
        fit: BoxFit.cover,
        height: 120,
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          height: 120,
          width: 120,
          child: const Icon(Icons.error),
        ),
      ),
    );
  }
}