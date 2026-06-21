import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int selectedMenu = 0;

  bool enableMangoHud = false;
  bool disableWindowManager = false;
  bool enableSteamOverlay = true;
  bool touchControls = false;
  bool developerLogs = false;

  String language = "en_US";
  String resolution = "1920 x 1080";
  String directXHud = "Disabled";

  final List<String> menus = [
    "General",
    "Compatibility",
    "Hub",
    "Backup / Restore",
    "Components",
    "Touch Controls",
    "Developer Options",
  ];

  Widget buildPage() {
    switch (selectedMenu) {
      case 0:
        return Column(
          children: [
            SettingTile(
              title: "Language",
              subtitle: "Set application language",
              value: language,
            ),
            SettingTile(
              title: "Resolution",
              subtitle: "Set launcher resolution",
              value: resolution,
            ),
            SwitchSettingTile(
              title: "Enable MangoHUD",
              subtitle: "Show FPS and performance stats",
              value: enableMangoHud,
              onChanged: (v) {
                setState(() {
                  enableMangoHud = v;
                });
              },
            ),
          ],
        );

      case 1:
        return Column(
          children: [
            SettingTile(
              title: "Wine Version",
              subtitle: "Select compatibility layer",
              value: "Wine 9.0",
            ),
            SettingTile(
              title: "DirectX HUD",
              subtitle: "Show DirectX debug info",
              value: directXHud,
            ),
            SwitchSettingTile(
              title: "Disable Window Manager",
              subtitle: "Improve game compatibility",
              value: disableWindowManager,
              onChanged: (v) {
                setState(() {
                  disableWindowManager = v;
                });
              },
            ),
          ],
        );

      case 2:
        return Column(
          children: [
            SwitchSettingTile(
              title: "Hub Overlay",
              subtitle: "Enable Steam overlay support",
              value: enableSteamOverlay,
              onChanged: (v) {
                setState(() {
                  enableSteamOverlay = v;
                });
              },
            ),
            SettingTile(
              title: "Hub Path",
              subtitle: "Location of Steam installation",
              value: "C:/Program Files/hub",
            ),
          ],
        );

      case 3:
        return Column(
          children: [
            SettingTile(
              title: "Backup Games",
              subtitle: "Backup installed games",
              value: "",
            ),
            SettingTile(
              title: "Restore Games",
              subtitle: "Restore previous backup",
              value: "",
            ),
          ],
        );

      case 4:
        return Column(
          children: [
            SettingTile(
              title: "Visual C++",
              subtitle: "Install VC++ Runtime",
              value: "Installed",
            ),
            SettingTile(
              title: ".NET Runtime",
              subtitle: "Required by some games",
              value: "Installed",
            ),
            SettingTile(
              title: "DirectX Runtime",
              subtitle: "Graphics runtime",
              value: "Installed",
            ),
          ],
        );

      case 5:
        return Column(
          children: [
            SwitchSettingTile(
              title: "Touch Controls",
              subtitle: "Enable touch control support",
              value: touchControls,
              onChanged: (v) {
                setState(() {
                  touchControls = v;
                });
              },
            ),
          ],
        );

      case 6:
        return Column(
          children: [
            SwitchSettingTile(
              title: "Developer Logs",
              subtitle: "Enable debug logging",
              value: developerLogs,
              onChanged: (v) {
                setState(() {
                  developerLogs = v;
                });
              },
            ),
            SettingTile(
              title: "Launcher Version",
              subtitle: "Current version",
              value: "1.0.0",
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: Row(
        children: [
          Container(
            width: 260,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color:  const Color(0xFF121212),

                ),
              ),
            ),
            child: Column(
              children: [

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      bool selected =
                          selectedMenu == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMenu = index;
                          });
                        },
                        child: Container(
                          margin:
                              const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          padding:
                              const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.blue.withValues(alpha: 0.8)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                            border: Border.all(
                              color: selected
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            menus[index],
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Align(
              alignment: AlignmentGeometry.topLeft,
              child: SingleChildScrollView(
              padding: const EdgeInsets.all(35),
              child: buildPage(),
            ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;

  const SettingTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color:
                        Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class SwitchSettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchSettingTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color:
                        Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Switch(
           // activeThumbColor: Colors.blue,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}