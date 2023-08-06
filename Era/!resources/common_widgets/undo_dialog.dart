import 'package:flutter/material.dart';

class UndoDialog extends StatefulWidget {
  final Duration duration;
  final ValueChanged<SnackBarClosedReason> callback;

  const UndoDialog({
    super.key,
    this.duration = const Duration(seconds: 3),
    required this.callback,
  });

  @override
  State<UndoDialog> createState() => _UndoDialogState();
}

class _UndoDialogState extends State<UndoDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.callback(SnackBarClosedReason.timeout);
          ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  int remainSeconds = (widget.duration.inSeconds * (1 - _animationController.value)).toInt() + 1;
                  return Stack(
                    children: [
                      CircularProgressIndicator(
                        value: 1 - _animationController.value,
                        color: Colors.yellow,
                      ),
                      Center(
                        child: Text('$remainSeconds'),
                      ),
                    ],
                  );
                }),
          ),
          SizedBox(width: 20),
          Text('삭제했습니다'),
          Spacer(),
          TextButton(
            onPressed: () {
              widget.callback(SnackBarClosedReason.action);
              ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.action);
            },
            child: Text('취소하기', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
