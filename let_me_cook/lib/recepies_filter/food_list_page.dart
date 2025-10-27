import 'package:flutter/material.dart';
import 'package:let_me_cook/recepies_filter/filtered_recipes.dart';
import 'package:let_me_cook/recepies_filter/food_list_viewmodel.dart';

class FoodListPage extends StatefulWidget {
  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late FoodListViewModel viewModel;
  final TextEditingController ingredientController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = FoodListViewModel();
    viewModel.loadFoodList().then((_) {
      setState(() {});
    });
  }

  Widget ingredientButton(String ingredient) {
    return ElevatedButton(
      onPressed: () {
        setState(() => viewModel.toggleIngredient(ingredient));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: viewModel.getIngredientButtonColor(ingredient),
      ),
      child: Text(ingredient),
    );
  }

  // categorie ingredienti
  Widget categoryList(String category, List<String> ingredients) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text(
          category,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        showTrailingIcon: false,
        collapsedBackgroundColor: Color(0xFFC8B897),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ingredients.map((i) => ingredientButton(i)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddTextIngredient() {
    final ingredient = ingredientController.text.trim();
    if (ingredient.isEmpty) return;

    setState(() {
      if (viewModel.currentAction == 'Add') {
        viewModel.selectedIncludeIngredients.add(ingredient);
        viewModel.selectedExcludeIngredients.remove(ingredient);
      } else {
        viewModel.selectedExcludeIngredients.add(ingredient);
        viewModel.selectedIncludeIngredients.remove(ingredient);
      }
      viewModel.filterRecipes();
      ingredientController.clear();
    });
  }

  Widget _buildManualIngredientList(
    String title,
    Set<String> ingredients,
    Color color,
  ) {
    if (ingredients.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(ingredient),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        ingredients.remove(ingredient);
                        viewModel.filterRecipes();
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Recipes Filter')),
      body: viewModel.allFoodItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Selettore modalità Add/Remove
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => viewModel.setAction('Add')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.currentAction == 'Add'
                              ? Colors.green
                              : Color(0xFFCCCCCC),
                        ),
                        child: Text('Add'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => viewModel.setAction('Remove')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.currentAction == 'Remove'
                              ? Colors.red
                              : Color(0xFFCCCCCC),
                        ),
                        child: Text('Remove'),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ingredientController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search for more',
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _handleAddTextIngredient,
                        child: Text(viewModel.currentAction),
                      ),
                    ],
                  ),
                ),

                _buildManualIngredientList(
                  'Ingredients to include:',
                  viewModel.selectedIncludeIngredients,
                  Colors.green,
                ),
                _buildManualIngredientList(
                  'Ingredients to remove:',
                  viewModel.selectedExcludeIngredients,
                  Colors.red,
                ),

                // Lista categorie ingredienti
                Expanded(
                  child: ListView(
                    children: viewModel.ingredientCategories.entries
                        .map((e) => categoryList(e.key, e.value))
                        .toList(),
                  ),
                ),

                // Pulsante per navigare alle ricette filtrate
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FilteredRecipesPage(
                              filteredFoodItems: viewModel.filteredFoodItems,
                            ),
                          ),
                        );
                      },
                      child: Text("Let the cooking Begin"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
