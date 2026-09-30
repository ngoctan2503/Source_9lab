import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  // Một player mỗi nốt để các nốt khác nhau có thể chồng âm.
  final _players = List.generate(7, (_) => AudioPlayer());
  Future<void> play(int index) async {
    final player = _players[index];
    await player.stop();
    await player.play(AssetSource('audio/note${index + 1}.wav'));
  }
  void dispose() {
    for (final player in _players) { unawaited(player.dispose()); }
  }
}
