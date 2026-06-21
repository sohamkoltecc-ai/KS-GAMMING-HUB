import 'package:shared_preferences/shared_preferences.dart';

class WhishlistService {

  static Future<void> addToWhishlist(
    String gameTitle,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      'whishlist_$gameTitle',
      true,
    );
  }

  static Future<void> removeFromWhishlist(
    String gameTitle,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      'whishlist_$gameTitle',
    );
  }

  static Future<bool> isInWhislist(
    String gameTitle,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
          'whishlist_$gameTitle',
        ) ??
        false;
  }

  static Future<void> clearAll() async {

    final prefs =
        await SharedPreferences.getInstance();

    final keys = prefs
        .getKeys()
        .where(
          (key) =>
              key.startsWith(
                'whishlist_',
              ),
        )
        .toList();

    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}