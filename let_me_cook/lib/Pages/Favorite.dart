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
    setState(() {
      favoriteItems = widget.allItems
          .where((item) => favorites[item.title] == true)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔶 Header riutilizzato e stilizzato
            SizedBox(
              width: double.infinity,
              child: CategoryHeader(
                title: "Your Faves",
                category: "favourites",
                searchValue: '',
                onSearchChanged: (_) {},
                backgroundColor: const Color(0xFF5F4B3B),
                showSearchBar: false,
                showBackButton: false,
              ),
            ),
            const SizedBox(height: 32), // 🔶 distanza tra header e carosello
            // 🔶 Carosello categorie
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
            // 🔶 Lista dei preferiti filtrati
            Expanded(
              child: Builder(
                builder: (context) {
                  if (favoriteItems.isEmpty) {
                    return const Center(child: Text('No favorites yet'));
                  }

                  final visible = selectedCategory == 'All'
                      ? favoriteItems
                      : favoriteItems
                      .where((i) =>
                  i.category.trim().toLowerCase() ==
                      selectedCategory.trim().toLowerCase())
                      .toList();

                  if (visible.isEmpty) {
                    return const Center(
                      child: Text('No favorites in this category'),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      final isFav = favorites[item.title] ?? false;

                      return FoodListElement(
                        title: item.title,
                        isFavorite: isFav,
                        onFavoriteChanged: (newValue) async {
                          await _toggleFavorite(item.title);
                        },
                        onTap: () {
                          if (!mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipePage(foodItem: item),
                            ),
                          );
                        },
                      );
                    },
                  );
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
    final bool isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = category;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF5F4B3B) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? const Color(0xFF5F4B3B) : Colors.grey.shade300,
            ),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
