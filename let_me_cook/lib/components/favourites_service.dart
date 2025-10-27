import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  Future<Map<String, bool>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList(_favoritesKey);

    if (saved != null) {
      return Map.fromEntries(saved.map((title) => MapEntry(title, true)));
    }

    return {'Bruschette': true};
  }

  Future<void> saveFavorites(Map<String, bool> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> keys = favorites.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
    await prefs.setStringList(_favoritesKey, keys);
  }

  Future<void> toggleFavorite(Map<String, bool> favorites, String title) async {
    favorites[title] = !(favorites[title] ?? false);
    await saveFavorites(favorites);
  }
}
