import 'package:flutter/material.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';

class RecipePage extends StatefulWidget {
  final FoodItem foodItem; // <-- aggiungi questo

  const RecipePage({required this.foodItem, super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final foodItem = widget.foodItem; // <-- usa questo

    return Scaffold(
      appBar: AppBar(title: Text("Recipe Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(foodItem.title,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                  softWrap: true,),
                ),
                Icon(Icons.favorite_border_outlined)
              ],
            ),

            Text('Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            ),

            SizedBox(height: 8),
            ...foodItem.ingredients.map(
              (i) => Text('- $i', style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 16),

            Text('Directions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            ),

            SizedBox(height: 8),
            ...foodItem.directions.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '${entry.key + 1}. ${entry.value}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
