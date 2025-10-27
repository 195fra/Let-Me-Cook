const Map<String, String> categoryImages = {
  'Appetizer': 'assets/images/appetizer.png',
  'First Course': 'assets/images/first_course.png',
  'Main Course': 'assets/images/main_dish.png',
  'Side Dish': 'assets/images/side_dish.png',
  'Dessert': 'assets/images/dessert.png',
  'Journal': 'assets/images/book.png',
  'favourites': 'assets/images/favByChef.png',
};

// Restituisce il path dell'immagine per una categoria facendo un match case-insensitive
String getCategoryImage(String? category) {
  if (category == null) return 'assets/images/appetizer.png';
  final key = category.trim().toLowerCase();
  for (final entry in categoryImages.entries) {
    if (entry.key.toLowerCase() == key) return entry.value;
  }

  return 'assets/images/appetizer.png';
}
