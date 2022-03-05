import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_puzzle/controllers/game_controller.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'SLIDING PUZZLE',
            style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
            stream: context.select((GameController controller) => controller.elapsedTimeStream),
            initialData: '00:00',
            builder: (BuildContext context, AsyncSnapshot snapshot) => Text(snapshot.data),
          ),
        ],
      ),
    );
  }
}
