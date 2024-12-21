import 'dart:ui';

class BgGradient {
  final double angle;
  final List<String> colors;

  BgGradient({
    required this.angle,
    required this.colors,
  });

  factory BgGradient.fromJson(Map<String, dynamic> json) {
    return BgGradient(
      angle: (json['angle'] ?? 0).toDouble(),
      colors: (json['colors'] as List).map((c) => c.toString()).toList(),
    );
  }

  List<Color> getColorsList() {
    return colors.map((c) => Color(int.parse(c.replaceAll('#', '0xFF')))).toList();
  }
}