import 'package:flutter/material.dart';

/*
그리드 뷰(grid view) 스타일로 자식 위젯들을 배치하며,
각 자식 위젯의 위치는 positions가 바뀔때마다 애니메이션 효과와 함께 동적으로 변경됩니다.

속성(Properties):
  * crossAxisCount: 그리드의 가로 축에 배치될 아이템의 수입니다.
  * crossAxisSpacing & mainAxisSpacing: 각각 가로 축과 세로 축에서 아이템들 사이의 간격을 지정합니다.
  * childAspectRatio: 아이템의 가로 세로 비율을 지정합니다.
  * children: 그리드에 배치될 위젯들의 목록입니다.
  * positions: 각 아이템의 그리드 내 위치를 지정하는 옵션입니다. 명시되지 않으면 기본적으로 순서대로 위치합니다.
  * duration & curve: 아이템의 위치가 변경될 때 사용되는 애니메이션의 지속 시간과 커브를 지정합니다.

구현 방식:
  * LayoutBuilder를 사용하여 PositionedGridView의 크기에 따라 아이템들의 크기와 위치를 동적으로 계산합니다.
  * Stack 위젯을 사용하여 각 아이템을 지정된 위치에 배치합니다.
  * AnimatedPositioned를 사용하여 아이템의 위치가 변경될 때 애니메이션 효과를 제공합니다.
  * 주어진 positions 목록을 기반으로 각 아이템의 행과 열 위치를 계산합니다.
 */

class PositionedGridView extends StatefulWidget {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final List<Widget> children;
  final List<int>? positions;
  final Duration duration;
  final Curve curve;

  const PositionedGridView({
    Key? key,
    required this.crossAxisCount,
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
            widget.children.length,
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
