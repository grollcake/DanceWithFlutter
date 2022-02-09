import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/managers/app_settings.dart';

enum SwipeDirection { left, right, up, down }

class SwipeDetector extends StatefulWidget {
  const SwipeDetector(
      {Key? key,
      required this.child,
      required this.onTap,
      required this.onSwipeUp,
      required this.onSwipeDown,
      required this.onSwipeLeft,
      required this.onSwipeRight,
      required this.onSwipeDrop})
      : super(key: key);
  final Widget child;
  final Function() onTap;
  final Function() onSwipeUp;
  final Function(int) onSwipeDown;
  final Function(int) onSwipeLeft;
  final Function(int) onSwipeRight;
  final Function() onSwipeDrop;

  @override
  State<SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  final double _xAxisThreadhold = 30.0;
  final double _yAxisThreadhold = 20.0;
  final double _dropTriggerSpeed = 0.15; // 마지막 아래방향으로 이동속도가 이 이상이면 Drop으로 판정
  final int _dropCheckMillisecond = 50;
  final double _dropTriggerDistance = 20;

  Timer? _timer;
  int startTimestamp = 0;
  List<Map<String, dynamic>> _moveHistory = [];
  double totalSwipeDistance = 0.0;
  double verticalSwipeDistance = 0.0;
  double horizontalSwipeDistance = 0.0;
  int delayedSwipeDownStep = 0;
  bool isSwipeDone = false;
  int callBackCount = 0;

  // 이동 정보 처리
  void handleMoveEvent(Offset delta) {
    // 0. 기준 임계치 계산
    double xAxisThreadhold = _xAxisThreadhold;
    if (AppSettings.swipeSensitivity == 1) {
      xAxisThreadhold *= 1.5;
    } else if (AppSettings.swipeSensitivity == 2) {
      xAxisThreadhold *= 0.6;
    }

    double yAxisThreadhold = _yAxisThreadhold;
    if (AppSettings.swipeSensitivity == 1) {
      yAxisThreadhold *= 1.5;
    } else if (AppSettings.swipeSensitivity == 2) {
      yAxisThreadhold *= 0.6;
    }

    // 1. 이동 거리 정보 기록
    int currentElapsedMs = DateTime.now().millisecondsSinceEpoch - startTimestamp;
    _moveHistory.add({'elapsedMillisecond': currentElapsedMs, 'deltaX': delta.dx, 'deltaY': delta.dy});

    // 2. 이동 거리 누적값 계산
    totalSwipeDistance += delta.dx.abs() + delta.dy.abs();
    horizontalSwipeDistance += delta.dx;
    verticalSwipeDistance += delta.dy;

    // 3. 임계치 초과 시 사용자 함수 호출
    if (horizontalSwipeDistance ~/ xAxisThreadhold != 0) {
      int steps = horizontalSwipeDistance ~/ xAxisThreadhold;
      horizontalSwipeDistance = horizontalSwipeDistance - xAxisThreadhold * steps;
      verticalSwipeDistance = 0;
      callBackCount += steps.abs();
      if (steps > 0) {
        widget.onSwipeRight(steps);
      } else {
        widget.onSwipeLeft(-steps);
      }
    }
    if (verticalSwipeDistance ~/ yAxisThreadhold != 0) {
      int steps = verticalSwipeDistance ~/ yAxisThreadhold;
      verticalSwipeDistance = verticalSwipeDistance - yAxisThreadhold * steps;
      horizontalSwipeDistance = 0;
      callBackCount += steps.abs();
      if (steps > 0) {
        // 미처리된 SwipeDown이 있다면 그것부터 처리한다.
        if (_timer?.isActive ?? false) {
          _timer!.cancel();
          widget.onSwipeDown(delayedSwipeDownStep);
        }
        // SwipeDown인 경우 Drop 일수도 있기 때문에 약간 지연 처리한다.
        delayedSwipeDownStep = steps;
        _timer = Timer(const Duration(milliseconds: 200), () {
          widget.onSwipeDown(steps);
          delayedSwipeDownStep = 0;
          _timer = null;
        });
      } else {
        widget.onSwipeUp();
        isSwipeDone = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      child: widget.child,
      onPointerDown: (PointerDownEvent event) {
        isSwipeDone = false;
        callBackCount = 0;
        totalSwipeDistance = 0.0;
        verticalSwipeDistance = 0;
        horizontalSwipeDistance = 0;
        delayedSwipeDownStep = 0;
        startTimestamp = DateTime.now().millisecondsSinceEpoch;
        _moveHistory = [];
      },
      onPointerUp: (PointerUpEvent event) {
        handleMoveEvent(event.delta);

        // Drop이 발생했는지 확인: 마지막 50ms 동안 아래로 움직인 속도 확인
        if (_isDropOccurred()) {
          // Drop 직전의 SwipeDown은 취소해버린다.
          if (_timer?.isActive ?? false) {
            _timer!.cancel();
            delayedSwipeDownStep = 0;
          }
          widget.onSwipeDrop();
          callBackCount += 1;
        } else if (callBackCount == 0) {
          widget.onTap();
        }
      },
      onPointerMove: (PointerMoveEvent event) {
        if (isSwipeDone) return;
        handleMoveEvent(event.delta);
      },
    );
  }

  bool _isDropOccurred() {
    int currentElapsedMilliseconds = DateTime.now().millisecondsSinceEpoch - startTimestamp;
    double dropDistance = 0;
    double horizontalDistance = 0;
    int dropElapsedMilliseconds = 0;

    for (int i = _moveHistory.length - 1; i >= 0; i--) {
      // 50ms 이내 기록 또는 최소 이동거리 20 이상의 데이터만 취합해서 속도 계산
      if (currentElapsedMilliseconds - _moveHistory[i]['elapsedMillisecond'] <= _dropCheckMillisecond ||
          dropDistance < _dropTriggerDistance) {
        dropDistance += _moveHistory[i]['deltaY'];
        horizontalDistance += _moveHistory[i]['deltaX'];
      } else {
        dropElapsedMilliseconds = currentElapsedMilliseconds - _moveHistory[i]['elapsedMillisecond'] as int;
        break;
      }
    }
    // 이동 기록 중에 50ms 이상 경과된 건이 없다면 현재 경과시간으로 계산한다.
    if (dropElapsedMilliseconds == 0) {
      dropElapsedMilliseconds = currentElapsedMilliseconds;
    }

    // Drop 속도 계산
    if (dropDistance > horizontalDistance.abs() && dropDistance >= 20) {
      double dropVelocity = dropDistance / dropElapsedMilliseconds;
      double totalVelocity = verticalSwipeDistance / currentElapsedMilliseconds;
      // print(
      //     'Drop( ${dropDistance.toStringAsFixed(2)} / ${dropElapsedMilliseconds}ms => ${dropVelocity.toStringAsFixed(2)})  '
      //     'Total( ${verticalSwipeDistance.toStringAsFixed(2)} / ${currentElapsedMilliseconds}ms => ${totalVelocity.toStringAsFixed(2)})');

      // 임계치를 넘어섰다면 SwipeDown 콜백
      if (dropVelocity >= _dropTriggerSpeed) {
        return true;
      }
    }
    return false;
  }
}
