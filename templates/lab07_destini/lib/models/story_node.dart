class StoryChoice {
  final String text;
  final int nextId;
  const StoryChoice(this.text, this.nextId);
}
class StoryNode {
  final String text;
  final List<StoryChoice> choices;
  const StoryNode(this.text, this.choices);
  bool get isEnding => choices.isEmpty;
}
