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
        primarySwatch: Colors.red,
      ),
      home : AppBarTestScaffold(),
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
        child : ListView(
          padding : EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images.jpg'),
                  backgroundColor: Colors.white,
                ),
                otherAccountsPictures: [
                   CircleAvatar(
                     backgroundImage: AssetImage('assets/K982734448_t6.jpg'),
                     backgroundColor: Colors.white,
                   ),
                  // CircleAvatar(
                  //   backgroundImage: AssetImage('assets/K982734448_t6.jpg'),
                  //   backgroundColor: Colors.white,
                  // )
                ],
                accountName: Text('BBANKTO'),
                accountEmail: Text('bbanto@bbanto.com'),
                onDetailsPressed: (){
                  print('arrow is clicked');
                },
                decoration: BoxDecoration(
                  color : Colors.red[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                            color : Colors.grey[850]),
              title: Text('home'),
              onTap: (){
                print('Home is Clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color : Colors.grey[850]),
              title: Text('Setting'),
              onTap: (){
                print('Settings is Clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.question_answer,
                  color : Colors.grey[850]),
              title: Text('Q&A'),
              onTap: (){
                print('Q&A is Clicked');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );

  }
}

