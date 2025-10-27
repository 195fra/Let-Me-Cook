import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/recipe_journal.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
          ),
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeJournal()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
          ),
        ],
      ),
    );
  }
}
