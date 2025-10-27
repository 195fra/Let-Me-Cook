import 'package:flutter/material.dart';
import 'package:let_me_cook/Pages/on_boarding_2.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Onboarding Example',
     theme: ThemeData(
       primarySwatch: Colors.green,
     ),
     home: const OnBoarding3(),
   );
 }
}


class OnBoarding3 extends StatelessWidget {
 const OnBoarding3({super.key});


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
       automaticallyImplyLeading: false,
       leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.white),
         onPressed: () {
           // Navigate to SecondPage when tapped
           Navigator.push(
             context,
             MaterialPageRoute(builder: (_) =>
             OnBoarding2()),
           );
         },
       ),
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 12.0),
           child: TextButton(
             onPressed: () {
               // Navigate to NextPage when tapped
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (_) => const NextPage()),
               );
             },
             child: const Text(
               'Continue',
               style: TextStyle(color: Colors.white),
             ),
           ),
         ),
       ],
     ),
     body: Stack(
       children: [
         // Full-screen image of the uploaded reference (use your uploaded file)
         Positioned.fill(
           child: Image.asset(
             'assets/onboarding_reference.png', // <-- replace with your uploaded image filename
             fit: BoxFit.cover,
           ),
         ),
       ],
     ),
   );
 }
}


class SecondPage extends StatelessWidget {
 const SecondPage({super.key});
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('SecondPage')),
     body: const Center(child: Text('This is SecondPage')),
   );
 }
}


class NextPage extends StatelessWidget {
 const NextPage({super.key});
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: const Text('Next Page')),
     body: const Center(child: Text('This is the Next Page')),
   );
 }
}

