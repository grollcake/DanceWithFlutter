import 'package:counter_provider/controllers/count_controller.dart';
import 'package:counter_provider/views/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter provider',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<CountController>(
        create: (BuildContext context) {
          return CountController();
        },
        child: CounterPage(),
      ),
    );
  }
}
