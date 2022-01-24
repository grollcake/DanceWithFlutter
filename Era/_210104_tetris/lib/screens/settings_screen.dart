import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text('Settings',
                        style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold)),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 200,
                  color: Colors.yellow,
                ),
                Expanded(
                  child: Container(
                    // width: double.infinity,
                    height: 200,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
