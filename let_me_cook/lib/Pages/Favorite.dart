import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Faves')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Chip(label: Text('All')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Chip(label: Text('Appetizer')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Chip(label: Text('First Course')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Chip(label: Text('Main Course')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Chip(label: Text('Side Dish')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Chip(label: Text('Dessert')),
                ),
              ],
            ),
          ),
          Column(
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
