import 'package:flutter/material.dart';
import 'package:let_me_cook/components/FoodListElement.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/components/favourites_service.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';
import 'package:let_me_cook/Pages/Recipe_page.dart';

class FavouritePage extends StatefulWidget {
  final List<FoodItem> allItems;

  const FavouritePage({super.key, required this.allItems});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  String selectedCategory = 'All';
  final Map<String, bool> favorites = {};
  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final loadedFavorites = await _favoritesService.loadFavorites();
    setState(() {
      favorites.clear();
      favorites.addAll(loadedFavorites);
    });
  }

  Future<void> _toggleFavorite(String title) async {
    await _favoritesService.toggleFavorite(favorites, title);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Faves')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                buildCategoryChip('All'),
                buildCategoryChip('Appetizer'),
                buildCategoryChip('First Course'),
                buildCategoryChip('Main Course'),
                buildCategoryChip('Side Dish'),
                buildCategoryChip('Dessert'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.allItems.length,
              itemBuilder: (context, index) {
                final item = widget.allItems[index];
                final isFav = favorites[item.title] ?? false;

                if (selectedCategory == 'All' ||
                    selectedCategory.toLowerCase() ==
                        item.category.toLowerCase()) {
                  return FoodListElement(
                    title: item.title,
                    isFavorite: isFav,
                    onFavoriteChanged: (bool newValue) async {
                      await _toggleFavorite(item.title);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipePage(foodItem: item),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget buildCategoryChip(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(category),
        selected: selectedCategory == category,
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = category;
          });
        },
      ),
    );
  }
}
