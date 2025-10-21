import 'package:flutter/material.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            //hello e immagine
          ),
          Row(
            //immagine persona e testo+bottone
          ),
          Text("whats in the fridge"),
          Row(
            children: [
              ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodListPage()),
              );
            },
            child: const Text('Vai alla pagina filtri'),
          ),
            ],
            //elenco di ingredienti e tasto +
          ),
          Text("recipe of the day"),
          // piatto del giorno
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}