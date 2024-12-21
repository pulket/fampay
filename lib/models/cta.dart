class Cta {
  final String text;
  final String? bgColor;
  final String? url;
  final String? textColor;
  final String? type;
  final bool isCircular;
  final bool isSecondary;
  final int strokeWidth;

  Cta({
    required this.text,
    this.bgColor,
    this.url,
    this.textColor,
    this.type,
    this.isCircular = false,
    this.isSecondary = false,
    this.strokeWidth = 0,
  });

  factory Cta.fromJson(Map<String, dynamic> json) {
    return Cta(
      text: json['text'] ?? '',
      bgColor: json['bg_color'],
      url: json['url'],
      textColor: json['text_color'],
      type: json['type'],
      isCircular: json['is_circular'] ?? false,
      isSecondary: json['is_secondary'] ?? false,
      strokeWidth: json['stroke_width'] ?? 0,
    );
  }
}

