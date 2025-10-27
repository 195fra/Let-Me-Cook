import 'dart:math';
import 'package:flutter/material.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_viewmodel.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';

mixin HomeViewmodel<T extends StatefulWidget> on State<T> {
  final FoodListViewModel viewModel = FoodListViewModel();
  FoodItem? randomRecipe;

  // Ingredienti iniziali comuni
  final List<String> fridgeIngredients = [
    'Tomato',
    'Beef',
    'Lemon',
    'Pasta',
    'Pepper',
    'Salt',
  ];

  @override
  void initState() {
    super.initState();
    // Carica le ricette e seleziona una ricetta del giorno una sola volta
    viewModel.loadFoodList().then((_) {
      if (viewModel.allFoodItems.isNotEmpty) {
        setState(() {
          randomRecipe = viewModel
              .allFoodItems[Random().nextInt(viewModel.allFoodItems.length)];
        });
      }
    });
    viewModel.setAction('Add'); // per il colore dei bottoni ingredienti
  }
}
