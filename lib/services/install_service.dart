import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstallService {

  static Future<bool> installGame(
    String gameTitle,
  ) async {

    String? selectedFolder =
        await FilePicker.platform.getDirectoryPath();

    if (selectedFolder == null) {
      // User pressed Cancel
      return false;
    }

    try {

      await saveInstall(
        gameTitle,
        selectedFolder,
      );

      return true;

    } catch (e) {

      print(e);

      return false;
    }
  }

  static Future<void> saveInstall(
    String gameTitle,
    String path,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      'isDownloaded_$gameTitle',
      true,
    );

    await prefs.setString(
      'path_$gameTitle',
      path,
    );
  }

  static Future<bool> isInstalled(
    String gameTitle,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getBool(
          'isDownloaded_$gameTitle',
        ) ??
        false;
  }

  static Future<String?> getInstallPath(
    String gameTitle,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      'path_$gameTitle',
    );
  }

  static Future<void> uninstallGame(
    String gameTitle,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      'isDownloaded_$gameTitle',
    );

    await prefs.remove(
      'path_$gameTitle',
    );
  }

  static Future<void> clearAll() async {

    final prefs =
        await SharedPreferences.getInstance();

    final keys = prefs.getKeys();

    for (final key in keys) {

      if (key.startsWith('isDownloaded_') ||
          key.startsWith('path_')) {

        await prefs.remove(key);
      }
    }
  }
}