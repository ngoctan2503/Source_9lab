import 'package:flutter/material.dart';
class CounterCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;
  const CounterCard({super.key, required this.label, required this.value,
    required this.onMinus, required this.onPlus});
  @override
  Widget build(BuildContext context) => Card(child: Padding(
    padding: const EdgeInsets.all(12), child: Column(children: [
      Text(label),
      Text('$value', style: const TextStyle(fontSize: 32)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(onPressed: onMinus, tooltip: 'Giảm $label', icon: const Icon(Icons.remove)),
        IconButton(onPressed: onPlus, tooltip: 'Tăng $label', icon: const Icon(Icons.add)),
      ]),
    ]),
  ));
}
