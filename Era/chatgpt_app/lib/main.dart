import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screen/home/home_screen.dart';

void main() => runApp(ProviderScope(child: ChatGPTApp()));

class ChatGPTApp extends StatelessWidget {
  const ChatGPTApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPTApp',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}