import 'package:flutter/material.dart';
import 'package:let_me_cook/components/searchbar.dart';
import 'package:let_me_cook/data/category_images.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final String? category;
  final String searchValue;
  final ValueChanged<String> onSearchChanged;
  final Color? backgroundColor;
  final bool showBackButton;
  final bool showSearchBar;

  const CategoryHeader({
    required this.title,
    this.category,
    required this.searchValue,
    required this.onSearchChanged,
    this.backgroundColor,
    this.showBackButton = true,
    this.showSearchBar = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = getCategoryImage(category ?? title);

    return Container(
      height: 218,
      width: double.infinity,
      color: backgroundColor ?? Colors.transparent,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showBackButton)
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 96),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                if (showSearchBar)
                  AppSearchBar(
                    value: searchValue,
                    onChanged: onSearchChanged,
                  ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              imagePath,
              height: 218,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
