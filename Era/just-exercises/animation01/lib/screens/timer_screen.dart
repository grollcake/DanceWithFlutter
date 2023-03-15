import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:pausable_timer/pausable_timer.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Duration _duration = Duration.zero;
  late PausableTimer _timer;

  @override
  void initState() {
    super.initState();
    _timer = PausableTimer(Duration(seconds: 1), () {
      setState(() => _duration += Duration(seconds: 1));
      _timer.reset();
      _timer.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(_duration.toString().split('.').first,
                    style: TextStyle(fontSize: 40, color: Colors.black87, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_timer.isActive) {
                          _timer.pause();
                        } else {
                          _timer.start();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.zero,
                      elevation: 2.0,
                    ),
                    child: Icon(_timer.isActive ? Icons.pause : Icons.play_arrow_rounded),
                  ),
                ),
              ),
            ),
            Expanded(child: _timer.isActive ? Center(child: ArcAnimation(mainTimer: _timer)) : SizedBox())
          ],
        ),
      ),
    );
  }
}

class ArcAnimation extends StatefulWidget {
  final PausableTimer mainTimer;
  const ArcAnimation({Key? key, required this.mainTimer}) : super(key: key);

  @override
  State<ArcAnimation> createState() => _ArcAnimationState();
}

class _ArcAnimationState extends State<ArcAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.repeat();
    controller.addListener(() {});
    print(widget.mainTimer);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            // angle: (widget.currentTick.inMilliseconds * 360 / 1000 + controller.value * 360) * math.pi / 180,
            angle: (widget.mainTimer.elapsed.inMilliseconds * 360 / 1000) * math.pi / 180,
            child: CircularProgressIndicator(value: .08),
          );
        });
  }
}
