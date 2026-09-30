import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherException implements Exception {
  final String message;
  const WeatherException(this.message);
  @override
  String toString() => message;
}

class WeatherService {
  final String apiKey;
  final http.Client _client;
  WeatherService({required this.apiKey, http.Client? client})
      : _client = client ?? http.Client();

  Future<dynamic> _get(String path, Map<String, String> parameters) async {
    if (apiKey.trim().isEmpty) {
      throw const WeatherException('Chưa cấu hình OPENWEATHER_API_KEY. Xem README.');
    }
    final uri = Uri.https('api.openweathermap.org', path,
      {...parameters, 'appid': apiKey});
    try {
      final response = await _client.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 401) {
        throw const WeatherException('API key không hợp lệ hoặc chưa được kích hoạt.');
      }
      if (response.statusCode == 429) {
        throw const WeatherException('Vượt giới hạn API. Vui lòng thử lại sau.');
      }
      if (response.statusCode != 200) {
        throw WeatherException('Dịch vụ thời tiết báo lỗi HTTP ${response.statusCode}.');
      }
      return jsonDecode(utf8.decode(response.bodyBytes));
    } on TimeoutException {
      throw const WeatherException('Kết nối quá lâu. Vui lòng thử lại.');
    } on http.ClientException {
      throw const WeatherException('Không kết nối được dịch vụ. Kiểm tra Internet.');
    } on FormatException {
      throw const WeatherException('Dịch vụ trả về dữ liệu không hợp lệ.');
    }
  }

  Future<Weather> byCoordinates(double lat, double lon) async {
    final data = await _get('/data/2.5/weather', {
      'lat': '$lat', 'lon': '$lon', 'units': 'metric', 'lang': 'vi',
    });
    return Weather.fromJson(data as Map<String, dynamic>);
  }

  Future<Weather> byCity(String city) async {
    final query = city.trim();
    if (query.isEmpty) throw const WeatherException('Vui lòng nhập tên thành phố.');
    // Geocoding -> tọa độ -> thời tiết, thay vì phụ thuộc truy vấn tên cũ.
    final places = await _get('/geo/1.0/direct', {'q': query, 'limit': '1'}) as List;
    if (places.isEmpty) {
      throw const WeatherException('Không tìm thấy thành phố. Thử tên kèm mã nước, ví dụ Da Nang,VN.');
    }
    final first = places.first as Map<String, dynamic>;
    return byCoordinates((first['lat'] as num).toDouble(), (first['lon'] as num).toDouble());
  }
  void dispose() => _client.close();
}
