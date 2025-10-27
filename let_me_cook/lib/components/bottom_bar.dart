import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/Favorite.dart';
import 'package:let_me_cook/Pages/recipe_journal.dart';
import 'package:let_me_cook/data/food_item.dart';
import 'package:let_me_cook/data/food_repository.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () async {
              final List<FoodItem> foodItems = await loadFoodItemsFromJson();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavouritePage(allItems: foodItems),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeJournal()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
          ),
        ],
      ),
    );
  }
}
