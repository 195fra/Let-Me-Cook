import 'package:flutter/material.dart';
import 'package:let_me_cook/components/FoodListElement.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/components/favourites_service.dart';
import 'package:let_me_cook/data/food_item.dart';
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

  // lista visibile dei preferiti (ricomputata ogni volta che cambiano i favoriti)
  late List<FoodItem> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final loadedFavorites = await _favoritesService.loadFavorites();
    setState(() {
      favorites
        ..clear()
        ..addAll(loadedFavorites);
      // popola la lista visibile basandosi sulla mappa dei preferiti
      favoriteItems = widget.allItems
          .where((item) => favorites[item.title] == true)
          .toList();
    });
  }

  Future<void> _toggleFavorite(String title) async {
    // aggiorna e salva tramite il service
    await _favoritesService.toggleFavorite(favorites, title);
    // ricomputa la lista visibile e forza rebuild
    setState(() {
      favoriteItems = widget.allItems
          .where((item) => favorites[item.title] == true)
          .toList();
    });
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
            child: Builder(
              builder: (context) {
                if (favoriteItems.isEmpty) {
                  return const Center(child: Text('No favorites yet'));
                }

                // applica filtro di categoria alla lista già filtrata per preferiti
                final visible = selectedCategory == 'All'
                    ? favoriteItems
                    : favoriteItems
                          .where(
                            (i) =>
                                i.category.trim().toLowerCase() ==
                                selectedCategory.trim().toLowerCase(),
                          )
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
