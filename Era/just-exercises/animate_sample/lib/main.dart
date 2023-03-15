import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AnimateTesting',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double size = 200;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          // onLongPressDown: (details) => _userAction('Down'),
          onLongPressStart: (details) => _userAction('Down'),
          onLongPressUp: () => _userAction('Up'),
          // onPointerDown: (details) => _userAction('Down'),
          // onPointerUp: (details) => _userAction('Up'),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: size,
            height: size,
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
              child: Text('${size.toInt()} x ${size.toInt()}', textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }

  _userAction(String action) {
    if (action == 'Down') {
      size = 180;
      tapped = true;
    } else {
      tapped = false;
      size = 200;
    }
    setState(() {});
  }
}
