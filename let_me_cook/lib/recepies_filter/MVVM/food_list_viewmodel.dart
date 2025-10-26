import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';

class FoodListViewModel {
  List<FoodItem> allFoodItems = [];
  List<FoodItem> filteredFoodItems = [];

  String includeText = '';
  String excludeText = '';

  Map<String, List<String>> ingredientCategories = {
    'Vegetables': ['Tomato', 'Onion', 'Potato', 'Zucchini', 'Pepper'],
    'Meat': ['Chicken', 'Beef', 'Pork', 'Srimp','fish'],
    'Condiments': ['Vinegar', 'Ketchup', 'Mayonnaise', 'Olive Oil', 'Salt'],
    'Fruits': ['Lemon', 'Lime', 'Apple', 'Pineapple', 'Nuts'],
    'Grains': ['Flour', 'Pasta', 'Tagliatelle', 'Noodles', 'Macaroni'],
  };

  Set<String> selectedIncludeIngredients = {};
  Set<String> selectedExcludeIngredients = {};

  String currentAction = 'Aggiungi';

  Future<void> loadFoodList() async {
    String jsonString = await rootBundle.loadString("assets/recipes.json");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> foodListJson = jsonMap['food list'];
    allFoodItems = foodListJson.map((item) => FoodItem.fromJson(item)).toList();
    filteredFoodItems = List.from(allFoodItems);
  }

  void filterRecipes() {
    List<String> mustInclude = includeText.toLowerCase().split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    List<String> mustExclude = excludeText.toLowerCase().split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

    mustInclude.addAll(selectedIncludeIngredients.map((s) => s.toLowerCase()));
    mustExclude.addAll(selectedExcludeIngredients.map((s) => s.toLowerCase()));

    filteredFoodItems = allFoodItems.where((recipe) {
      final ingredientsLower = recipe.ingredients.map((i) => i.toLowerCase()).toList();
      final includesAll = mustInclude.every((item) => ingredientsLower.any((ingredient) => ingredient.contains(item)));
      final excludesAll = mustExclude.every((item) => !ingredientsLower.any((ingredient) => ingredient.contains(item)));
      return includesAll && excludesAll;
    }).toList();
  }

  void setAction(String action) {
    currentAction = action;
  }

  void toggleIngredient(String ingredient) {
    if (currentAction == 'Aggiungi') {
      if (selectedIncludeIngredients.contains(ingredient)) {
        selectedIncludeIngredients.remove(ingredient);
      } else {
        selectedExcludeIngredients.remove(ingredient);
        selectedIncludeIngredients.add(ingredient);
      }
    } else {
      if (selectedExcludeIngredients.contains(ingredient)) {
        selectedExcludeIngredients.remove(ingredient);
      } else {
        selectedIncludeIngredients.remove(ingredient);
        selectedExcludeIngredients.add(ingredient);
      }
    }
    filterRecipes();
  }

  Color getIngredientButtonColor(String ingredient) {
    if (currentAction == 'Aggiungi') {
      return selectedIncludeIngredients.contains(ingredient) ? Colors.green : Colors.grey;
    } else {
      return selectedExcludeIngredients.contains(ingredient) ? Colors.red : Colors.grey;
    }
  }
}
