import 'dart:async';
import 'package:flutter/material.dart';

class ShowcaseCard extends StatefulWidget {
  final List<String> images;
  final List<String> title;

  const ShowcaseCard({super.key, required this.images, required this.title});

  @override
  State<ShowcaseCard> createState() => _ShowcaseCardState();
}

class _ShowcaseCardState extends State<ShowcaseCard> {
  final PageController controller = PageController();
  Timer? timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;

      currentIndex++;

      if (currentIndex >= widget.images.length) {
        currentIndex = 0;
      }

      controller.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Image.asset(widget.images[index], fit: BoxFit.cover);
              },
            ),
          ),

          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: Colors.white,
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ),

          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: Colors.white,
                  onPressed: () {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.deepPurple
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withValues(alpha: 0.8),
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                //color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                widget.title[currentIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
