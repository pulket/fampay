
// lib/screens/home_screen.dart
import 'package:fampay/models/card_group.dart';
import 'package:fampay/services/api_service.dart';
import 'package:fampay/widgets/card_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<CardGroup>> _cardGroupsFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _cardGroupsFuture = _apiService.fetchCardGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: Color(0xFFFBAF03), // FamPay yellow color for refresh indicator
          backgroundColor: Colors.white,
          onRefresh: () async {
            setState(() {
              _loadData();
            });
          },
          child: FutureBuilder<List<CardGroup>>(
            future: _cardGroupsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFBAF03), // FamPay yellow color for loader
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }

              final cardGroups = snapshot.data!;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,  // Removed shadow
                    forceElevated: false,  // Disabled forced elevation
                    title: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/1/14/FamPay_Logo.png',
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                    actions: const [
                      SizedBox(width: 48),
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final group = cardGroups[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CardGroupWidget(cardGroup: group),
                          );
                        },
                        childCount: cardGroups.length,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}