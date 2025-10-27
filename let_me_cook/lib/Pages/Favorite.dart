import 'package:flutter/material.dart';
import 'package:let_me_cook/components/FoodListElement.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';
import 'package:let_me_cook/Pages/Recipe_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  final List<FoodItem> allItems;

  const FavouritePage({super.key, required this.allItems});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> favoriteItems = [
    {
      'title': 'Bruschette',
      'imageUrl': 'https://example.com/bruschette.jpg',
      'category': 'Appetizer',
    },
  ];

  final Map<String, bool> favorites = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('favorites');
    if (saved != null) {
      setState(() {
        favorites.clear();
        for (var t in saved) {
          favorites[t] = true;
        }
      });
    } else {
      setState(() {
        favorites['Bruschette'] = true;
      });
      await _saveFavorites();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> keys = favorites.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
    await prefs.setStringList('favorites', keys);
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
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                final title = (item['title'] as String);
                final isFav = favorites[title] ?? false;

                if (selectedCategory == 'All' ||
                    selectedCategory == item['category']) {
                  return FoodListElement(
                    title: title,
                    imageUrl: item['imageUrl'],
                    isFavorite: isFav,
                    onFavoriteChanged: (bool newValue) async {
                      setState(() {
                        favorites[title] = newValue;
                      });
                      await _saveFavorites();
                    },
                    onTap: () {
                      try {
                        final matched = widget.allItems.firstWhere(
                          (f) => f.title.toLowerCase() == title.toLowerCase(),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipePage(foodItem: matched),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Recipe data not found'),
                          ),
                        );
                      }
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
