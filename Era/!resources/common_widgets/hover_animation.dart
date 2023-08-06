import 'package:flutter/material.dart';

class HoverAnimation extends StatefulWidget {
  final Duration duration;
  final Color inactiveColor;
  final Color activeColor;
  final Size? size;
  final Offset offset;
  final double borderRadiusValue;
  final Widget? child;

  const HoverAnimation({
    super.key,
    this.duration = const Duration(milliseconds: 300),
    this.inactiveColor = Colors.white,
    this.activeColor = Colors.blue,
    this.size,
    this.offset = const Offset(10, 10),
    this.borderRadiusValue = 20,
    this.child,
  });

  @override
  State<HoverAnimation> createState() => _HoverAnimationState();
}

class _HoverAnimationState extends State<HoverAnimation> with SingleTickerProviderStateMixin {
  bool _isHover = false;
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-widget.offset.dx, -widget.offset.dy))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onHover: (hover) {
        setState(() {
          _isHover = !_isHover;
          if (_isHover) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        });
      },
      mouseCursor: MouseCursor.defer,
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: _animation.value,
              child: AnimatedContainer(
                duration: widget.duration,
                width: widget.size?.width,
                height: widget.size?.height,
                decoration: BoxDecoration(
                  color: _isHover ? widget.activeColor : widget.inactiveColor,
                  borderRadius: BorderRadius.circular(widget.borderRadiusValue),
                  boxShadow: [
                    BoxShadow(
                      color: _isHover ? Colors.black : Colors.transparent,
                      offset: _isHover ? widget.offset : Offset.zero,
                    ),
                  ],
                ),
                child: widget.child,
              ),
            );
          }),
    );
  }
}
