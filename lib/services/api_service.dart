// lib/services/api_service.dart
import 'package:fampay/models/card_group.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService {
  static const String baseUrl = 'https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/';

  Future<List<CardGroup>> fetchCardGroups() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?slugs=famx-paypage'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)[0];
        final List<dynamic> groups = jsonData['hc_groups'];
        return groups.map((group) => CardGroup.fromJson(group)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}