import 'package:flutter/material.dart';

class UserActions extends StatelessWidget {
  UserActions(
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

  int verticalMilliseconds = 0;
  double verticalDistance = 0.0;
  double horizontalDistance = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        print('OnTap');
        onTap();
      },
      onHorizontalDragStart: (DragStartDetails details) {
        horizontalDistance = 0.0;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        horizontalDistance += details.delta.dx;
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        int steps = (horizontalDistance.toInt() ~/ 70).abs() + 1;

        if (horizontalDistance < 0) {
          print('onSwipeLeft($steps) -- $horizontalDistance');
          onSwipeLeft(steps);
        } else {
          print('onSwipeRight($steps) -- $horizontalDistance');
          onSwipeRight(steps);
        }
      },
      onVerticalDragStart: (DragStartDetails details) {
        verticalMilliseconds = DateTime.now().millisecondsSinceEpoch;
        verticalDistance = 0.0;
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        verticalDistance += details.delta.dy;
      },
      onVerticalDragEnd: (DragEndDetails details) {
        double speed = verticalDistance / (DateTime.now().millisecondsSinceEpoch - verticalMilliseconds);

        int steps = (verticalDistance.toInt() ~/ 50).abs() + 1;

        if (verticalDistance < 0) {
          print('onSwipeUp() => $verticalDistance');
          onSwipeUp();
        } else if (speed > 0.8) {
          print('onSwipeDrop($steps) => $verticalDistance');
          onSwipeDrop();
        } else {
          print('onSwipeDown($steps) => $verticalDistance');
          onSwipeDown(steps);
        }
      },
    );
  }
}
