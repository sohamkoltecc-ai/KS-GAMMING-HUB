import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/AppScreenpage.dart';
import 'package:gaminghub/Pages/ProfileScreenPage.dart';
import 'HomeScreenPage.dart';
import 'GameScreenPage.dart';
import 'DownloadScreenPage.dart';
import 'WhishlistScreenPage.dart';
import 'SettingScreenPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  final List<String> pageTitles = [
    "Home",
    "Apps",
    "Games",
    "Whislist",
    "Downloads",
    "Settings",
  ];

  final List<Widget> pages = [
    HomeScreen(),
    AppScreen(),
    GamesScreen(),
    WhishlistScreen(),
    DownloadScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 220,
            color: const Color(0xFF18181C),
            child: Column(
              children: [
                const SizedBox(height: 30),

                const Icon(Icons.sports_esports, size: 50),

                const SizedBox(height: 10),

                const Text(
                  "KS GAMMING \n HUB",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                buildMenuItem(0, Icons.home, "Home"),

                buildMenuItem(1, Icons.apps, "App"),

                buildMenuItem(2, Icons.games, "Games"),

                buildMenuItem(3, Icons.bookmark, "Whishlist"),

                buildMenuItem(4, Icons.download, "Downloads"),

                buildMenuItem(5, Icons.settings, "Settings"),
              ],
            ),
          ),

          // RIGHT SIDE
          Expanded(
            child: Column(
              children: [
                // TOP BAR
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF202024),
                  child: Row(
                    children: [
                      Text(
                        pageTitles[selectedPage],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            filled: true,
                            fillColor: const Color(0xFF2A2A2F),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 20),

                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 22,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),

                // PAGE CONTENT
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF121212),
                    child: pages[selectedPage],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(int index, IconData icon, String title) {
    bool isSelected = selectedPage == index;

    return ListTile(
      selected: isSelected,
      leading: Icon(icon),
      title: Text(title),
      selectedTileColor: Colors.blue.withValues(alpha: 0.8),
      onTap: () {
        setState(() {
          selectedPage = index;
        });
      },
    );
  }
}
