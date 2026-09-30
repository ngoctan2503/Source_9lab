import 'dart:async';
import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final _city = TextEditingController();
  final _weatherService = WeatherService(
    apiKey: const String.fromEnvironment('OPENWEATHER_API_KEY'));
  final _location = LocationService();
  Weather? _weather;
  bool _loading = false;
  String? _error;
  Future<void> _load({bool useLocation = false}) async {
    if (_loading) return;
    setState(() { _loading = true; _error = null; _weather = null; });
    try {
      final Weather result;
      if (useLocation) {
        final position = await _location.current();
        result = await _weatherService.byCoordinates(position.latitude, position.longitude);
      } else {
        result = await _weatherService.byCity(_city.text);
      }
      if (mounted) setState(() => _weather = result);
    } on WeatherException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } on TimeoutException {
      if (mounted) setState(() => _error = 'Lấy vị trí quá lâu. Hãy tìm bằng tên thành phố.');
    } catch (_) {
      if (mounted) setState(() => _error = 'Không lấy được dữ liệu. Kiểm tra kết nối và quyền vị trí rồi thử lại.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
  IconData _icon(int id) {
    if (id < 600) return Icons.umbrella;
    if (id < 700) return Icons.ac_unit;
    if (id == 800) return Icons.wb_sunny;
    return Icons.cloud;
  }
  @override
  void dispose() {
    _city.dispose(); _weatherService.dispose(); super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Clima')),
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 560),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _city, enabled: !_loading,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(labelText: 'Thành phố',
              hintText: 'Da Nang,VN', border: OutlineInputBorder()),
            onSubmitted: (_) => _load()),
          const SizedBox(height: 12),
          Wrap(spacing: 12, runSpacing: 12, children: [
            FilledButton.icon(onPressed: _loading ? null : () => _load(),
              icon: const Icon(Icons.search), label: const Text('Tìm thành phố')),
            OutlinedButton.icon(onPressed: _loading ? null : () => _load(useLocation: true),
              icon: const Icon(Icons.my_location), label: const Text('Vị trí của tôi')),
          ]),
          const SizedBox(height: 32),
          if (_loading) const CircularProgressIndicator(),
          if (_error != null) Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center),
          if (_weather != null) ...[
            Icon(_icon(_weather!.conditionId), size: 84, color: Colors.orange),
            Text(_weather!.city, style: const TextStyle(fontSize: 28)),
            Text('${_weather!.temperature.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold)),
            Text(_weather!.description, style: const TextStyle(fontSize: 22)),
            Text('Độ ẩm: ${_weather!.humidity}%'),
          ],
          if (!_loading && _error == null && _weather == null)
            const Text('Nhập thành phố hoặc chọn vị trí để lấy thời tiết thực tế.'),
        ]),
      ),
    )),
  );
}
