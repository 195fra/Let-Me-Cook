class FoodItem {
  final String title;
  final List<String> directions;
  final List<String> ingredients;
  final String language;
  final String source;
  final List<String> tags;
  final String url;

  FoodItem({
    required this.title,
    required this.directions,
    required this.ingredients,
    required this.language,
    required this.source,
    required this.tags,
    required this.url,
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
    );
  }
}
