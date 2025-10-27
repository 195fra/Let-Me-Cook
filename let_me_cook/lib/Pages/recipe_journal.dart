import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/category_page.dart';
import 'package:let_me_cook/components/category_header.dart';
import 'package:let_me_cook/data/category_colors.dart';
import 'package:let_me_cook/components/bottom_bar.dart';

class RecipeJournal extends StatefulWidget {
  const RecipeJournal({super.key});

  @override
  State<RecipeJournal> createState() => _RecipeJournalState();
}

class _RecipeJournalState extends State<RecipeJournal> {
  final List<String> categories = [
    'appetizer',
    'first course',
    'main course',
    'side dish',
    'dessert',
  ];

  int _currentIndex = 0;

  void _onTabSelected(int index) {
    // Per ora cambiamo solo l'indice selezionato; eventuale navigazione può essere
    // aggiunta qui (es. aprire Favorites o Profile)
    setState(() {
      _currentIndex = index;
    });

    // Esempio minimo: mostrare uno snack per le tab non implementate
    if (index != 0) {
      final labels = ['Home', 'Favorites', 'Profile'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${labels[index]} non ancora implementata')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryHeader(
              title: "Recipe Journal",
              category: "journal",
              searchValue: '',
              onSearchChanged: (_) {},
              backgroundColor: const Color(0xFF1C5679),
              showSearchBar: false,
              showBackButton: false,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Categories",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Dosis',
                  color: Color(0xFF3B3B3B),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CategoryPage(category: category),
                            ),
                          );
                        },
                        child: Card(
                          color: getCategoryColor(category),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(
                            width: 145,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  category.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Dosis',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
