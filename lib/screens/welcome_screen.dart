import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // 🎬 Animated Title
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Welcome to Cash Money 💰'),
                    TypewriterAnimatedText('Build Your Future 🚀'),
                    TypewriterAnimatedText('Let’s Get Started!'),
                  ],
                  repeatForever: true,
                  pause: const Duration(milliseconds: 800),
                ),
              ),

              const SizedBox(height: 50),

              // 📄 Subtitle
              const Text(
                'Create an account and start your journey today.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 40),

              // 🚀 Start Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}