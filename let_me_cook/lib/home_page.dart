import 'dart:math';
import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/Recipe_page.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/recepies_filter/MVVM/filtered_recipes.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_page.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_viewmodel.dart';
import 'package:let_me_cook/recepies_filter/food_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FoodListViewModel viewModel = FoodListViewModel();
  FoodItem? randomRecipe;

  @override
  void initState() {
    super.initState();
    // Carica le ricette e seleziona una ricetta del giorno una sola volta
    viewModel.loadFoodList().then((_) {
      if (viewModel.allFoodItems.isNotEmpty) {
        setState(() {
          randomRecipe = viewModel
              .allFoodItems[Random().nextInt(viewModel.allFoodItems.length)];
        });
      }
    });
    viewModel.setAction('Add'); // for the ingredients button color
  }

  // Ingredienti iniziali comuni
  final List<String> fridgeIngredients = [
    'Tomato',
    'Beef',
    'Lemon',
    'Pasta',
    'Pepper',
    'Salt',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  color: const Color(0xFF7D8554),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hello Mario!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const Text(
                                  "Ready to cook with what's in your kitchen?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Image.asset(
                                  "assets/images/chef.png",
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/image_1.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "What's in the fridge",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(8),
                height: 170,
                child: Row(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.9,
                        children: [
                          ...fridgeIngredients.map((ingredient) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: viewModel
                                    .getIngredientButtonColor(ingredient),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(8),
                              ),
                              onPressed: () {
                                setState(() {
                                  viewModel.toggleIngredient(ingredient);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    ingredient,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(40, 110),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodListPage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      viewModel.filterRecipes();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilteredRecipesPage(
                            filteredFoodItems: viewModel.filteredFoodItems,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Let the cooking Begin",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Recipe of the day",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (randomRecipe != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipePage(foodItem: randomRecipe!),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                randomRecipe!.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/images/chef_special.png',
                                width: 120,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
