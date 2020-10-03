import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'account_page.dart';

class TabPage extends StatefulWidget {
  final FirebaseUser user;

  TabPage(this.user);

  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  List _pages;

  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      Container(),
      AccountPage(),
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("account")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTapped,
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}