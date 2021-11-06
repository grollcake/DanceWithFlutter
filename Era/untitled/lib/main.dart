import 'package:flutter/material.dart';

void main() => runApp(AppRoot());

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Untitled',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button with image'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Material(
              elevation: 10,
              shape: CircleBorder(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.blue, width: 3),
                  shape: BoxShape.circle,
                ),

                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.blue.withOpacity(0.2),
                  child: Ink.image(
                    image: NetworkImage(
                      'https://avatars.githubusercontent.com/u/984975?s=400&u=b34e85d725a7e12e0028c4c3cf5895b498845d33&v=4',
                    ),
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ClipOval(
              child: Image.network(
                'https://avatars.githubusercontent.com/u/984975?s=400&u=b34e85d725a7e12e0028c4c3cf5895b498845d33&v=4',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
