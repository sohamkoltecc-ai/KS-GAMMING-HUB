import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gaminghub/Models/app_data.dart';
import 'whishlist_service.dart';

import 'install_service.dart';

class AppService {
  static Future<List<AppData>> loadApps() async {
    final jsonString = await rootBundle.loadString('assets/data/app.json');

    final List data = jsonDecode(jsonString);

    List<AppData> apps = data.map((e) => AppData.fromJson(e)).toList();

    for (var app in apps) {
      app.isDownloaded = await InstallService.isInstalled(app.title);

      app.whishlist = await WhishlistService.isInWhislist(app.title);
    }

    return apps;
  }

  static Future<String> loadDescription(String filePath) async {
    return await rootBundle.loadString(filePath);
  }
}
