import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../Models/game_data.dart';
import 'install_service.dart';

class DownloadService {
  static Future<void> installGame(
    GameData game,
  ) async {
    String? folder =
        await FilePicker.platform.getDirectoryPath();

    if (folder == null) {
      return;
    }

    final data = await rootBundle.load(
      game.downloadFile,
    );

    final fileName =
        game.downloadFile.split('/').last;

    final file = File(
      '$folder\\$fileName',
    );

    await file.writeAsBytes(
      data.buffer.asUint8List(),
    );

    await InstallService.saveInstall(
      game.title,
      folder,
    );
  }
}