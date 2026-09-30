import 'package:flutter_test/flutter_test.dart';
import 'package:lab08_bmi_calculator/logic/bmi_calculator.dart';
void main() {
  test('Đổi cm sang m đúng', () {
    expect(BmiCalculator.calculate(heightCm: 170, weightKg: 65), closeTo(22.49, 0.01));
  });
  test('Phân loại dùng giá trị chưa làm tròn tại các ngưỡng', () {
    expect(BmiCalculator.category(18.5), 'Cân nặng khỏe mạnh');
    expect(BmiCalculator.category(24.99), 'Cân nặng khỏe mạnh');
    expect(BmiCalculator.category(25), 'Thừa cân');
    expect(BmiCalculator.category(30), 'Béo phì');
  });
  test('Không chấp nhận đầu vào không hợp lệ', () {
    for (final value in [0.0, -1.0, double.nan, double.infinity]) {
      expect(() => BmiCalculator.calculate(heightCm: value, weightKg: 65), throwsArgumentError);
    }
  });
}
