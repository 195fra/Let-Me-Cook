import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:let_me_cook/data/food_item.dart' as model;


Future<List<model.FoodItem>> loadFoodItemsFromJson() async {
  final String jsonString = await rootBundle.loadString('assets/recipes.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  final List<dynamic> jsonList = jsonMap['food list'] ?? [];

  return jsonList.map<model.FoodItem>((json) => model.FoodItem.fromJson(Map<String, dynamic>.from(json))).toList();
}
