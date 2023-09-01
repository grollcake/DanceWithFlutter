import 'package:flutter/material.dart';

class PositionedGridView extends StatefulWidget {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final int itemCount;
  final List<Widget> children;
  final List<int>? positions;
  final Duration duration;
  final Curve curve;

  const PositionedGridView({
    Key? key,
    required this.crossAxisCount,
    required this.itemCount,
    required this.children,
    this.positions,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  State<PositionedGridView> createState() => _PositionedGridViewState();
}

class _PositionedGridViewState extends State<PositionedGridView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final itemWidth =
          (constraints.maxWidth - widget.mainAxisSpacing * (widget.crossAxisCount - 1)) / widget.crossAxisCount;
      final itemHeight = itemWidth * widget.childAspectRatio;

      return SizedBox(
        height: itemHeight * (((widget.children.length - 1) ~/ widget.crossAxisCount) + 1) +
            widget.mainAxisSpacing * ((widget.children.length - 1) ~/ widget.crossAxisCount),
        child: Stack(
          children: List.generate(
            widget.itemCount,
            (index) {
              int rowNum = (widget.positions?[index] ?? index) ~/ widget.crossAxisCount;
              int colNum = (widget.positions?[index] ?? index) - rowNum * widget.crossAxisCount;

              double x = itemWidth * colNum + (widget.crossAxisSpacing * colNum);
              double y = itemHeight * rowNum + (widget.mainAxisSpacing * rowNum);

              return AnimatedPositioned(
                duration: widget.duration,
                curve: widget.curve,
                left: x,
                top: y,
                child: SizedBox(
                  width: itemWidth,
                  height: itemHeight,
                  child: widget.children[index],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
