import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF102536),
    appBar: AppBar(title: const Text('I Am Rich')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset('assets/images/diamond.png', width: 220, height: 220),
      const SizedBox(height: 24),
      const Text('I AM RICH', style: TextStyle(color: Colors.white,
          fontSize: 32, fontWeight: FontWeight.bold)),
      const Text('Xin chào, tôi đang học Flutter!',
          style: TextStyle(color: Colors.white70)),
    ])),
  );
}
