import 'package:flutter/material.dart';

//card riutilizzabile per gli elementi cibo
class FoodListElement extends StatefulWidget {
  final String title;
  final String imageUrl;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;


  const FoodListElement({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  State<FoodListElement> createState() => _FoodListElementState();
}

class _FoodListElementState extends State<FoodListElement> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                widget.onFavoriteChanged(!widget.isFavorite);
              },
            ),
          ],
        ),
      ),
    );
  }
}
