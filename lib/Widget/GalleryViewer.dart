import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class GameImageGallery extends StatefulWidget {
  final List<String> media;

  const GameImageGallery({
    super.key,
    required this.media,
  });

  @override
  State<GameImageGallery> createState() => _GameImageGalleryState();
}

class _GameImageGalleryState extends State<GameImageGallery> {
  int selectedIndex = 0;

  final ScrollController scrollController = ScrollController();

  Player? player;
  VideoController? videoController;

  bool isVideo(String path) {
    return path.toLowerCase().endsWith('.mp4');
  }

  @override
  void initState() {
    super.initState();

    if (widget.media.isNotEmpty) {
      _loadMedia();
    }
  }

  @override
  void dispose() {
    player?.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMedia() async {
    if (widget.media.isEmpty) return;

    final oldPlayer = player;

    player = null;
    videoController = null;

    if (mounted) {
      setState(() {});
    }

    await oldPlayer?.dispose();

    final mediaPath = widget.media[selectedIndex];

    if (isVideo(mediaPath)) {
      final newPlayer = Player();
      final newController = VideoController(newPlayer);

      try {
        await newPlayer.open(
          Media('asset:///$mediaPath'),
          play: true,
        );

        if (!mounted) return;

        player = newPlayer;
        videoController = newController;
      } catch (e) {
        debugPrint("Video Error: $e");
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> selectMedia(int index) async {
    if (index < 0 || index >= widget.media.length) return;

    setState(() {
      selectedIndex = index;
    });

    await _loadMedia();
  }

  void scrollLeft() {
    if (!scrollController.hasClients) return;

    scrollController.animateTo(
      (scrollController.offset - 300).clamp(
        0.0,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollRight() {
    if (!scrollController.hasClients) return;

    scrollController.animateTo(
      (scrollController.offset + 300).clamp(
        0.0,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.media.isEmpty) {
      return const Center(
        child: Text("No Media Available"),
      );
    }

    selectedIndex = selectedIndex.clamp(
      0,
      widget.media.length - 1,
    );

    final selectedMedia = widget.media[selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 900,
            height: 500,
            child: isVideo(selectedMedia)
                ? videoController == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Video(
                        controller: videoController!,
                        controls: AdaptiveVideoControls,
                      )
                : Image.asset(
                    selectedMedia,
                    fit: BoxFit.contain,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const Center(
                        child: Text(
                          "Image Not Found",
                        ),
                      );
                    },
                  ),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            IconButton(
              onPressed: scrollLeft,
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),

            Expanded(
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.media.length,
                  itemBuilder: (context, index) {
                    final selected =
                        index == selectedIndex;

                    return GestureDetector(
                      onTap: () => selectMedia(index),
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selected
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(8),
                          child: isVideo(
                            widget.media[index],
                          )
                              ? Container(
                                  color: Colors.black,
                                  child: const Center(
                                    child: Icon(
                                      Icons.play_circle_fill,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  widget.media[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            IconButton(
              onPressed: scrollRight,
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ],
    );
  }
}