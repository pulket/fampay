
class CardGroup {
  final String designType;
  final List<ContextualCard> cards;
  final bool isScrollable;
  final double? height;
  final String? id;

  CardGroup({
    required this.designType,
    required this.cards,
    this.isScrollable = false,
    this.height,
    this.id,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      designType: json['design_type'] ?? '',
      isScrollable: json['is_scrollable'] ?? false,
      height: json['height']?.toDouble(),
      id: json['id'],
      cards: (json['cards'] as List?)
          ?.map((card) => ContextualCard.fromJson(card))
          .toList() ?? [],
    );
  }
}

class ContextualCard {
  final String? title;
  final String? description;
  final String? bgColor;
  final CardImage? bgImage;
  final List<CTA>? cta;
  final String? id;
  final Gradient? bgGradient;

  ContextualCard({
    this.title,
    this.description,
    this.bgColor,
    this.bgImage,
    this.cta,
    this.id,
    this.bgGradient,
  });

  factory ContextualCard.fromJson(Map<String, dynamic> json) {
    return ContextualCard(
      title: json['title'],
      description: json['description'],
      bgColor: json['bg_color'],
      bgImage: json['bg_image'] != null ? CardImage.fromJson(json['bg_image']) : null,
      cta: (json['cta'] as List?)?.map((cta) => CTA.fromJson(cta)).toList(),
      id: json['id'],
      bgGradient: json['bg_gradient'] != null ? Gradient.fromJson(json['bg_gradient']) : null,
    );
  }
}

class CardImage {
  final String imageType;
  final String? assetType;
  final String? imageUrl;

  CardImage({
    required this.imageType,
    this.assetType,
    this.imageUrl,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) {
    return CardImage(
      imageType: json['image_type'] ?? '',
      assetType: json['asset_type'],
      imageUrl: json['image_url'],
    );
  }
}

class CTA {
  final String text;
  final String? bgColor;
  final String? textColor;
  final String? url;

  CTA({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
  });

  factory CTA.fromJson(Map<String, dynamic> json) {
    return CTA(
      text: json['text'] ?? '',
      bgColor: json['bg_color'],
      textColor: json['text_color'],
      url: json['url'],
    );
  }
}

class Gradient {
  final List<String> colors;
  final double angle;

  Gradient({
    required this.colors,
    this.angle = 0,
  });

  factory Gradient.fromJson(Map<String, dynamic> json) {
    return Gradient(
      colors: (json['colors'] as List?)?.map((c) => c.toString()).toList() ?? [],
      angle: (json['angle'] ?? 0).toDouble(),
    );
  }
}