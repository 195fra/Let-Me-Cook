import 'package:flutter/material.dart';
import 'package:let_me_cook/components/searchbar.dart';
import 'package:let_me_cook/data/category_images.dart';

// Widget semplice e robusto per mostrare un'immagine circolare dall'asset.
// Se l'asset non è disponibile mostra un placeholder visibile invece di lanciare un'eccezione.
class _AssetCircleImage extends StatelessWidget {
  final String imagePath;
  final double size;


  const _AssetCircleImage({Key? key, required this.imagePath, this.size = 72}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Placeholder visibile quando l'asset non è presente o fallisce il caricamento
            return Container(
              color: Colors.grey.shade700,
              alignment: Alignment.center,
              child: Icon(
                Icons.fastfood,
                color: Colors.white,
                size: size * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}

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
    this.showSearchBar = true, // default: visibile
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = getCategoryImage(category ?? title);

    return Container(
      color: backgroundColor ?? Colors.transparent,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          const SizedBox(height: 4),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 96), // spazio per immagine
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
              Positioned(
                right: 0,
                child: _AssetCircleImage(imagePath: imagePath, size: 88),
              ),
            ],
          ),
          const SizedBox(height: 52), // Spazio minimo richiesto tra titolo e search bar
          if (showSearchBar)
            AppSearchBar(
              value: searchValue,
              onChanged: onSearchChanged,
            ),

        ],
      ),
    );
  }
}
