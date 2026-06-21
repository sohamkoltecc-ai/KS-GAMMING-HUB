import 'dart:convert';
import 'package:flutter/services.dart';
import '../Models/game_data.dart';
import 'whishlist_service.dart';

import 'install_service.dart';

class GameService {
  static Future<List<GameData>> loadGames() async {
    final jsonString = await rootBundle.loadString('assets/data/games.json');

    final List data = jsonDecode(jsonString);

    List<GameData> games = data.map((e) => GameData.fromJson(e)).toList();

    for (var game in games) {
      game.isDownloaded = await InstallService.isInstalled(game.title);

      game.whishlist = await WhishlistService.isInWhislist(game.title);
    }

    return games;
  }

  static Future<String> loadDescription(String filePath) async {
    return await rootBundle.loadString(filePath);
  }
}
