import 'package:flutter/material.dart';
import 'package:let_me_cook/components/FoodListElement.dart';
import 'package:let_me_cook/components/bottom_bar.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

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
      'isFavorite': true,
    },
  ];

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
                if (selectedCategory == 'All' ||
                    selectedCategory == item['category']) {
                  return FoodListElement(
                    title: item['title'],
                    imageUrl: item['imageUrl'],
                    isFavorite: item['isFavorite'],
                    onFavoriteChanged: (bool newValue) {
                      setState(() {
                        item['isFavorite'] = newValue;
                        // Here you would typically update your database or state management
                      });
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
