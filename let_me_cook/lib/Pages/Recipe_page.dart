import 'package:flutter/material.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';
import 'package:let_me_cook/components/favourites_service.dart';

class RecipePage extends StatefulWidget {
  final FoodItem foodItem;

  const RecipePage({required this.foodItem, super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final FavoritesService _favoritesService = FavoritesService();
  Map<String, bool> _favorites = {};
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    final loaded = await _favoritesService.loadFavorites();
    setState(() {
      _favorites = loaded;
      isFavorite = _favorites[widget.foodItem.title] ?? false;
    });
  }

  Future<void> _toggleFavorite() async {
    await _favoritesService.toggleFavorite(_favorites, widget.foodItem.title);
    setState(() {
      isFavorite = _favorites[widget.foodItem.title] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodItem = widget.foodItem;

    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    foodItem.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    softWrap: true,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            ...foodItem.ingredients.map(
              (i) => Text('- $i', style: const TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Directions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            ...foodItem.directions.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '${entry.key + 1}. ${entry.value}',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
