// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  _AnimationScreennState createState() => _AnimationScreennState();
}

class _AnimationScreennState extends State<AnimationScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay
    Timer(const Duration(seconds: 3), () {
      // After 3 seconds, navigate to the IntroPage
      Navigator.pushNamed(context, '/intro');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set the background color for the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Lottie animation for splash screen
            Lottie.asset(
              'assets/50.json', // Path to your Lottie animation file
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
