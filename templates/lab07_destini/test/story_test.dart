import 'package:flutter_test/flutter_test.dart';
import 'package:lab07_destini/data/story_data.dart';
import 'package:lab07_destini/logic/story_controller.dart';
void main() {
  test('Mọi nhánh đều trỏ tới node tồn tại và kết thúc không có lựa chọn', () {
    for (final node in storyNodes.values) {
      for (final choice in node.choices) {
        expect(storyNodes.containsKey(choice.nextId), true);
      }
    }
    final story = StoryController();
    story.choose(0); story.choose(0);
    expect(story.current.isEnding, true);
    story.restart();
    expect(story.current, storyNodes[0]);
  });
}
