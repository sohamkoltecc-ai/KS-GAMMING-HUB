import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  final bool installed;
  final VoidCallback onPressed;

  const DownloadButton({
    super.key,
    required this.installed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: installed ? Colors.green : Colors.blue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 40, 40, 40),
              width: 3,
            ),
          ),
          child: Text(
            installed ? "PLAY" : "GET",
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
}