class BmiCalculator {
  static double calculate({required double heightCm, required double weightKg}) {
    if (!heightCm.isFinite || !weightKg.isFinite || heightCm <= 0 || weightKg <= 0) {
      throw ArgumentError('Chiều cao và cân nặng phải là số dương hữu hạn.');
    }
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }
  static String category(double bmi) {
    if (bmi < 18.5) return 'Thiếu cân';
    if (bmi < 25) return 'Cân nặng khỏe mạnh';
    if (bmi < 30) return 'Thừa cân';
    return 'Béo phì';
  }
}
