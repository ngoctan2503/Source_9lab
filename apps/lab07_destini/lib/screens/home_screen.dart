import 'package:flutter/material.dart';
import '../logic/story_controller.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final _story = StoryController();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Destini')),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.explore, size: 72, color: Colors.teal),
          const SizedBox(height: 24),
          Text(_story.current.text, style: const TextStyle(fontSize: 25)),
          const SizedBox(height: 28),
          for (int i = 0; i < _story.current.choices.length; i++)
            Padding(padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(width: double.infinity,
                child: FilledButton(onPressed: () => setState(() => _story.choose(i)),
                  child: Text(_story.current.choices[i].text)))),
          if (_story.current.isEnding)
            FilledButton(onPressed: () => setState(_story.restart),
              child: const Text('Chơi lại')),
        ]),
      ),
    )),
  );
}
