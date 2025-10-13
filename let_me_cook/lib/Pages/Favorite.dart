import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Faves")),
      body: Column(
        children: [
          CarouselView(
            itemExtent: 20,
            children: [
              SizedBox(child: Text('Appetizer')),
              SizedBox(child: Text('First Course')),
              SizedBox(child: Text('Main Course')),
              SizedBox(child: Text('Side Dish')),
              SizedBox(child: Text('Dessert')),
            ],
          ),
        ],
      ),
    );
  }
}
