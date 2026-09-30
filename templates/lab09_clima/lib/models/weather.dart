class Weather {
  final String city;
  final double temperature;
  final int humidity;
  final String description;
  final int conditionId;
  const Weather({required this.city, required this.temperature,
    required this.humidity, required this.description, required this.conditionId});
  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final condition = (json['weather'] as List).first as Map<String, dynamic>;
    return Weather(city: (json['name'] as String?) ?? 'Vị trí hiện tại',
      temperature: (main['temp'] as num).toDouble(),
      humidity: (main['humidity'] as num).toInt(),
      description: condition['description'] as String,
      conditionId: (condition['id'] as num).toInt());
  }
}
