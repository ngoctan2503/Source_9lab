import 'package:flutter/material.dart';
import '../logic/bmi_calculator.dart';
class ResultScreen extends StatelessWidget {
  final double bmi;
  const ResultScreen({super.key, required this.bmi});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Kết quả BMI')),
    body: Center(child: Padding(padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('CHỈ SỐ BMI'),
        Text(bmi.toStringAsFixed(1), style: const TextStyle(fontSize: 72,
          fontWeight: FontWeight.bold, color: Colors.teal)),
        Text(BmiCalculator.category(bmi), style: const TextStyle(fontSize: 24)),
        const Text('BMI = cân nặng (kg) / chiều cao² (m²)'),
        const SizedBox(height: 20),
        const Text('Bài thực hành tính toán, không dùng để chẩn đoán sức khỏe.',
          textAlign: TextAlign.center),
        const SizedBox(height: 24),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Tính lại')),
      ]),
    )),
  );
}
