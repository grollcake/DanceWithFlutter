import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Dialog',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = 'Not set yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog with TextField'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your name:',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
                Text(username,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String? userName = await getUserName(context);
                  print(userName);
                  setState(() {
                    username = userName ?? username;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12),
                ),
                child: Text('Set my name', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> getUserName(context) {
    TextEditingController _controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Your name?'),
          content: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: (userInput) => Navigator.of(context).pop(_controller.text),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text);
                },
                child: Text('Submit')),
          ],
        );
      },
    );
  }
}
