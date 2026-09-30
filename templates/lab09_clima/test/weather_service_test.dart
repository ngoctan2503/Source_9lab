import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab09_clima/services/weather_service.dart';
void main() {
  test('Tìm thành phố qua geocoding và dùng Celsius', () async {
    final service = WeatherService(apiKey: 'test', client: MockClient((request) async {
      if (request.url.path == '/geo/1.0/direct') {
        return http.Response('[{"lat":16.05,"lon":108.2}]', 200);
      }
      expect(request.url.queryParameters['units'], 'metric');
      expect(request.url.queryParameters['lat'], '16.05');
      return http.Response('{"name":"Da Nang","main":{"temp":28.5,"humidity":80},'
        '"weather":[{"id":800,"description":"clear sky"}]}', 200);
    }));
    addTearDown(service.dispose);
    final weather = await service.byCity('Da Nang,VN');
    expect(weather.temperature, 28.5);
    expect(weather.humidity, 80);
  });
  test('Thiếu key và HTTP 401 trả lỗi có thể hiển thị', () async {
    final missing = WeatherService(apiKey: '');
    addTearDown(missing.dispose);
    await expectLater(missing.byCity('Da Nang'), throwsA(isA<WeatherException>()));
    final invalid = WeatherService(apiKey: 'bad',
      client: MockClient((_) async => http.Response('{}', 401)));
    addTearDown(invalid.dispose);
    await expectLater(invalid.byCoordinates(1, 1), throwsA(isA<WeatherException>()));
  });
}
