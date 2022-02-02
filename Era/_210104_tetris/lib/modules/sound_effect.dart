import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SoundEffect {
  Soundpool? _soundpool;
  SoundpoolOptions _soundpoolOptions = SoundpoolOptions();
  int dropSoundId = 0;
  int rotateSoundId = 0;

  Future<void> init() async {
    _soundpool = Soundpool.fromOptions(options: _soundpoolOptions);
    if (!kIsWeb) {}
    var asset1 = await rootBundle.load('assets/sound/drop.wav');
    dropSoundId = await _soundpool!.load(asset1);

    var asset2 = await rootBundle.load('assets/sound/rotate.wav');
    rotateSoundId = await _soundpool!.load(asset2);
    debugPrint('Soundpool is initialized successfully');
  }

  Future<void> dispose() async {
    if (_soundpool == null) {
      return;
    }
    _soundpool!.release();
    _soundpool!.dispose();
  }

  Future<int> dropSound() async {
    if (_soundpool == null) {
      return 0;
    }
    int streamId = await _soundpool!.play(dropSoundId);
    return streamId;
  }

  Future<int> rotateSound() async {
    if (_soundpool == null) {
      return 0;
    }
    int streamId = await _soundpool!.play(rotateSoundId);
    return streamId;
  }
}
