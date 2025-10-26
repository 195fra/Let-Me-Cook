import 'package:flutter/material.dart';
import 'package:let_me_cook/recepies_filter/MVVM/filtered_recipes.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_viewmodel.dart';
import 'package:let_me_cook/components/bottom_bar.dart';

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

  Widget _buildIngredientButton(String ingredient) {
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

  Widget _buildCategoryList(String category, List<String> ingredients) {
    return ExpansionTile(
      title: Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ingredients.map((i) => _buildIngredientButton(i)).toList(),
          ),
        ),
      ],
    );
  }

  void _handleAddTextIngredient() {
    final ingredient = ingredientController.text.trim();
    if (ingredient.isEmpty) return;

    setState(() {
      if (viewModel.currentAction == 'Aggiungi') {
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

  // Versione aggiornata: scroll orizzontale
  Widget _buildManualIngredientList(String title, Set<String> ingredients, Color color) {
    if (ingredients.isEmpty) return SizedBox.shrink(); // niente da mostrare

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(ingredient),
                    backgroundColor: color.withOpacity(0.2),
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
                // Selettore modalità Aggiungi/Togli
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => setState(() => viewModel.setAction('Aggiungi')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.currentAction == 'Aggiungi' ? Colors.green : Colors.grey,
                        ),
                        child: Text('Aggiungi'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => setState(() => viewModel.setAction('Togli')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.currentAction == 'Togli' ? Colors.red : Colors.grey,
                        ),
                        child: Text('Togli'),
                      ),
                    ],
                  ),
                ),

                // Campo testo per aggiungere/togliere ingrediente
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ingredientController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Scrivi ingrediente',
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _handleAddTextIngredient,
                        child: Text(viewModel.currentAction),
                      )
                    ],
                  ),
                ),

                // Lista ingredienti aggiunti manualmente (scrollabile orizzontalmente)
                _buildManualIngredientList(
                  'Ingredienti da includere:',
                  viewModel.selectedIncludeIngredients,
                  Colors.green,
                ),
                _buildManualIngredientList(
                  'Ingredienti da escludere:',
                  viewModel.selectedExcludeIngredients,
                  Colors.red,
                ),

                // Lista categorie ingredienti
                Expanded(
                  child: ListView(
                    children: viewModel.ingredientCategories.entries
                        .map((e) => _buildCategoryList(e.key, e.value))
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
      //bottomNavigationBar: const BottomBar(),
    );
  }
}
