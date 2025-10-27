import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/on_boarding_2.dart';
import 'package:let_me_cook/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  Future<void> _finishAndGoHome(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => _finishAndGoHome(context),
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Naviga verso la pagina FoodListPage quando si fa tap
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnBoarding2()),
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
                      Positioned(
                        bottom: 20,
                        left: 50,
                        right: 50,
                        child: Image.asset(
                          'assets/images/onboarding.png',
                          width: 200,
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
