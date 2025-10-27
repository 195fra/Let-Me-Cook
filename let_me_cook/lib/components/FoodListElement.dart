import 'package:flutter/material.dart';

class FoodListElement extends StatelessWidget {
  final String title;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;
  final VoidCallback? onTap;


  const FoodListElement({
    Key? key,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  onFavoriteChanged(!isFavorite);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
