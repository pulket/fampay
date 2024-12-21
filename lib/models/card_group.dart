// lib/models/card_group.dart
import 'package:fampay/models/card_item.dart';

class CardGroup {
  final int id;
  final String name;
  final String designType;
  final List<CardItem> cards;
  final bool isScrollable;
  final int height;
  final bool isFullWidth;
  final String slug;
  final int level;

  CardGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cards,
    required this.isScrollable,
    required this.height,
    required this.isFullWidth,
    required this.slug,
    required this.level,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      id: json['id'],
      name: json['name'],
      designType: json['design_type'],
      cards: (json['cards'] as List)
          .map((card) => CardItem.fromJson(card))
          .toList(),
      isScrollable: json['is_scrollable'] ?? false,
      height: json['height'] ?? 0,
      isFullWidth: json['is_full_width'] ?? false,
      slug: json['slug'] ?? '',
      level: json['level'] ?? 0,
    );
  }
}