import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final _audio = AudioService();
  static const _colors = [Colors.red, Colors.orange, Colors.amber,
    Colors.green, Colors.teal, Colors.blue, Colors.purple];
  static const _labels = ['Đô', 'Rê', 'Mi', 'Fa', 'Sol', 'La', 'Si'];
  Future<void> _play(int i) async {
    try {
      await _audio.play(i);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không phát được âm thanh. Kiểm tra assets.')));
    }
  }
  @override
  void dispose() { _audio.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Xylophone')),
    body: SafeArea(child: Column(children: List.generate(7, (i) => Expanded(
      child: SizedBox(width: double.infinity, child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: _colors[i],
            foregroundColor: Colors.black, shape: const RoundedRectangleBorder()),
          onPressed: () => _play(i),
          child: Text(_labels[i], style: const TextStyle(fontSize: 22)),
        ),
      )),
    )))),
  );
}
