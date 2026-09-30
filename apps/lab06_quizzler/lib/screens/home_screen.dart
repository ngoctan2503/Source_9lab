import 'package:flutter/material.dart';
import '../logic/quiz_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final _quiz = QuizController();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Quizzler')),
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          LinearProgressIndicator(value: _quiz.answered / _quiz.total),
          const SizedBox(height: 28),
          if (_quiz.isFinished) ...[
            Text('Kết quả: ${_quiz.score}/${_quiz.total}',
              style: const TextStyle(fontSize: 30)),
            FilledButton(onPressed: () => setState(_quiz.reset),
              child: const Text('Làm lại')),
          ] else ...[
            Text('Câu ${_quiz.answered + 1}/${_quiz.total}'),
            const SizedBox(height: 24),
            Text(_quiz.current.text, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FilledButton(onPressed: () => setState(() => _quiz.answer(true)),
                child: const Text('Đúng')),
              const SizedBox(width: 16),
              OutlinedButton(onPressed: () => setState(() => _quiz.answer(false)),
                child: const Text('Sai')),
            ]),
          ],
          const SizedBox(height: 24),
          Wrap(children: _quiz.results.map((correct) => Icon(
            correct ? Icons.check_circle : Icons.cancel,
            color: correct ? Colors.green : Colors.red)).toList()),
        ]),
      ),
    ))),
  );
}
