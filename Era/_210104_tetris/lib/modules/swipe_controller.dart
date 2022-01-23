import 'package:flutter/material.dart';

class SwipeController extends StatefulWidget {
  const SwipeController(
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

  static const double xAxisThreadhold = 40.0;
  static const double yAxisThreadhold = 30.0;
  static const double dropSpeedThreadhold = 1.0;

  @override
  State<SwipeController> createState() => _SwipeControllerState();
}

class _SwipeControllerState extends State<SwipeController> {
  int verticalMilliseconds = 0;
  int verticalMovedSteps = 0;
  double verticalSwipeDistance = 0.0;
  int horizontalMovedSteps = 0;
  double horizontalSwipeDistance = 0.0;
  bool isSwipeDone = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTap: widget.onTap,
      onHorizontalDragStart: (DragStartDetails details) {
        isSwipeDone = false;
        horizontalMovedSteps = 0;
        horizontalSwipeDistance = 0;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        if (isSwipeDone) return;
        horizontalSwipeDistance += details.delta.dx;
        int steps = horizontalSwipeDistance.abs() ~/ SwipeController.xAxisThreadhold;
        if (horizontalMovedSteps == 0 || steps > horizontalMovedSteps) {
          if (steps == 0) {
            steps = 1;
          }
          if (horizontalSwipeDistance > 0) {
            widget.onSwipeRight(steps - horizontalMovedSteps);
          } else {
            widget.onSwipeLeft(steps - horizontalMovedSteps);
          }
          horizontalMovedSteps = steps;
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {},
      onVerticalDragStart: (DragStartDetails details) {
        isSwipeDone = false;
        verticalMovedSteps = 0;
        verticalSwipeDistance = 0.0;
        verticalMilliseconds = DateTime.now().millisecondsSinceEpoch;
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (isSwipeDone) return;
        verticalSwipeDistance += details.delta.dy;
        int steps = verticalSwipeDistance.abs() ~/ SwipeController.yAxisThreadhold;

        // 아래 방향으로 일정 속도 이상이면 Drop 처리
        double speed = verticalSwipeDistance / (DateTime.now().millisecondsSinceEpoch - verticalMilliseconds);
        if (verticalSwipeDistance > 0 && speed > SwipeController.dropSpeedThreadhold) {
          // print('Distance $verticalSwipeDistance / ${elapsed}ms  =>  Speed ${speed.toStringAsFixed(5)}');
          isSwipeDone = true;
          widget.onSwipeDrop();
        }
        // 아래로 움직인 거리와, 위로 움직였을 경우 처리
        else {
          if (verticalMovedSteps == 0 || steps > verticalMovedSteps) {
            // print('Distance $verticalSwipeDistance / ${elapsed}ms  =>  Speed ${speed.toStringAsFixed(5)}');

            if (verticalMovedSteps == 0) {
              steps = 1;
            }
            if (verticalSwipeDistance > 0) {
              widget.onSwipeDown(steps - verticalMovedSteps);
            } else {
              isSwipeDone = true;
              widget.onSwipeUp();
            }
            verticalMovedSteps = steps;
          }
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {},
    );
  }
}
