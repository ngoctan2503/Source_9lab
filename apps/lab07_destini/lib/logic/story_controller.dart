import '../data/story_data.dart';
import '../models/story_node.dart';
class StoryController {
  int _id = 0;
  StoryNode get current => storyNodes[_id]!;
  void choose(int choiceIndex) {
    if (current.isEnding) return;
    _id = current.choices[choiceIndex].nextId;
  }
  void restart() { _id = 0; }
}
