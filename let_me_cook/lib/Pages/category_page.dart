import 'package:flutter/material.dart';
import 'package:let_me_cook/components/category_header.dart';
import 'package:let_me_cook/data/food_item.dart';
import 'package:let_me_cook/data/food_repository.dart';
import 'package:let_me_cook/data/category_colors.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({required this.category, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String searchQuery = '';
  late final Future<List<FoodItem>> _foodFuture;

  @override
  void initState() {
    super.initState();
    _foodFuture = loadFoodItemsFromJson();
  }

  List<FoodItem> _filterItems(List<FoodItem> items) {
    final widgetCat = widget.category.trim().toLowerCase();
    final query = searchQuery.trim().toLowerCase();

    if (query.isNotEmpty) {
      return items.where((item) => item.title.toLowerCase().contains(query)).toList();
    }

    return items.where((item) {
      final itemCat = item.category.trim().toLowerCase();
      return itemCat == widgetCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final headerColor = getCategoryColor(widget.category);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<List<FoodItem>>(
          future: _foodFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint('Warning: failed to load food items: ${snapshot.error}');
            }

            final allItems = snapshot.data ?? <FoodItem>[];
            final filteredItems = _filterItems(allItems);

            return Column(
              children: [
                CategoryHeader(
                  title: widget.category,
                  category: widget.category,
                  searchValue: searchQuery,
                  onSearchChanged: (value) => setState(() => searchQuery = value),
                  backgroundColor: headerColor,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: filteredItems.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Dosis',
                              color: Colors.black87,
                            ),
                          ),
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
