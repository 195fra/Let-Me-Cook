import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/Recipe_page.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';

class FilteredRecipesPage extends StatelessWidget {
  final List<FoodItem> filteredFoodItems;

  const FilteredRecipesPage({required this.filteredFoodItems, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filtered Recipes')),
      body: filteredFoodItems.isEmpty
          ? Center(child: Text('No recipes match your selection'))
          : ListView.builder(
              itemCount: filteredFoodItems.length,
              itemBuilder: (context, index) {
                final foodItem = filteredFoodItems[index];
                return 
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => (RecipePage(foodItem: foodItem)),)
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(foodItem.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          //Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
                          //...foodItem.ingredients.map((i) => Text('- $i')).toList(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
