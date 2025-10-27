import 'package:flutter/material.dart';

const Map<String, Color> categoryColors = {
  'Appetizer': Color(0xFFC0B9A9),     // Beige chiaro
  'First Course': Color(0xFF8399B3),  // Blu polvere
  'Main Course': Color(0xFF737E53),   // Verde oliva
  'Side Dish': Color(0xFF313F20),     // Verde scuro
  'Dessert': Color(0xFF5F4B3B),       // Marrone cioccolato
};

// Restituisce il colore per una categoria facendo un match case-insensitive
Color getCategoryColor(String? category) {
  if (category == null) return Colors.grey;
  final key = category.trim().toLowerCase();
  for (final entry in categoryColors.entries) {
    if (entry.key.toLowerCase() == key) return entry.value;
  }
  return Colors.grey;
}