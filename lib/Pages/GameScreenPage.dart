import 'package:flutter/material.dart';

import '../Models/game_data.dart';
import '../services/game_service.dart';
import '../Widget/GameCard.dart';
import '../Widget/DetailsPage.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  late Future<List<GameData>> gamesFuture;

  @override
  void initState() {
    super.initState();
    gamesFuture = GameService.loadGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: FutureBuilder<List<GameData>>(
        future: gamesFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final games = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Wrap(
                spacing: 35,
                runSpacing: 30,

                children: games.map((game) {
                  return GameCard(
                    title: game.title,
                    imageUrl: game.imageUrl,
                    price: game.price,
                    whishlist: game.whishlist,
                    description: game.description,
                    screenshots: game.screenshots,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              GameDetailPage(
                                game: game,
                              ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}