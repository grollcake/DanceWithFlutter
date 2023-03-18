import 'package:chatgpt_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'screen/home/home_screen.dart';

class DeviceTypeHandler extends StatelessWidget {
  const DeviceTypeHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        if (width < 370 || height < 660) {
            deviceType = DeviceType.tiny;
        } else if (width < 600) {
            deviceType = DeviceType.mobile;
        } else if (width < 1024) {
            deviceType = DeviceType.tablet;
        } else {
            deviceType = DeviceType.desktop;
        }

        return HomeScreen();
      },
    );
  }
}
