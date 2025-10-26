import 'package:flutter/material.dart';
import 'package:let_me_cook/components/searchbar.dart';



class CategoryHeader extends StatelessWidget {
  final String title;
  final String imagePath;
  final String searchValue;
  final ValueChanged<String> onSearchChanged;
  final Color? backgroundColor; // nuovo parametro opzionale

  const CategoryHeader({
    required this.title,
    required this.imagePath,
    required this.searchValue,
    required this.onSearchChanged,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(imagePath),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppSearchBar(
            value: searchValue,
            onChanged: onSearchChanged,
          ),
        ],
      ),
    );
  }
}
