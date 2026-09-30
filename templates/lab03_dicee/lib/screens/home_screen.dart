import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();
  int _left = 1;
  int _right = 1;
  void _roll() => setState(() {
    _left = _random.nextInt(6) + 1;
    _right = _random.nextInt(6) + 1;
  });
  Widget _die(int value) => Expanded(child: Semantics(
    label: 'Xúc xắc $value điểm', button: true,
    child: InkWell(onTap: _roll, child: Padding(
      padding: const EdgeInsets.all(12),
      child: Image.asset('assets/images/dice$value.png'),
    )),
  ));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Dicee')),
    body: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [_die(_left), _die(_right)]),
        Text('Tổng: ${_left + _right}', style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 20),
        FilledButton(onPressed: _roll, child: const Text('Gieo xúc xắc')),
      ]),
    )),
  );
}
