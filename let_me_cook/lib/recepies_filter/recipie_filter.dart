import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'food_item.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipes',
      home: FoodListPage(),
    );
  }
}


class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<FoodItem> allFoodItems = [];
  List<FoodItem> filteredFoodItems = [];

  String includeText = '';
  String excludeText = '';

  @override
  void initState() {
    super.initState();
    loadFoodList();
  }

  // Caricamento JSON da assets
  Future<void> loadFoodList() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> foodListJson = jsonMap['food list'];
    List<FoodItem> items =
        foodListJson.map((item) => FoodItem.fromJson(item)).toList();

    setState(() {
      allFoodItems = items;
      filteredFoodItems = items;
    });
  }

  // Filtro ricette in base agli ingredienti
  void filterRecipes() {
    List<String> mustInclude = includeText
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    List<String> mustExclude = excludeText
        .toLowerCase()
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    setState(() {
      filteredFoodItems = allFoodItems.where((recipe) {
        final ingredientsLower =
            recipe.ingredients.map((i) => i.toLowerCase()).toList();

        final includesAll = mustInclude.every((item) =>
            ingredientsLower.any((ingredient) => ingredient.contains(item)));

        final excludesAll = mustExclude.every((item) =>
            !ingredientsLower.any((ingredient) => ingredient.contains(item)));

        return includesAll && excludesAll;
      }).toList();
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Recipes')),
      body: allFoodItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Campi di testo per il filtro
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Include ingredients (comma separated)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          includeText = value;
                          filterRecipes();
                        },
                      ),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Exclude ingredients (comma separated)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          excludeText = value;
                          filterRecipes();
                        },
                      ),
                    ],
                  ),
                ),

                // Lista delle ricette filtrate
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredFoodItems.length,
                    itemBuilder: (context, index) {
                      final foodItem = filteredFoodItems[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Ingredients:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: foodItem.ingredients
                                    .map((ingredient) => Text('- $ingredient'))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
