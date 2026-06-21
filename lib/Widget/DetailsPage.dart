import 'package:flutter/material.dart';
import 'package:gaminghub/Models/game_data.dart';
import 'package:gaminghub/Widget/download_button.dart';
import 'package:gaminghub/services/game_service.dart';
import 'package:gaminghub/services/install_service.dart';
import 'package:gaminghub/services/whishlist_service.dart';
import 'GalleryViewer.dart';

class GameDetailPage extends StatefulWidget {
  final GameData game;

  const GameDetailPage({super.key, required this.game});

  @override
  State<GameDetailPage> createState() => _GameDetailPagesState();
}

class _GameDetailPagesState extends State<GameDetailPage> {
  bool addtocart = false;
  bool whishList = false;
  bool showFullDescription = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KS GAMMING HUB", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.fromLTRB(90, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.game.title,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: Row(
                  children: const [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star_half_outlined),

                    Text(
                      " 4.5",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: GameImageGallery(
                            media: widget.game.screenshots,
                          ),
                        ),

                        const SizedBox(height: 20),

                        buildAboutSection(),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            widget.game.imageUrl,
                            height: 320,
                            width: 320,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          widget.game.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildAgeRatingBadge("12+"),

                              SizedBox(width: 8),
                              Text(
                                "12+\n Mlid Swing",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        BuildTag("Base Game"),

                        const SizedBox(height: 20),

                        Text(
                          "Free",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: DownloadButton(
                                installed: widget.game.isDownloaded,
                                onPressed: () async {
                                  if (widget.game.isDownloaded) {
                                    print("Launch Game");

                                    return;
                                  }

                                  bool success =
                                      await InstallService.installGame(
                                        widget.game.title,
                                      );

                                  if (success) {
                                    setState(() {
                                      widget.game.isDownloaded = true;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(flex: 3, child: addToCart()),
                          ],
                        ),

                        const SizedBox(height: 20),

                        WhishLists(),

                        const SizedBox(height: 20),
                        Labels("Developer", "Ks"),
                        const SizedBox(height: 20),

                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.white60,
                        ),

                        const SizedBox(height: 20),
                        Labels("Publisher", "Ks"),
                        const SizedBox(height: 20),

                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.white60,
                        ),

                        const SizedBox(height: 20),
                        Platform(),
                        const SizedBox(height: 20),

                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.white60,
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(flex: 5, child: btn("Share", Icons.share)),

                            const SizedBox(width: 20),

                            Expanded(
                              flex: 5,
                              child: btn("Report", Icons.report),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 100),

              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.white60,
              ),

              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "* The lowest price offered on The KS GAMMING HUB in the last 30 days before discount",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addToCart() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          addtocart = !addtocart;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 40, 40, 40),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 40, 40, 40),
            width: 3,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              addtocart ? Icons.add_shopping_cart : Icons.remove_shopping_cart,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget WhishLists() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),

      onTap: () async {
        if (widget.game.whishlist) {
          await WhishlistService.removeFromWhishlist(widget.game.title);
        } else {
          await WhishlistService.addToWhishlist(widget.game.title);
        }

        setState(() {
          widget.game.whishlist = !widget.game.whishlist;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 40, 40, 40),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.game.whishlist ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            const Text("Wishlist", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buildAboutSection() {
    return FutureBuilder<String>(
      future: GameService.loadDescription(widget.game.description),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Text("Failed to load description");
        }

        final description = snapshot.data ?? "";

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "About This Game",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Text(
                description,
                maxLines: showFullDescription ? null : 5,
                overflow: showFullDescription
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  setState(() {
                    showFullDescription = !showFullDescription;
                  });
                },
                child: Text(showFullDescription ? "Show Less" : "Read More"),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildAgeRatingBadge(String ageRating) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors
          .white, // Change color dynamically (e.g., green for 13+, red for 18+)
      borderRadius: BorderRadius.circular(1.0),
      border: Border.all(color: Colors.black, width: 3),
    ),
    child: Text(
      ageRating, // Example: "16+" or "U"
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
  );
}

Widget BuildTag(String TagName) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 40, 40, 40),
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(color: Color.fromARGB(255, 40, 40, 40), width: 3),
    ),
    child: Text(
      TagName,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );
}

Widget DownloadBtn({required VoidCallback onTap, required bool isDownloaded}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDownloaded ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 40, 40, 40),
            width: 3,
          ),
        ),
        child: Text(
          isDownloaded ? "PLAY" : "GET",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget Labels(String name1, String name2) {
  return Row(
    children: [
      Expanded(
        flex: 7,
        child: Text(
          name1,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          name2,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.end,
        ),
      ),
    ],
  );
}

Widget Platform() {
  return Row(
    children: [
      Expanded(
        flex: 7,
        child: Text(
          "Platform",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      Spacer(flex: 1),
      Expanded(flex: 1, child: Icon(Icons.android)),
      Expanded(flex: 1, child: Icon(Icons.window)),
    ],
  );
}

Widget btn(String name, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 40, 40, 40),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color.fromARGB(255, 40, 40, 40),
        width: 3,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),

        const SizedBox(width: 10),

        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
