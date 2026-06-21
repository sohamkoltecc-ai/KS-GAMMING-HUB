import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final bool whishlist;
  final List<String> screenshots;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.whishlist,
    required this.screenshots,
    this.onTap,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 340,
          transform: Matrix4.identity()..scale(isHovered ? 1.03 : 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 320,
                      height: 320,
                      child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),

              Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.price,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
