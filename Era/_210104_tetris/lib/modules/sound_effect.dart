import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:tetris/managers/app_settings.dart';

class SoundEffect {
  Soundpool? _soundpool;
  int rotateSoundId = 0; // 블록 회전
  int fixingSoundId = 0; // 블록 위치 확정
  int dropSoundId = 0; // 블록 떨어뜨리기
  int clearningSoundId = 0; // 완성줄 삭제
  int holdSoundId = 0; // 블록 보관
  int gameEndSoundId = 0; // 게임종료
  int levelUpSoundId = 0; // 현재 레벨 완료

  AppSettings settings = AppSettings();

  Future<void> init() async {
    _soundpool = Soundpool(streamType: StreamType.alarm);

    var asset = await rootBundle.load('assets/sound/rotate.wav');
    rotateSoundId = await _soundpool!.load(asset);

    asset = await rootBundle.load('assets/sound/fixing.wav');
    fixingSoundId = await _soundpool!.load(asset);

    asset = await rootBundle.load('assets/sound/drop.wav');
    dropSoundId = await _soundpool!.load(asset);

    asset = await rootBundle.load('assets/sound/clearning.wav');
    clearningSoundId = await _soundpool!.load(asset);

    asset = await rootBundle.load('assets/sound/hold.wav');
    holdSoundId = await _soundpool!.load(asset);

    asset = await rootBundle.load('assets/sound/game-end.wav');
    gameEndSoundId = await _soundpool!.load(asset);

    asset = await rootBundle.load('assets/sound/level-up.wav');
    levelUpSoundId = await _soundpool!.load(asset);

    print('SoundEffect loaded ok');
  }

  void dispose() {
    if (_soundpool == null) {
      return;
    }
    _soundpool!.release();
    _soundpool!.dispose();
  }

  Future<int> _sound(int soundId) async {
    if (_soundpool != null && !settings.soundEffect) {
      return 0;
    }
    return await _soundpool!.play(soundId);
  }

  Future<int> rotateSound() async => _sound(rotateSoundId);
  Future<int> fixingSound() async => _sound(fixingSoundId);
  Future<int> dropSound() async => _sound(dropSoundId);
  Future<int> clearningSound() async => _sound(clearningSoundId);
  Future<int> holdSound() async => _sound(holdSoundId);
  Future<int> gameEndSound() async => _sound(gameEndSoundId);
  Future<int> levelUpSound() async => _sound(levelUpSoundId);
}
