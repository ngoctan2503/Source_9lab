import '../models/story_node.dart';
// Câu chuyện tự viết, node không có lựa chọn là một kết thúc.
const storyNodes = <int, StoryNode>{
  0: StoryNode('Bạn đến một hòn đảo trước khi trời tối. Có hai lối đi.', [
    StoryChoice('Đi theo bờ biển', 1), StoryChoice('Đi vào rừng', 2)]),
  1: StoryNode('Bạn thấy một ngọn hải đăng và một chiếc thuyền nhỏ.', [
    StoryChoice('Đến hải đăng', 3), StoryChoice('Kiểm tra thuyền', 4)]),
  2: StoryNode('Bạn gặp một người giữ rừng đang tìm đường về trạm.', [
    StoryChoice('Cùng đi về trạm', 3), StoryChoice('Tiếp tục đi một mình', 5)]),
  3: StoryNode('Bạn tìm được chỗ trú an toàn và gọi được đội cứu hộ. Kết thúc tốt!', []),
  4: StoryNode('Thuyền bị thủng. Bạn ở lại bờ biển, nhóm lửa và chờ tới sáng. Kết thúc chờ đợi.', []),
  5: StoryNode('Trời tối, bạn lạc đường và phải quay lại điểm xuất phát. Hãy thử hướng khác!', []),
};
