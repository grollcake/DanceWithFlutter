import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static const _dropSoundFile = 'sound/drop.wav';
  static const _rotateSoundFile = 'sound/rotate.wav';

  late AudioCache _audioCache;
  void init() {
    _audioCache = AudioCache();
    _audioCache.loadAll([_dropSoundFile, _rotateSoundFile]);
  }

  Future<void> _play(String soundFile) async {
    await _audioCache.play(soundFile);
  }

  Future<void> dropSound() async {
    await _play(_dropSoundFile);
  }

  Future<void> rotateSound() async {
    await _play(_rotateSoundFile);
  }
}
