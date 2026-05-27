import 'package:flutter/material.dart';

import 'root_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.agriculture, size: 80),
          const SizedBox(height: 16),
          const Text('Offline-first farming management for Indian farmers', textAlign: TextAlign.center),
          const SizedBox(height: 20),
          FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootScreen())), child: const Text('Get Started')),
        ]),
      ),
    );
  }
}
