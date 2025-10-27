import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/on_boarding_1.dart';
import 'package:let_me_cook/Pages/on_boarding_3.dart';

/*
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Onboarding Mock',
     theme: ThemeData(
       primarySwatch: Colors.green,
     ),
     home: OnBoarding2(),
   );
 }
}*/


class OnBoarding2 extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     // Allows the body image to extend behind the transparent AppBar
     extendBodyBehindAppBar: true,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
       automaticallyImplyLeading: false, // we'll provide our own leading
       leading: IconButton(
         icon: Icon(
           Icons.arrow_back,
           color: Colors.white,
           size: 28,
         ),
         onPressed: () {
           // Navigate to FirstPage when back arrow tapped
           Navigator.push(
             context,
             MaterialPageRoute(builder: (_) => WelcomeScreen()),
           );
         },
       ),
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 12.0),
           child: TextButton(
             onPressed: () {
               // Navigate to ThirdPage when Skip tapped
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (_) => OnBoarding3()),
               );
             },
             child: Text(
               'Skip',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 16,
               ),
             ),
           ),
         ),
       ],
     ),
     body: Stack(
       children: [
         // Full-screen reference image (use your uploaded image file here)
         Positioned.fill(
           child: Image.asset(
             'assets/onboarding_reference.png', // <-- add your uploaded image here
             fit: BoxFit.cover,
           ),
         ),
         // Optional overlay to ensure legibility on different devices (kept subtle)
         Positioned.fill(
           child: Container(
             color: Colors.transparent,
           ),
         ),
         // If you need any additional interactive overlays, add them here.
       ],
     ),
   );
 }
}


class FirstPage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('FirstPage'),
     ),
     body: Center(
       child: Text('This is the First Page'),
     ),
   );
 }
}


class ThirdPage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('ThirdPage'),
     ),
     body: Center(
       child: Text('This is the Third Page'),
     ),
   );
 }
}

