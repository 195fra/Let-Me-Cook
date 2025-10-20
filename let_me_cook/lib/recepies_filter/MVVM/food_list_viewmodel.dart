import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';

class FoodListViewModel {
  List<FoodItem> allFoodItems = [];
  List<FoodItem> filteredFoodItems = [];

  String includeText = '';
  String excludeText = '';

  // Lista di ingredienti predefiniti per i bottoni
  List<String> availableIngredients = [
    'Tomato',
    'Cheese',
    'Lettuce',
    'Chicken',
    'Beef',
    'Garlic',
    'Onion',
    'Olive',
    'Cucumber',
    'Pepper',
    'Mushroom',
    'Carrot',
    'Bacon',
    'Pasta',
    'Rice',
    'Spinach',
  ];

  // Set degli ingredienti selezionati (inclusi ed esclusi)
  Set<String> selectedIncludeIngredients = Set<String>();
  Set<String> selectedExcludeIngredients = Set<String>();

  // Carica la lista delle ricette dal JSON
  Future<void> loadFoodList() async {
    // Caricamento JSON da assets, se necessario, rimuovi se già presente nella UI
    String jsonString = await rootBundle.loadString("recipes.json");
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> foodListJson = jsonMap['food list'];
    List<FoodItem> items = foodListJson
        .map((item) => FoodItem.fromJson(item))
        .toList();

    allFoodItems = items;
    filteredFoodItems = items;
  }

  // Filtra le ricette in base agli ingredienti
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

    // Aggiungiamo gli ingredienti selezionati dai bottoni ai filtri
    // Normalizziamo i valori dei bottoni a lowercase per confronti coerenti
    mustInclude.addAll(selectedIncludeIngredients.map((s) => s.toLowerCase()));
    mustExclude.addAll(selectedExcludeIngredients.map((s) => s.toLowerCase()));

    filteredFoodItems = allFoodItems.where((recipe) {
      final ingredientsLower = recipe.ingredients
          .map((i) => i.toLowerCase())
          .toList();

      final includesAll = mustInclude.every(
        (item) =>
            ingredientsLower.any((ingredient) => ingredient.contains(item)),
      );

      final excludesAll = mustExclude.every(
        (item) =>
            !ingredientsLower.any((ingredient) => ingredient.contains(item)),
      );

      return includesAll && excludesAll;
    }).toList();
  }

  // Aggiungi o rimuovi ingredienti dal filtro "include"
  void toggleIncludeIngredient(String ingredient) {
    if (selectedIncludeIngredients.contains(ingredient)) {
      selectedIncludeIngredients.remove(ingredient);
    } else {
      // Se sto aggiungendo a include, rimuovo dallo set exclude per evitare conflitti
      selectedExcludeIngredients.remove(ingredient);
      selectedIncludeIngredients.add(ingredient);
    }
    filterRecipes(); // Applica il filtro dopo la selezione
  }

  // Aggiungi o rimuovi ingredienti dal filtro "exclude"
  void toggleExcludeIngredient(String ingredient) {
    if (selectedExcludeIngredients.contains(ingredient)) {
      selectedExcludeIngredients.remove(ingredient);
    } else {
      // Se sto aggiungendo a exclude, rimuovo dallo set include per evitare conflitti
      selectedIncludeIngredients.remove(ingredient);
      selectedExcludeIngredients.add(ingredient);
    }
    filterRecipes(); // Applica il filtro dopo la selezione
  }
}
