import 'package:flutter/material.dart';
import 'package:let_me_cook/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

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
    final screen = MediaQuery.of(context).size;
    // adattiamo l'immagine in percentuale dello schermo
    final imageWidth = screen.width * 0.85;
    final imageHeight = screen.height * 0.60;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // top colored area
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFF7B845E),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
            ),

            // back button
            Positioned(
              left: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // continue button
            Positioned(
              right: 12,
              top: 12,
              child: TextButton(
                onPressed: () => _finishAndGoHome(context),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // main content: titolo, immagine adattiva e testo
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 36),
                    const Text(
                      'Cook without\nstress',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2B2B2B),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // immagine che si adatta allo schermo (non esce sotto)
                    SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 0.12),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/on_boarding_3_img.png',
                            fit: BoxFit
                                .contain, // contiene l'immagine senza overflow
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
