import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/appetizer_category.dart';

class RecipeJournal extends StatefulWidget {
  const RecipeJournal({super.key});

  @override
  State<RecipeJournal> createState() => _RecipeJournalState();
}

class _RecipeJournalState extends State<RecipeJournal> {
  @override
  Widget build(BuildContext context) {
    // Lista delle categorie
    final List<String> categories = [
      "first course",
      "appetizer",
      "dessert",
      "side dish",
      "main course",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Journal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(category: category),
                    ),
                  );
                },
                child: Text(category),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
