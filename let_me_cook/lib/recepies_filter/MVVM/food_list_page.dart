import 'package:flutter/material.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_viewmodel.dart';
//import 'package:let_me_cook/recepies_filter/food_item.dart';
import 'package:let_me_cook/components/bottom_bar.dart';

class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late FoodListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FoodListViewModel();
    viewModel.loadFoodList().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Recipes')),
      body: viewModel.allFoodItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Filtro con i bottoni degli ingredienti
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: viewModel.availableIngredients.map((
                        ingredient,
                      ) {
                        final isIncluded = viewModel.selectedIncludeIngredients
                            .contains(ingredient);
                        final isExcluded = viewModel.selectedExcludeIngredients
                            .contains(ingredient);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  viewModel.toggleIncludeIngredient(ingredient);
                                  setState(() {
                                    // Dopo il cambio dello stato, rifai il filtro
                                    viewModel.filterRecipes();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isIncluded
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                                child: Text(ingredient),
                              ),
                              SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () {
                                  viewModel.toggleExcludeIngredient(ingredient);
                                  setState(() {
                                    // Dopo il cambio dello stato, rifai il filtro
                                    viewModel.filterRecipes();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isExcluded
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                                child: Text('Exclude $ingredient'),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Campi di testo per l'inclusione e l'esclusione
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
                          viewModel.includeText = value;
                          viewModel.filterRecipes();
                          setState(() {}); // Rende reattiva la UI
                        },
                      ),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Exclude ingredients (comma separated)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          viewModel.excludeText = value;
                          viewModel.filterRecipes();
                          setState(() {}); // Rende reattiva la UI
                        },
                      ),
                    ],
                  ),
                ),

                // Lista delle ricette filtrate
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.filteredFoodItems.length,
                    itemBuilder: (context, index) {
                      final foodItem = viewModel.filteredFoodItems[index];
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
      bottomNavigationBar: const BottomBar(),
    );
  }
}
