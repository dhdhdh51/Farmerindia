import 'package:flutter/material.dart';
import 'home_shell.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF43A047), Color(0xFFA5D6A7)])),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.agriculture, size: 84, color: Colors.white),
            const SizedBox(height: 16),
            const Text('स्वागत है • Welcome', style: TextStyle(fontSize: 26, color: Colors.white)),
            const SizedBox(height: 20),
            FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeShell())), child: const Text('Start')),
          ]),
        ),
      ),
    );
  }
}
