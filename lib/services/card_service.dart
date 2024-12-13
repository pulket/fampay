// lib/services/card_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../models/card_models.dart';

class CardService {
  final SharedPreferences prefs;

  CardService(this.prefs);

  Future<List<CardGroup>> fetchCards() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.cardsEndpoint}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<CardGroup> groups = jsonData.map((json) => CardGroup.fromJson(json)).toList();
        return filterCards(groups);
      } else {
        throw Exception('Failed to load cards');
      }
    } catch (e) {
      throw Exception('Error fetching cards: $e');
    }
  }

  List<CardGroup> filterCards(List<CardGroup> groups) {
    final dismissedCards = getDismissedCards();
    final remindLaterCards = getRemindLaterCards();

    return groups.map((group) {
      final filteredCards = group.cards.where((card) {
        return !dismissedCards.contains(card.id) && 
               !remindLaterCards.contains(card.id);
      }).toList();

      return CardGroup(
        designType: group.designType,
        cards: filteredCards,
        isScrollable: group.isScrollable,
        height: group.height,
        id: group.id,
      );
    }).where((group) => group.cards.isNotEmpty).toList();
  }

  List<String> getDismissedCards() {
    return prefs.getStringList(ApiConstants.dismissedCardsKey) ?? [];
  }

  List<String> getRemindLaterCards() {
    return prefs.getStringList(ApiConstants.remindLaterKey) ?? [];
  }

  Future<void> dismissCard(String cardId) async {
    final dismissedCards = getDismissedCards();
    dismissedCards.add(cardId);
    await prefs.setStringList(ApiConstants.dismissedCardsKey, dismissedCards);
  }

  Future<void> remindLater(String cardId) async {
    final remindLaterCards = getRemindLaterCards();
    remindLaterCards.add(cardId);
    await prefs.setStringList(ApiConstants.remindLaterKey, remindLaterCards);
  }
}