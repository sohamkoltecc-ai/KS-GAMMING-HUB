import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Models/game_data.dart';

class GameStorage {
  static Future<void> saveGame(
    GameData game,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      game.title,
      jsonEncode(game.toJson()),
    );
  }

  static Future<GameData?> loadGame(
    String title,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    String? jsonData =
        prefs.getString(title);

    if (jsonData == null) return null;

    return GameData.fromJson(
      jsonDecode(jsonData),
    );
  }
}