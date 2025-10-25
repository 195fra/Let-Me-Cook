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
      //appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color(0xFF7D8554),
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
                          Text("Hello Mario!\nReady to cook with what's in your kitchen?",
                          style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                          Image.asset("assets/images/chef.png", height: 100,),
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
            Row(
              //immagine persona e testo+bottone
            ),
            Text("whats in the fridge", textAlign: TextAlign.left,),
            Container(
              padding: EdgeInsets.all(8),
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        ...List.generate(10, (index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8),
                            ),
                            onPressed: () {},
                            child: const Icon(
                              Icons.food_bank,
                              color: Colors.green,
                              size: 32,
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
                        MaterialPageRoute(builder: (context) => FoodListPage()),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ],

                //elenco di ingredienti e tasto +
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox( width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Let the cooking Begin"),
                ),
              ),
            ),
            Text("recipe of the day"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/recipe_day.png', fit: BoxFit.fitWidth,),
            ),
            // piatto del giorno
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
