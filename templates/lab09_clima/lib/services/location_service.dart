import 'package:geolocator/geolocator.dart';
import 'weather_service.dart';

class LocationService {
  Future<Position> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const WeatherException('Vị trí đang tắt. Hãy bật vị trí hoặc tìm theo thành phố.');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw const WeatherException('Quyền vị trí bị chặn. Mở cài đặt thiết bị/trình duyệt để cấp lại, hoặc tìm thành phố.');
    }
    if (permission == LocationPermission.denied) {
      throw const WeatherException('Bạn chưa cấp quyền vị trí. Có thể tìm bằng tên thành phố.');
    }
    return Geolocator.getCurrentPosition(locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.medium, timeLimit: Duration(seconds: 20)));
  }
}
