// dart
import 'package:flutter/material.dart';
import 'package:let_me_cook/components/FoodListElement.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/components/favourites_service.dart';
import 'package:let_me_cook/data/food_item.dart';
import 'package:let_me_cook/Pages/Recipe_page.dart';
import 'package:let_me_cook/components/category_header.dart';

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

  late List<FoodItem> favoriteItems = [];

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
      favoriteItems = widget.allItems
          .where((item) => favorites[item.title] == true)
          .toList();
    });
  }

  Future<void> _toggleFavorite(String title) async {
    await _favoritesService.toggleFavorite(favorites, title);
    setState(() {});
    favoriteItems = widget.allItems
        .where((item) => favorites[item.title] == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CategoryHeader(
              title: "Your Faves",
              category: "favourites",
              searchValue: '',
              onSearchChanged: (_) {},
              backgroundColor: const Color(0xFF5F4B3B),
              showSearchBar: false,
              showBackButton: false,
            ),
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
