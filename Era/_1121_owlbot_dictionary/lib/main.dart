import 'package:flutter/material.dart';
import 'package:owlbot_dictionary/screens/homescreen/homescreen.dart';

void main() => runApp(DictionaryApp());

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owlbot dictionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Homescreen(),
    );
  }
}
