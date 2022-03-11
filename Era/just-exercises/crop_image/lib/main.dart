import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        body: CropImage(),
      ),
    ));

class CropImage extends StatelessWidget {
  const CropImage({Key? key}) : super(key: key);

  final _sliceCount = 4;

  @override
  Widget build(BuildContext context) {
    List<Widget> slicedWidgets = getSlicedWidget(
      horizontalCount: _sliceCount,
      verticalCount: _sliceCount,
      horizontalSpacing: 5,
      verticalSpacing: 5,
      fullSize: Size(200, 200),
      child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: GridView.builder(
                  itemCount: _sliceCount * _sliceCount,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _sliceCount,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (_, index) {
                    return slicedWidgets[index];
                  },
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(_sliceCount, (index) {
            //     final sliceFactor = 1 / _sliceCount;
            //     final pointFactor = 1 / (_sliceCount - 1);
            //     final xFactor = pointFactor * (index % _sliceCount);
            //     return CropWidget(
            //       xFactor: xFactor,
            //       yFactor: 0,
            //       widthFactor: sliceFactor,
            //       heightFactor: sliceFactor,
            //       child: SizedBox(
            //         width: 200,
            //         height: 200,
            //         child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
            //       ),
            //     );
            //   }),
            // ),
            Center(
              child: SizedBox(
                width: 200,
                child: GridView.builder(
                  itemCount: _sliceCount * _sliceCount,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _sliceCount),
                  itemBuilder: (_, index) {
                    return SlicingWidget(
                      horizontalCount: _sliceCount,
                      verticalCount: _sliceCount,
                      horizontalSpacing: 0,
                      verticalSpacing: 0,
                      size: Size(200, 200),
                      sliceNo: index,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: GridView.builder(
                  itemCount: _sliceCount * _sliceCount,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _sliceCount,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (_, index) {
                    return Container(
                      color: Colors.purple.shade200,
                      child: SlicingWidget(
                        horizontalCount: _sliceCount,
                        verticalCount: _sliceCount,
                        horizontalSpacing: 10,
                        verticalSpacing: 10,
                        size: Size(200, 200),
                        sliceNo: index,
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            ClipRect(
              child: Align(
                alignment: Alignment(0, -1),
                heightFactor: 1 / 4,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                double xOffset = -1 + (2 / (4 - 1)) * index;
                return ClipRect(
                  child: Align(
                    alignment: Alignment(xOffset, -1),
                    widthFactor: 1 / 4,
                    heightFactor: 1 / 4,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/images/sample.jpg', fit: BoxFit.cover),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> getSlicedWidget(
    {required int horizontalCount,
    required int verticalCount,
    required double horizontalSpacing,
    required double verticalSpacing,
    required Widget child,
    required Size fullSize}) {
  List<Widget> slicedWidgets = [];

  final sliceWidth = (fullSize.width - horizontalSpacing * (horizontalCount - 1)) / horizontalCount;
  final sliceHeight = (fullSize.height - verticalSpacing * (verticalCount - 1)) / verticalCount;

  final widthFactor = sliceWidth / fullSize.width;
  final heightFactor = sliceHeight / fullSize.height;

  for (int sliceNo = 0; sliceNo < horizontalCount * verticalCount; sliceNo++) {
    final xOffset = (sliceWidth + horizontalSpacing) * (sliceNo % horizontalCount);
    final xFactor = xOffset / (fullSize.width - sliceWidth);

    final yOffset = (sliceHeight + verticalSpacing) * (sliceNo ~/ horizontalCount);
    final yFactor = yOffset / (fullSize.height - sliceHeight);

    Widget sliced = FittedBox(
      child: ClipRect(
        child: Align(
          alignment: FractionalOffset(xFactor, yFactor),
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: SizedBox(
            width: fullSize.width,
            height: fullSize.height,
            child: child,
          ),
        ),
      ),
    );
    slicedWidgets.add(sliced);
  }
  return slicedWidgets;
}

class SlicingWidget extends StatelessWidget {
  const SlicingWidget(
      {Key? key,
      required this.horizontalCount,
      required this.verticalCount,
      required this.horizontalSpacing,
      required this.verticalSpacing,
      required this.sliceNo,
      required this.child,
      required this.size})
      : super(key: key);
  final Size size;
  final int horizontalCount;
  final int verticalCount;
  final double horizontalSpacing;
  final double verticalSpacing;
  final int sliceNo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sliceWidth = (size.width - horizontalSpacing * (horizontalCount - 1)) / horizontalCount;
    final sliceHeight = (size.height - verticalSpacing * (verticalCount - 1)) / verticalCount;

    final widthFactor = sliceWidth / size.width;
    final heightFactor = sliceHeight / size.height;

    final xOffset = (sliceWidth + horizontalSpacing) * (sliceNo % horizontalCount);
    final xFactor = xOffset / (size.width - sliceWidth);

    final yOffset = (sliceHeight + verticalSpacing) * (sliceNo ~/ horizontalCount);
    final yFactor = yOffset / (size.height - sliceHeight);

    return FittedBox(
      child: ClipRect(
        child: Align(
          alignment: FractionalOffset(xFactor, yFactor),
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: child,
        ),
      ),
    );
  }
}

class CropWidget extends StatelessWidget {
  const CropWidget(
      {Key? key,
      required this.xFactor,
      required this.yFactor,
      required this.widthFactor,
      required this.heightFactor,
      required this.child})
      : super(key: key);

  final double xFactor; // 잘라내기 시작할 x 위치값 (0~1)
  final double yFactor; // 잘라내기 시작할 y 위치값 (0~1)
  final double widthFactor; // 잘라낼 넓이 (0~1)
  final double heightFactor; // 잘라낼 높이 (0~1)
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ClipRect(
        child: Align(
          alignment: FractionalOffset(xFactor, yFactor),
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: child,
        ),
      ),
    );
  }
}
