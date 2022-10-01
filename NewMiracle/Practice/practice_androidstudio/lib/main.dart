import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title : 'AppBarTest',
      theme: ThemeData(
        //primarySwatch: Colors.amber[50],
      ),
      home : AppBarTestScaffold()
    );
  }
}

class AppBarTestScaffold extends StatelessWidget {
  const AppBarTestScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text('Appbar icon menu'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon : Icon(Icons.shopping_cart),
            onPressed: () {
              print('menu is shopping_cart');
            },
          ),
          IconButton(
            icon : Icon(Icons.search),
            onPressed: () {
              print('menu is search');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child : ListView(),
      ),
    );

  }
}

