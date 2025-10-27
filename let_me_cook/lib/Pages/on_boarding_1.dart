import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/on_boarding_2.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8B9A6B), // Olive green
              Color(0xFFF5F5DC), // Beige/cream
            ],
            stops: [0.0, 0.6],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button at top right
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OnBoarding2()),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      const Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                      const Text(
                        'Let Me Cook!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Description text
                      const Text(
                        'Your kitchen sidekic even with an almost empty fridge.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5A5A5A),
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Discover what you can cook with what you already have. No waste, just creativity.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5A5A5A),
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Chef illustration with ingredients
                      Container(
                        height: 400,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Chef character
                            Container(
                              width: 120,
                              height: 200,
                              child: Column(
                                children: [
                                  // Chef head
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFDBB5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '😊',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),

                                  // Chef hat
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),
                                  ),

                                  // Chef body
                                  Container(
                                    width: 80,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '👨‍🍳',
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Floating ingredients around chef
                            ...List.generate(12, (index) {
                              final ingredients = [
                                '🥕',
                                '🍅',
                                '🥬',
                                '🥒',
                                '🧄',
                                '🧅',
                                '🥔',
                                '🌽',
                                '🍆',
                                '🥩',
                                '🐟',
                                '🍳',
                              ];
                              final positions = [
                                const Offset(-120, -100),
                                const Offset(120, -80),
                                const Offset(-100, 0),
                                const Offset(100, 20),
                                const Offset(-80, 100),
                                const Offset(80, 120),
                                const Offset(-140, -40),
                                const Offset(140, -20),
                                const Offset(-60, -140),
                                const Offset(60, -120),
                                const Offset(-20, 140),
                                const Offset(20, 160),
                              ];

                              return Positioned(
                                left: 200 + positions[index].dx,
                                top: 200 + positions[index].dy,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      ingredients[index],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
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
