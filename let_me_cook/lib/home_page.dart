import 'package:flutter/material.dart';
import 'package:let_me_cook/components/bottom_bar.dart';
import 'package:let_me_cook/recepies_filter/MVVM/filtered_recipes.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_page.dart';
import 'package:let_me_cook/recepies_filter/MVVM/food_list_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FoodListViewModel viewModel = FoodListViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadFoodList();
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
              Container(
                color: const Color(0xFF7D8554),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Hello Mario!\nReady to cook with what's in your kitchen?",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                            Image.asset("assets/images/chef.png", height: 100),
                          ],
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

              const SizedBox(height: 10),
              const Text(
                "What's in the fridge",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // GRID BOTTONI INGREDIENTI
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
                                  /*const Icon(
                                    Icons.food_bank,
                                    color: Colors.white,
                                    size: 28,
                                  ),*/
                                  const SizedBox(height: 4),
                                  Text(
                                    ingredient,
                                    style: const TextStyle(
                                      color: Colors.white,
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

              // 🔵 BOTTONE BLU: Mostra le ricette filtrate
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
                      // Applica il filtro e apri la pagina con i risultati
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
                    child: const Text("Let the cooking Begin"),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Text("Recipe of the day"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/recipe_day.png',
                  fit: BoxFit.fitWidth,
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
