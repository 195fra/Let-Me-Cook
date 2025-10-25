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
      body: Column(
        children: [
          Container( color: Color(0xFF7D8554),
            child: 
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text("Hello Mario! \nReady to cook with what's in you kitchen?",                       
            )
            ),
            Image.asset("assets/images/chef.png",height: 100,),
            ],
            ),     
              Image.asset('assets/images/image_1.png')
            ],
            ),
          ),
          Row(
            //immagine persona e testo+bottone
          ),
          Text("whats in the fridge"),
          Container(
            padding: EdgeInsets.all(20),
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: 
                  GridView.count(
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
                      })
                    ],
                  )
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(50, 200),
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
          ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    
                  },
                  child: Text("Let the cooking Beguin"),
                ),
          Text("recipe of the day"),
          Image.asset('assets/images/repice_day.png')
          // piatto del giorno
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}