import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:tetris/constants/constants.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/managers/ttboard_manager.dart';
import 'package:tetris/models/enums.dart';
import 'package:tetris/modules/bgm_player.dart';
import 'package:tetris/modules/sound_effect.dart';

enum GamePlayEvents { gameStarted, gamePaused, gameResumed, gameEnded, stageCleared, blockDropped, gameEndDialogRecall }

class GamePlayManager with ChangeNotifier {
  // Variables
  final TTBoardManager _ttboardManager;
  final StreamController<GamePlayEvents> _gamePlayEvents = StreamController<GamePlayEvents>();
  PlayingStatus _playingStatus = PlayingStatus.paused;
  PausableTimer? _blockTimer;
  Stopwatch _playTime = Stopwatch();
  int _score = 0;
  int _stage = 1;
  int _cleans = 0;
  bool _hideCompletedRow = false;
  BgmPlayer? _bgmPlayer;
  SoundEffect? _soundEffect;

  // getters
  TTBlockID? getBlockId(int x, int y) => _ttboardManager.getBlockId(x, y);

  TTBlockStatus getBlockStatus(int x, int y) => _ttboardManager.getBlockStatus(x, y);

  TTBlockID? get nextBlockId => _ttboardManager.getNextId;

  TTBlockID? get holdBlockId => _ttboardManager.getHoldId;

  Stream<GamePlayEvents> get gamePlayEvents => _gamePlayEvents.stream;

  PlayingStatus get playingStatus => _playingStatus;

  String get elapsedTime => _getFormattedElapsed();

  int get score => _score;

  int get stage => _stage;

  bool get hideCompletedRow => _hideCompletedRow;

  ////////////////////////////////////////////////////////
  // Constructor
  ////////////////////////////////////////////////////////
  GamePlayManager() : _ttboardManager = TTBoardManager() {
    initSound();
    print('GamePlayManager initialized');
  }

  ////////////////////////////////////////////////////////
  // Init sound
  ////////////////////////////////////////////////////////
  void initSound() {
    _bgmPlayer = BgmPlayer();
    _bgmPlayer!.init();

    _soundEffect = SoundEffect();
    _soundEffect!.init();
  }

  ////////////////////////////////////////////////////////
  // Start game
  ////////////////////////////////////////////////////////
  void startGame() {
    _ttboardManager.reset();
    _score = 0;
    _stage = 1;
    _cleans = 0;
    _startBgm();
    _playTime.reset();
    _playTime.start();
    _playingStatus = PlayingStatus.playing;
    _gamePlayEvents.sink.add(GamePlayEvents.gameStarted);
    newBlock();
  }

  ////////////////////////////////////////////////////////
  // New block
  ////////////////////////////////////////////////////////
  void newBlock() {
    if (_ttboardManager.newBlock()) {
      _startTimer();
      notifyListeners();
    } else {
      notifyListeners();
      gameEnd();
    }
  }

  ////////////////////////////////////////////////////////
  // Rotate block
  ////////////////////////////////////////////////////////
  void rotateBlock() {
    if (_ttboardManager.rotate()) {
      _soundEffect?.rotateSound();
      notifyListeners();
    }
  }

  ////////////////////////////////////////////////////////
  // Move block
  ////////////////////////////////////////////////////////
  bool moveBlock(MoveDirection direction, int steps) {
    bool isMoved = false;

    switch (direction) {
      case MoveDirection.left:
        isMoved = _ttboardManager.moveLeft();
        break;
      case MoveDirection.right:
        isMoved = _ttboardManager.moveRight();
        break;
      case MoveDirection.down:
        isMoved = _ttboardManager.moveDown();
        break;
    }
    if (isMoved) {
      // todo move Sound
      notifyListeners();
    } else if (direction == MoveDirection.down) {
      _layDownBlock();
    }
    return isMoved;
  }

  ////////////////////////////////////////////////////////
  // Hold block
  ////////////////////////////////////////////////////////
  void holdBlock() {
    if (_ttboardManager.holdBlock()) {
      _soundEffect?.holdSound();
      notifyListeners();
    }
  }

  ////////////////////////////////////////////////////////
  // Drop block
  ////////////////////////////////////////////////////////
  void dropBlock() {
    _ttboardManager.dropBlock();
    _soundEffect?.dropSound();
    _gamePlayEvents.sink.add(GamePlayEvents.blockDropped);
    _layDownBlock();
  }

  ////////////////////////////////////////////////////////
  // Pause game
  ////////////////////////////////////////////////////////
  void pauseGame({required bool eventForwarding}) {
    _blockTimer?.pause();
    _playTime.stop();
    _stopBgm();
    _playingStatus = PlayingStatus.paused;
    if (eventForwarding) {
      _gamePlayEvents.sink.add(GamePlayEvents.gamePaused);
    }
  }

  ////////////////////////////////////////////////////////
  // Resume game
  ////////////////////////////////////////////////////////
  void resumeGame() {
    _blockTimer?.start();
    _playTime.start();
    _startBgm();
    _playingStatus = PlayingStatus.playing;
    _gamePlayEvents.sink.add(GamePlayEvents.gameResumed);
  }

  ////////////////////////////////////////////////////////
  // Next stage
  ////////////////////////////////////////////////////////
  void nextStage() {
    _ttboardManager.reset();
    _stage++;
    _cleans = 0;
    _gamePlayEvents.sink.add(GamePlayEvents.gameStarted);
    _startBgm();
    _playTime.start();
    newBlock();
  }

  ////////////////////////////////////////////////////////
  // Game end
  ////////////////////////////////////////////////////////
  void gameEnd() {
    _blockTimer?.cancel();
    _stopBgm();
    _soundEffect?.gameEndSound();
    _gamePlayEvents.sink.add(GamePlayEvents.gameEnded);
  }

  ////////////////////////////////////////////////////////
  // 외부에서 이벤트 호출
  ////////////////////////////////////////////////////////
  void addEvent(GamePlayEvents event) {
    _gamePlayEvents.sink.add(event);
  }

  ////////////////////////////////////////////////////////
  // Internal private methods
  ////////////////////////////////////////////////////////
  void _startTimer() {
    Duration duration = _getSpeed();
    // 블록을 한칸씩 아래로 이동시킨다.
    _blockTimer = PausableTimer(duration, () {
      if (moveBlock(MoveDirection.down, 1)) {
        _blockTimer!.reset();
        _blockTimer!.start();
      }
    })
      ..start();
  }

  // Lay down block
  void _layDownBlock() async {
    _blockTimer?.cancel();

    _ttboardManager.fixBlock();

    // 완성 줄이 있는 경우
    if (_ttboardManager.hasCompleteRow()) {
      _soundEffect?.clearningSound();

      // 줄 삭제전 깜빡임 효과 보여주기
      for (int i = 0; i < 4; i++) {
        await Future.delayed(Duration(milliseconds: 100));
        _hideCompletedRow = !_hideCompletedRow;
        notifyListeners();
      }

      // 완성 줄 삭제
      int clearningRows = _ttboardManager.clearing();

      // 점수 계산: 한 줄당 100점. 2줄 이상이면 한줄당 보너스 10점 추가
      _score += clearningRows * 100;
      _score += (clearningRows - 1) * 20;

      // 스테이지 클리어 확인
      _cleans += clearningRows;
      if (_cleans >= kCleansForStage) {
        _stopBgm();
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 500));
        _gamePlayEvents.sink.add(GamePlayEvents.stageCleared);
        return;
      }
    }

    // 완성 줄이 없는 경우
    else {
      _soundEffect?.fixingSound();
      _score += 10;
    }

    notifyListeners();
    await Future.delayed(_getSpeed());
    newBlock();
  }

  String _getFormattedElapsed() {
    if (_blockTimer == null) {
      return '00:00';
    } else {
      return _playTime.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0') +
          ':' +
          _playTime.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    }
  }

  // Stage당 20%씩 속도를 올린다.
  Duration _getSpeed() =>
      Duration(milliseconds: (kInitalSpeed.inMilliseconds * math.pow((1 - kSpeedUpForLevel), _stage - 1)).toInt());

  void _startBgm() {
    if (AppSettings.backgroundMusic) {
      _bgmPlayer?.startBGM();
    }
  }

  void _stopBgm() {
    if (AppSettings.backgroundMusic) {
      _bgmPlayer?.stopBGM();
    }
  }
}
