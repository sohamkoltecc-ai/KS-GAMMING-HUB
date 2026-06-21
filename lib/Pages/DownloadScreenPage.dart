import 'package:flutter/material.dart';

import '../Models/game_data.dart';
import '../Models/app_data.dart';
import '../Services/game_service.dart';
import '../Services/install_service.dart';
import '../services/app_services.dart';

import '../Widget/GameCard.dart';
import '../Widget/AppCard.dart';
import '../Widget/DetailsPage.dart';
import '../Widget/AppDetailsPage.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
   Future<List<GameData>>? installedGamesFuture;
  Future<List<AppData>>? installedAppsFuture;

  @override
  void initState() {
    super.initState();

    installedGamesFuture = loadInstalledGames();
    installedAppsFuture = loadInstalledApps();
  }

  Future<List<GameData>> loadInstalledGames() async {
    final games = await GameService.loadGames();

    List<GameData> installedGames = [];

    for (var game in games) {
      bool installed = await InstallService.isInstalled(game.title);

      if (installed) {
        installedGames.add(game);
      }
    }

    return installedGames;
  }

  Future<List<AppData>> loadInstalledApps() async {
    final apps = await AppService.loadApps();

    List<AppData> installedApps = [];

    for (var app in apps) {
      bool installed = await InstallService.isInstalled(app.title);

      if (installed) {
        installedApps.add(app);
      }
    }

    return installedApps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([installedGamesFuture!, installedAppsFuture!]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final games = snapshot.data![0] as List<GameData>;

          final apps = snapshot.data![1] as List<AppData>;

          if (games.isEmpty && apps.isEmpty) {
            return const Center(
              child: Text(
                "Nothing Installed",
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
                          description: app.description,
                          whishlist: app.whishlist,
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
                          description: game.description,
                          whishlist: game.whishlist,
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
