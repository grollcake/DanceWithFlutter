import 'dart:async';

import 'package:sprintf/sprintf.dart';

class CounterStream {
  bool _status = false;
  int _counter = 0;
  Stopwatch _stopwatch;
  StreamController _stream;

  CounterStream() {
    _stream = StreamController<String>();
    _stopwatch = Stopwatch();
  }

  Stream<String> get stream => _stream.stream;

  bool get status => _status;

  void startCounter() {
    if (_status) {
      print('이미 시작했습니다');
    }
    else {
      _status = true;
      _stopwatch.start();
      _increaseCounter();
      print('Counter를 시작했습니다.');
    }
  }

  void stopCounter() {
    if (! _status) {
      print('이미 중지했습니다.');
    }
    else {
      _status = false;
      _stopwatch.stop();
      print('Counter를 중지합니다.');
    }
  }

  void resetCounter() {
    _status = false;
    _stopwatch.reset();
    _stream.add('0.0');
    print('Counter를 초기화합니다.');
  }

  void _increaseCounter() {
//    if (status) _stream.add('0.0');

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (!_status) {
        timer.cancel();
      } else {
        double elapsed = _stopwatch.elapsedMilliseconds / 1000;
        String fmt = sprintf('%2.2f', [elapsed]);
        print(fmt);
        _stream.add(fmt);
      }
    });
  }
}