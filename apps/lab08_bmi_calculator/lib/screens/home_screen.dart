import 'package:flutter/material.dart';
import '../logic/bmi_calculator.dart';
import '../widgets/counter_card.dart';
import 'result_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  double _height = 170;
  int _weight = 65;
  int _age = 20;
  String _gender = 'Nam';
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('BMI Calculator')),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560),
        child: Column(children: [
          SegmentedButton<String>(segments: const [
            ButtonSegment(value: 'Nam', label: Text('Nam'), icon: Icon(Icons.male)),
            ButtonSegment(value: 'Nữ', label: Text('Nữ'), icon: Icon(Icons.female)),
          ], selected: {_gender}, onSelectionChanged: (v) => setState(() => _gender = v.first)),
          const SizedBox(height: 20),
          Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
            Text('Chiều cao: ${_height.round()} cm', style: const TextStyle(fontSize: 24)),
            Slider(value: _height, min: 100, max: 220, divisions: 120,
              label: '${_height.round()} cm', onChanged: (v) => setState(() => _height = v)),
          ]))),
          Wrap(alignment: WrapAlignment.center, children: [
            SizedBox(width: 230, child: CounterCard(label: 'Cân nặng (kg)', value: _weight,
              onMinus: _weight > 20 ? () => setState(() => _weight--) : null,
              onPlus: _weight < 250 ? () => setState(() => _weight++) : null)),
            SizedBox(width: 230, child: CounterCard(label: 'Tuổi (20+)', value: _age,
              onMinus: _age > 20 ? () => setState(() => _age--) : null,
              onPlus: _age < 100 ? () => setState(() => _age++) : null)),
          ]),
          const SizedBox(height: 20),
          FilledButton(onPressed: () {
            final bmi = BmiCalculator.calculate(heightCm: _height, weightKg: _weight.toDouble());
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => ResultScreen(bmi: bmi)));
          }, child: const Text('TÍNH BMI')),
          const SizedBox(height: 12),
          const Text('Tuổi và giới tính minh họa thao tác giao diện; không tham gia công thức BMI.'),
        ]),
      ),
    )),
  );
}
