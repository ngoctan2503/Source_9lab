import '../data/questions.dart';
import '../models/question.dart';
class QuizController {
  int _index = 0;
  final List<bool> _results = [];
  int get total => questions.length;
  int get answered => _index;
  bool get isFinished => _index >= total;
  Question get current => questions[_index];
  List<bool> get results => List.unmodifiable(_results);
  int get score => _results.where((correct) => correct).length;
  void answer(bool value) {
    if (isFinished) return;
    _results.add(value == current.answer);
    _index++;
  }
  void reset() { _index = 0; _results.clear(); }
}
