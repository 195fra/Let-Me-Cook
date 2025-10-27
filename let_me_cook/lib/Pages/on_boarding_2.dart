import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/on_boarding_3.dart';
import 'package:let_me_cook/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  bool _navigated = false;

  Future<void> _finishAndGoHome(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void _goNext() {
    if (_navigated) return;
    _navigated = true;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OnBoarding3()),
    ).then((_) {
      // allow future navigations if user comes back
      _navigated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFE8DA), Color(0xFFDDEAD8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        onPressed: () => _finishAndGoHome(context),
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main content: only the phone image is tappable to go next
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _goNext,
                        child: Container(
                          width: 260,
                          height: 520,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.12),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                            border: Border.fromBorderSide(
                              BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.6),
                                width: 1,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // phone image (screen) - tap this to advance
                                Image.asset(
                                  'assets/images/on_boarding_2_phone.png',
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),
                      const Text(
                        'Add Your Ingredients',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B3A2F),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Got carrots, eggs, and some cheese? Perfect. Let Me Cook finds quick, tasty recipes tailored to your ingredients.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4B5B4B),
                        ),
                      ),
                      const SizedBox(height: 14),
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
