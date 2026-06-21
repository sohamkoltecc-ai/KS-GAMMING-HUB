import 'package:flutter/material.dart';
import 'package:gaminghub/Models/app_data.dart';
import 'package:gaminghub/Widget/AppCard.dart';
import 'package:gaminghub/Widget/AppDetailsPage.dart';
import 'package:gaminghub/services/app_services.dart';



class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late Future<List<AppData>> appsFuture;

  @override
  void initState() {
    super.initState();
    appsFuture = AppService.loadApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: FutureBuilder<List<AppData>>(
        future: appsFuture,

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

                children: games.map((app) {
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
                          builder: (_) =>
                              AppDetailPage(
                                app: app,
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