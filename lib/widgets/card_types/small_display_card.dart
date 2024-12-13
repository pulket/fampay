
// lib/widgets/card_types/small_display_card.dart

import 'package:fampay/models/card_models.dart';
import 'package:fampay/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmallDisplayCard extends StatelessWidget {
  final ContextualCard card;

  const SmallDisplayCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        color: ColorUtils.hexToColor(card.bgColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (card.title != null)
            Text(
              card.title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (card.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                card.description!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          if (card.cta != null && card.cta!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: card.cta!.map((cta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: () {
                        // Handle CTA tap
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: ColorUtils.hexToColor(cta.bgColor),
                        foregroundColor: ColorUtils.hexToColor(cta.textColor),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: Text(cta.text),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
