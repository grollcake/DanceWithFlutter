import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<Widget> _widgets = [
    Text(
      '첫 번째 메뉴를 선택함',
      style: TextStyle(fontSize: 20.0, color: Colors.amber),
    ),
    Text(
      '두번째 메뉴를 선택함',
      style: TextStyle(fontSize: 20.0, color: Colors.indigo),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chanbyul',
        home: Scaffold(
          appBar: AppBar(title: Text('Bottom Menu')),
          body: Container(
            child: Center(
              child: _widgets[_selectedIndex],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.accessible_forward), title: Text('AA')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.accessible_forward), title: Text('BB')),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ));
  }
}
