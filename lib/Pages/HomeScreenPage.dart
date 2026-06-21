import 'package:flutter/material.dart';
import 'package:gaminghub/Widget/AppDetailsPage.dart';
import 'package:gaminghub/Widget/ShowcaseCard.dart';
import 'package:gaminghub/services/app_services.dart';

import '../Models/game_data.dart';
import '../Models/app_data.dart';
import '../services/game_service.dart';
import '../Widget/GameCard.dart';
import '../Widget/DetailsPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GameData>> gamesFuture;
  late Future<List<AppData>> appsFuture;

  @override
  void initState() {
    super.initState();
    gamesFuture = GameService.loadGames();
    appsFuture = AppService.loadApps();
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
            return Center(child: Text(snapshot.error.toString()));
          }

          final games = snapshot.data![0] as List<GameData>;

          final apps = snapshot.data![1] as List<AppData>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // trending
                  const Text(
                    "Trending Apps & Games",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ShowcaseCard(
                    images: [
                      games[0].imageUrl,
                      games[1].imageUrl,
                      games[2].imageUrl,
                      games[3].imageUrl,
                      games[4].imageUrl,
                    ],
                    title: [
                      games[0].title,
                      games[1].title,
                      games[2].title,
                      games[3].title,
                      games[4].title,
                    ],
                  ),

                  const SizedBox(height: 40),

                  // APPS
                  const Text(
                    "Apps",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 35,
                    runSpacing: 30,
                    children: apps.map((app) {
                      return GameCard(
                        title: app.title,
                        imageUrl: app.imageUrl,
                        price: app.price,
                        whishlist: app.whishlist,
                        description: app.description,
                        screenshots: app.screenshots,
                        onTap: () {
                          // App Detail Page
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
                  // GAMES
                  const Text(
                    "Games",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
