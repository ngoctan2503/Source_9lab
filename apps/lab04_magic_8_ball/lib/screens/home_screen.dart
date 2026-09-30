import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();
  static const _answers = [
    'Chắc chắn có!',
    'Có thể lắm!',
    'Hãy thử lại sau',
    'Đừng vội quyết định',
    'Có lẽ là không',
    'Cơ hội đang đến!',
    'Hãy tin vào bản thân!',
  ];
  String _answer = 'Chạm để hỏi';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Magic 8 Ball')),
        body: Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Nghĩ một câu hỏi Có / Không rồi chạm vào quả cầu.'),
            const SizedBox(height: 32),
            Semantics(
              button: true,
              label: 'Lấy câu trả lời ngẫu nhiên',
              child: InkWell(
                borderRadius: BorderRadius.circular(160),
                onTap: () => setState(() {
                  _answer = _answers[_random.nextInt(_answers.length)];
                }),
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF122038)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(40),
                  child: Text(_answer,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 26, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Trò chơi giải trí — câu trả lời được chọn ngẫu nhiên.'),
          ]),
        )),
      );
}
