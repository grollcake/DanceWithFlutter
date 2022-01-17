import 'package:flutter/material.dart';
import 'package:shaker_widget/modules/shaker_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaker widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            ShakeExample(),
          ],
        ),
      ),
    );
  }
}

class ShakeExample extends StatefulWidget {
  const ShakeExample({Key? key}) : super(key: key);

  @override
  State<ShakeExample> createState() => _ShakeExampleState();
}

class _ShakeExampleState extends State<ShakeExample> {
  final GlobalKey<ShakeWidgetState> shakeKey = GlobalKey();

  String _aniStat = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: ShakeWidget(
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
            ),
            key: shakeKey,
            shakeAxis: Axis.vertical,
            shakeOffset: 100.0,
            duration: const Duration(seconds: 2),
            listener: (status, value, duration) {
              setState(() {
                String durationStr = (duration.inMilliseconds / 1000).toStringAsFixed(2);
                _aniStat = '$status\nValue: ${value.toStringAsFixed(2)}\nElapsed: $durationStr';
              });
              // print(_aniStat);
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            shakeKey.currentState?.shake();
          },
          child: const Text('SHAKE'),
        ),
        Text(_aniStat, style: const TextStyle(fontSize: 16))
      ],
    );
  }
}
