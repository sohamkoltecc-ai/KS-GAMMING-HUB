import 'package:flutter/material.dart';
import 'package:gaminghub/Widget/AppCard.dart';
import 'package:gaminghub/Widget/AppDetailsPage.dart';
import 'package:gaminghub/services/app_services.dart';

import '../Models/game_data.dart';
import '../Models/app_data.dart';
import '../Services/game_service.dart';
import '../Widget/GameCard.dart';
import '../Widget/DetailsPage.dart';

class WhishlistScreen extends StatefulWidget {
  const WhishlistScreen({super.key});

  @override
  State<WhishlistScreen> createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  late Future<List<GameData>> gamesFuture;
  late Future<List<AppData>> appsFuture;

  @override
  void initState() {
    super.initState();

    gamesFuture = loadWishlistGames();
    appsFuture = loadWishlistApps();
  }

  Future<List<GameData>> loadWishlistGames() async {
    final games = await GameService.loadGames();
    return games.where((g) => g.whishlist).toList();
  }

  Future<List<AppData>> loadWishlistApps() async {
    final apps = await AppService.loadApps();

    print("Total apps: ${apps.length}");

    for (var app in apps) {
      print("${app.title} -> ${app.whishlist}");
    }

    return apps.where((a) => a.whishlist).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: FutureBuilder(
        future: Future.wait([gamesFuture, appsFuture]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final games = snapshot.data![0] as List<GameData>;

          final apps = snapshot.data![1] as List<AppData>;

          if (games.isEmpty && apps.isEmpty) {
            return const Center(
              child: Text(
                "Wishlist Empty",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // APPS
                  if (apps.isNotEmpty) ...[
                    const Text(
                      "Apps",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 35,
                      runSpacing: 30,
                      children: apps.map((app) {
                        return AppCard(
                          title: app.title,
                          imageUrl: app.imageUrl,
                          price: app.price,
                          whishlist: app.whishlist,
                          description: app.description,
                          screenshots: app.screenshots,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AppDetailPage(app: app),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 50),
                  ],

                  // GAMES
                  if (games.isNotEmpty) ...[
                    const Text(
                      "Games",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Wrap(
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
                                builder: (_) => GameDetailPage(game: game),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
