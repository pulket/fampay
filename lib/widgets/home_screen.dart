// lib/widgets/home_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/card_service.dart';
import '../models/card_models.dart';
import 'card_types/big_display_card.dart';
import 'card_types/small_card_arrow.dart';
import 'card_types/small_display_card.dart';
import 'card_types/dynamic_width_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CardService _cardService;
  List<CardGroup> _cardGroups = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    final prefs = await SharedPreferences.getInstance();
    _cardService = CardService(prefs);
    _loadCards();
  }

  Future<void> _loadCards() async {
    try {
      setState(() => _isLoading = true);
      final groups = await _cardService.fetchCards();
      setState(() {
        _cardGroups = groups;
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset('assets/fampay_logo.png', height: 30),
      // ),
      body: RefreshIndicator(
        onRefresh: _loadCards,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Something went wrong!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCards,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _cardGroups.length,
      itemBuilder: (context, index) => _buildCardGroup(_cardGroups[index]),
    );
  }

  Widget _buildCardGroup(CardGroup group) {
    if (group.isScrollable) {
      return SizedBox(
        height: group.height ?? 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: group.cards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildCard(group.designType, group.cards[index]),
            );
          },
        ),
      );
    }

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: group.cards.map((card) => _buildCard(group.designType, card)).toList(),
    );
  }

  Widget _buildCard(String designType, ContextualCard card) {
    switch (designType) {
      case 'HC3':
        return BigDisplayCard(
          card: card,
          onDismiss: () => _handleCardDismiss(card.id ?? ''),
          onRemindLater: () => _handleRemindLater(card.id ?? ''),
        );
      case 'HC6':
        return SmallCardArrow(card: card);
      case 'HC1':
        return SmallDisplayCard(card: card);
      case 'HC9':
        return DynamicWidthCard(card: card);
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _handleCardDismiss(String cardId) async {
    await _cardService.dismissCard(cardId);
    _loadCards();
  }

  Future<void> _handleRemindLater(String cardId) async {
    await _cardService.remindLater(cardId);
    _loadCards();
  }
}