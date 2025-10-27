String getCategoryBackground(String category) {
  final normalized = category.toLowerCase().replaceAll(' ', '_');

  // Mappa di alias per nomi alternativi
  final aliases = {
    'main_course': 'main_dish',
  };

  final finalName = aliases[normalized] ?? normalized;
  return 'assets/images/categories/$finalName.png';
}
