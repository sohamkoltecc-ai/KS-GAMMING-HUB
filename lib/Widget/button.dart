import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconcolor;

  const Button({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.iconcolor,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),

      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color:   Color(0xFF121212),
          borderRadius: BorderRadius.circular(14),

          border: Border.all(
            color: Colors.white10,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,

              decoration: BoxDecoration(
                color: color
                    ?.withValues(alpha: 0.15),

                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: iconcolor,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        color: Colors.white
                            .withOpacity(0.5),
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}