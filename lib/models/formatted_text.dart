
class FormattedText {
  final String text;
  final String align;
  final List<Entity> entities;

  FormattedText({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'] ?? '',
      align: json['align'] ?? 'left',
      entities: (json['entities'] as List)
          .map((entity) => Entity.fromJson(entity))
          .toList(),
    );
  }
}

class Entity {
  final String text;
  final String type;
  final String? color;
  final int? fontSize;
  final String? fontStyle;
  final String? fontFamily;

  Entity({
    required this.text,
    required this.type,
    this.color,
    this.fontSize,
    this.fontStyle,
    this.fontFamily,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      text: json['text'] ?? '',
      type: json['type'] ?? '',
      color: json['color'],
      fontSize: json['font_size'],
      fontStyle: json['font_style'],
      fontFamily: json['font_family'],
    );
  }
}
