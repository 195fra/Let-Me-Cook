import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryHeader({
    required this.title,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Titolo della categoria
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Immagine decorativa
          CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage(imagePath),
          ),
        ],
      ),
    );
  }
}
