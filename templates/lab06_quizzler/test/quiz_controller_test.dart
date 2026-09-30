import 'package:flutter_test/flutter_test.dart';
import 'package:lab06_quizzler/logic/quiz_controller.dart';
void main() {
  test('Hoàn thành không vượt chỉ số; reset xóa điểm và lịch sử', () {
    final quiz = QuizController();
    while (!quiz.isFinished) { quiz.answer(quiz.current.answer); }
    expect(quiz.score, quiz.total);
    quiz.answer(false);
    expect(quiz.results.length, quiz.total);
    quiz.reset();
    expect(quiz.answered, 0);
    expect(quiz.score, 0);
    expect(quiz.isFinished, false);
  });
}
