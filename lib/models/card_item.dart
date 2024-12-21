// lib/models/card_item.dart
import 'package:fampay/models/bg_gradient.dart';
import 'package:fampay/models/bg_image.dart';
import 'package:fampay/models/cta.dart';
import 'package:fampay/models/formatted_text.dart';

class CardItem {
  final int id;
  final String name;
  final String? title;
  final FormattedText? formattedTitle;
  final String? bgColor; // Changed from bgColor to match API's bg_color
  final BgImage? bgImage;
  final BgGradient? bgGradient;
  final List<Cta>? cta;
  final String? url;
  final dynamic icon;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal; // Added this field
  final String? slug;    // Added this field
  final String? description; // Added this field
  final FormattedText? formattedDescription; // Added this field
  final List<dynamic> positionalImages; // Added this field
  final List<dynamic> components; // Added this field
  final int? iconSize;  // Added this field

  CardItem({
    required this.id,
    required this.name,
    this.title,
    this.formattedTitle,
    this.bgColor,
    this.bgImage,
    this.bgGradient,
    this.cta,
    this.url,
    this.icon,
    this.isDisabled = false,
    this.isShareable = false,
    this.isInternal = false,
    this.slug,
    this.description,
    this.formattedDescription,
    this.positionalImages = const [],
    this.components = const [],
    this.iconSize,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'])
          : null,
      bgColor: json['bg_color'],
      bgImage: json['bg_image'] != null 
          ? BgImage.fromJson(json['bg_image']) 
          : null,
      bgGradient: json['bg_gradient'] != null
          ? BgGradient.fromJson(json['bg_gradient'])
          : null,
      cta: json['cta'] != null
          ? (json['cta'] as List).map((c) => Cta.fromJson(c)).toList()
          : null,
      url: json['url'],
      icon: json['icon'],
      isDisabled: json['is_disabled'] ?? false,
      isShareable: json['is_shareable'] ?? false,
      isInternal: json['is_internal'] ?? false,
      slug: json['slug'],
      description: json['description'],
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'])
          : null,
      positionalImages: json['positional_images'] ?? [],
      components: json['components'] ?? [],
      iconSize: json['icon_size'],
    );
  }
}