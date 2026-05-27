import 'package:flutter/material.dart';

import 'root_shell.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0D5B32), Color(0xFF7CB342)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Offline Farming Assistant', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              const Text('Manage fields, expenses, crops and reminders in English/Hindi.', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const RootShell())),
                child: const Text('Get Started'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
