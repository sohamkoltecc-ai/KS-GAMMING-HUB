import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/LauncherloginPage.dart';
import '../Widget/button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/hubdata/banner.jpg",
                    fit: BoxFit.cover,
                  ),

                  // Bottom fade overlay
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xFF121212)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage(
                            "assets/hubdata/profile.jpg",
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Soham",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Text("21 Games"),
                                  SizedBox(width: 20),
                                  Text("5 Wishlist"),
                                  SizedBox(width: 20),
                                  Text("3 Installed"),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6C3CF0),
                              foregroundColor: Colors.white,

                              elevation: 0,

                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),

                              side: const BorderSide(color: Colors.deepPurple),
                            ),

                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 1000) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: leftside()),
                              const SizedBox(width: 20),
                              Expanded(flex: 1, child: rightside(context)),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            leftside(),
                            const SizedBox(height: 20),
                            rightside(context),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.white60,
            ),

            const SizedBox(height: 10),

            Text(
              "ALL RIGHTS RESERVE @KS GAMMING HUB",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget leftside() {
    return Column(
      children: [
        const SizedBox(height: 20),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            statItem(Icons.location_on_outlined, "Location", "India"),
            statItem(Icons.language, "Language", "Eng, Hindi"),
            statItem(Icons.games, "Games", "BGMI"),
            statItem(Icons.electrical_services_sharp, "Server", "ASIA"),
            statItem(Icons.leaderboard, "Rank", "Conqueror"),
          ],
        ),
        const SizedBox(height: 30),

        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            btn(Icons.share, "Share", Colors.white),
            btn(Icons.favorite, "Follow", Colors.white),
            btn(Icons.message, "Message", Colors.white),
            btn(Icons.camera, "Instagram", Colors.white),
          ],
        ),

        const SizedBox(height: 30),
        const SizedBox(height: 30),

        buildCard(
          "About Me",
          const Text(
            '''Welcome to my Profile\n\nI’m Soham, a variety streamer focused on high-energy gameplay and great community vibes.\nYou’ll usually find me grinding ranked matches in BGMI or exploring the open worlds of GTA V.\nI love chatting with viewers, sharing tips, and failing spectacularly at rage games.\n\n\n📅 Stream Schedule: Tuesday & Thursday at 12:00 AM\n📍 Join the Discord: ks-ai.discord\n🚀 Business Inquiries: ks@gmai.com\n''',
          ),
        ),

        const SizedBox(height: 20),

        buildCard(
          "Favorite Games",
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [gameTile("assets/hubdata/minecraft.jpg"), gameTile("assets/hubdata/bgmi.jpg"), gameTile("assets/hubdata/CS2.jpg")],
            ),
          ),
        ),
      ],
    );
  }

  Widget rightside(BuildContext context) {
    return Column(
      children: [
        buildCard(
          "Featured Game",
          Column(
            children: [
              Image.asset("assets/hubdata/gtav.jpg"),
              const SizedBox(height: 10),
              const Text("Currently Playing"),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.language_outlined,
          title: "Language",
          subtitle: "Check Notification",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.notifications,
          title: "Notification",
          subtitle: "Check Notification",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.backup_outlined,
          title: "backup & Restore",
          subtitle: "Backup or Restore Your data",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.privacy_tip_outlined,
          title: "Privacy",
          subtitle: "Privacy Documents",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.help_outline_sharp,
          title: "Help & Support",
          subtitle: "Contact Help & Support",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.design_services,
          title: "Term of Service",
          subtitle: "Service Documents",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.info_outline,
          title: "About Hub",
          subtitle: "Know more about us",
          color: Colors.blue,
          iconcolor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(height: 20),
        Button(
          icon: Icons.logout,
          title: "Logout",
          subtitle: "Sign out from account",
          color: Colors.blue,
          iconcolor: Colors.red,
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LauncherLoginPage()),
            );
          },
        ),
      ],
    );
  }

  Widget buildCard(String title, Widget child) {
    return Container(
      width: 900,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 32, 32, 32),
          width: 3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget gameTile(String path) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget btn(IconData icon, String name, Color color) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),

    onTap: () async {},
    child: Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 40, 40, 40),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(name, style: TextStyle(color: color)),
        ],
      ),
    ),
  );
}

Widget statItem(IconData icon, String title, String value) {
  return SizedBox(
    width: 140, // fixed width
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
