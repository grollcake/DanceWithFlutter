import 'package:flutter/material.dart';

class NotYetScreen extends StatelessWidget {
  final String screenName;
  const NotYetScreen({Key? key, required this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$screenName 기능은 준비되지 않았습니다.'),
    );
  }
}
