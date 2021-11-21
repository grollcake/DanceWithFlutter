import 'dart:async';

import 'package:flutter/material.dart';
import 'package:owlbot_dictionary/managers/owlbot_manager.dart';
import 'package:owlbot_dictionary/models/owlbot.dart';
import 'package:owlbot_dictionary/screens/homescreen/widgets/word_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late TextEditingController _controller;
  Timer? _timer;
  final OwlbotManager _owlbotManager = OwlbotManager();
  String lastQueryWord = '';

  void _search() {
    _owlbotManager.query(_controller.text);
    lastQueryWord = _controller.text;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: renderBody(),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text('Owlbot Dictionary'),
      centerTitle: true,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(38),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (String input) {
                    print('Input: $input');
                    if (_timer?.isActive ?? false) _timer!.cancel();
                    _timer = Timer(Duration(seconds: 1), () {
                      _search();
                    });
                  },
                  onSubmitted: (String input) {
                    print('User summited keyboard enter with "$input"');
                    if (input != lastQueryWord) _search();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '검색어를 입력하세요',
                    contentPadding: EdgeInsets.all(6),
                    isCollapsed: true,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _search,
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderBody() {
    return StreamBuilder(
      stream: _owlbotManager.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: Text('무엇이 궁금하세요?\nOwl을 한번 검색해보세요', textAlign: TextAlign.center));
          case ConnectionState.active:
            if (!snapshot.hasData) return renderErrorMessage('무언가 잘 못 되었어요');
            OwlbotResult result = snapshot.data;
            if (result.status == WordQueryStatus.error) {
              return renderErrorMessage(result.errorMessage ?? 'Unknown error');
            } else if (result.status == WordQueryStatus.inQuery) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.separated(
                itemCount: result.definitions.length,
                itemBuilder: (BuildContext context, int index) => WordCard(definition: result.definitions[index]),
                separatorBuilder: (BuildContext context, int index) => Divider(),
              );
            }
          case ConnectionState.done:
            return Center(child: Text('Done'));
        }
      },
    );
  }

  Center renderErrorMessage(String message) {
    return Center(child: Text(message, style: TextStyle(color: Colors.red.shade600)));
  }
}
