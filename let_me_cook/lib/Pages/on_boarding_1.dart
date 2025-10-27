import 'package:flutter/material.dart';
import 'package:let_me_cook/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // Action for Skip button
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
            // Naviga verso la pagina FoodListPage quando si fa tap
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main title text
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Let Me Cook!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
        
              // Description text
              Text(
                'Your kitchen sidekick even with an almost empty fridge.\n'
                'Discover what you can cook with what you already have.\n'
                'No waste, just creativity.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 40),
        
              // Image and floating food items - Loading the image from assets
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      // Chef illustration from assets
                      Positioned(
                        bottom: 20,
                        left: 50,
                        right: 50,
                        child: Image.asset(
                          'assets/images/onboarding.png', // Path to your asset
                          width: 200, // Adjust size as needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
