import 'package:flutter/material.dart';

enum EraScreenTransitionType { none, rightToLeft, leftToRight, bottomToTop, topToBottom }

class EraScreenTransition extends PageTransitionsBuilder {
  final EraScreenTransitionType type;

  EraScreenTransition({this.type = EraScreenTransitionType.none});

  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (type) {
      case EraScreenTransitionType.none:
        return child;
        break;
      case EraScreenTransitionType.rightToLeft:
        return child;
        break;
      case EraScreenTransitionType.leftToRight:
        return child;
        break;
      case EraScreenTransitionType.bottomToTop:
        return child;
        break;
      case EraScreenTransitionType.topToBottom:
        return child;
        break;
    }
  }
}
