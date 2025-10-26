import 'package:flutter/material.dart';
import 'package:let_me_cook/components/category_header.dart';
import 'package:let_me_cook/data/food_item.dart';
import 'package:let_me_cook/data/food_repository.dart'; // caricamento ricette da JSON
import 'package:let_me_cook/data/category_colors.dart'; // mappa colori
import 'package:let_me_cook/data/category_images.dart'; // mappa immagini

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({required this.category, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String searchQuery = '';
  late Future<List<FoodItem>> _foodFuture;

  @override
  void initState() {
    super.initState();
    _foodFuture = loadFoodItemsFromJson();
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = categoryImages[widget.category] ?? 'assets/images/default.png';
    final headerColor = categoryColors[widget.category] ?? Colors.grey;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<List<FoodItem>>(
          future: _foodFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Errore nel caricamento: ${snapshot.error}'));
            }

            final allItems = snapshot.data ?? [];
            final filteredItems = allItems.where((item) {
              final matchesCategory = item.category == widget.category;
              final matchesSearch = item.title.toLowerCase().contains(searchQuery.toLowerCase());
              return matchesCategory && matchesSearch;
            }).toList();

            return Column(
              children: [
                CategoryHeader(
                  title: widget.category,
                  imagePath: imagePath,
                  searchValue: searchQuery,
                  onSearchChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  backgroundColor: headerColor,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text(item.ingredients.join(', ')),
                          onTap: () {
                            // Navigazione o dettaglio
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
