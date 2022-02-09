import 'dart:async';

import 'package:flutter/material.dart';

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
  final double _yAxisThreadhold = 30.0;
  final double _dropTriggerSpeed = 0.15; // 마지막 아래방향으로 이동속도가 이 이상이면 Drop으로 판정
  final int _onTapCheckMilliseconds = 300;
  final int _dropCheckMillisecond = 50;
  final double _dropTriggerDistance = 20;
  int delayedSwipeDownStep = 0;
  Timer? _timer;

  double verticalSwipeDistance = 0.0;
  double horizontalSwipeDistance = 0.0;
  bool isSwipeDone = false;

  int startTimestamp = 0;
  List<Map<String, dynamic>> _moveHistory = [];

  // 이동 정보 처리
  void handleMoveEvent(Offset delta) {
    // 1. 이동 거리 정보 기록
    int currentElapsedMs = DateTime.now().millisecondsSinceEpoch - startTimestamp;
    _moveHistory.add({'elapsedMillisecond': currentElapsedMs, 'deltaX': delta.dx, 'deltaY': delta.dy});

    // 2. 이동 거리 누적값 계산
    horizontalSwipeDistance += delta.dx;
    verticalSwipeDistance += delta.dy;

    // 3. 임계치 초과 시 사용자 함수 호출
    if (horizontalSwipeDistance ~/ _xAxisThreadhold != 0) {
      int steps = horizontalSwipeDistance ~/ _xAxisThreadhold;
      horizontalSwipeDistance = horizontalSwipeDistance - _xAxisThreadhold * steps;
      if (steps > 0) {
        widget.onSwipeRight(steps);
      } else {
        widget.onSwipeLeft(-steps);
      }
    }
    if (verticalSwipeDistance ~/ _yAxisThreadhold != 0) {
      int steps = verticalSwipeDistance ~/ _yAxisThreadhold;
      verticalSwipeDistance = verticalSwipeDistance - _yAxisThreadhold * steps;
      if (steps > 0) {
        // 미처리된 SwipeDown이 있다면 그것부터 처리한다.
        if ((_timer?.isActive ?? false) && delayedSwipeDownStep > 0) {
          widget.onSwipeDown(delayedSwipeDownStep);
          _timer!.cancel();
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
        verticalSwipeDistance = 0;
        horizontalSwipeDistance = 0;
        startTimestamp = DateTime.now().millisecondsSinceEpoch;
        _moveHistory = [];
      },
      onPointerUp: (PointerUpEvent event) {
        // 짧은 시간안에 PointerUp 했다면 tap으로 처리
        if (DateTime.now().millisecondsSinceEpoch - startTimestamp < _onTapCheckMilliseconds &&
            verticalSwipeDistance.abs() < 2 &&
            horizontalSwipeDistance.abs() < 2) {
          widget.onTap();
          return;
        }

        handleMoveEvent(event.delta);

        // Drop 이벤트 발생여부 확인: 마지막 50ms 동안 아래로 움직인 속도 확인
        int currentElapsedMilliseconds = DateTime.now().millisecondsSinceEpoch - startTimestamp;
        double dropDistance = 0;
        int dropElapsedMilliseconds = 0;
        for (int i = _moveHistory.length - 1; i >= 0; i--) {
          // 50ms 이내 기록 또는 최소 이동거리 20 이상의 데이터만 취합해서 속도 계산
          if (currentElapsedMilliseconds - _moveHistory[i]['elapsedMillisecond'] <= _dropCheckMillisecond ||
              dropDistance < _dropTriggerDistance) {
            dropDistance += _moveHistory[i]['deltaY'];
          } else {
            dropElapsedMilliseconds = currentElapsedMilliseconds - _moveHistory[i]['elapsedMillisecond'] as int;
            break;
          }
        }
        // 이동 기록 중에 50ms 이상 경과된 건이 없다면 현재 경과시간으로 계산한다.
        if (dropElapsedMilliseconds == 0) {
          dropElapsedMilliseconds = currentElapsedMilliseconds;
        }
        // 속도 계산
        if (dropDistance >= 10) {
          double dropVelocity = dropDistance / dropElapsedMilliseconds;
          double totalVelocity = verticalSwipeDistance / currentElapsedMilliseconds;
          // print(
          //     'Drop( ${dropDistance.toStringAsFixed(2)} / ${dropElapsedMilliseconds}ms => ${dropVelocity.toStringAsFixed(2)})  '
          //     'Total( ${verticalSwipeDistance.toStringAsFixed(2)} / ${currentElapsedMilliseconds}ms => ${totalVelocity.toStringAsFixed(2)})');
          if (dropVelocity >= _dropTriggerSpeed) {
            // Drop 직전의 SwipeDown은 취소해버린다.
            if (_timer?.isActive ?? false) {
              _timer!.cancel();
              delayedSwipeDownStep = 0;
            }
            widget.onSwipeDrop();
          }
        }

        // 이동 거리와 속도 출력
      },
      onPointerMove: (PointerMoveEvent event) {
        handleMoveEvent(event.delta);
      },
    );
  }
}
