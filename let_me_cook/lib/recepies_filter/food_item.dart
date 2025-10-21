class FoodItem {
  final String title;
  final List<String> directions;
  final List<String> ingredients;
  final String language;
  final String source;
  final List<String> tags;
  final String url;
  final String category;

  FoodItem({
    required this.title,
    required this.directions,
    required this.ingredients,
    required this.language,
    required this.source,
    required this.tags,
    required this.url,
<<<<<<< HEAD
    required this.category
=======
    required this.category,
>>>>>>> f9adcd103e7b0246a8afacd1ed03561deb2f2fac
  });

  // Metodo per creare un oggetto FoodItem da una mappa JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      title: json['title'],
      directions: List<String>.from(json['directions']),
      ingredients: List<String>.from(json['ingredients']),
      language: json['language'],
      source: json['source'],
      tags: List<String>.from(json['tags']),
      url: json['url'],
<<<<<<< HEAD
      category: json['category']
=======
      category: json['category'],
>>>>>>> f9adcd103e7b0246a8afacd1ed03561deb2f2fac
    );
  }
}
