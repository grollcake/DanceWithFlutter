import 'dart:async';

import 'package:dictionary/managers/dicionary_manager.dart';
import 'package:dictionary/model/search_result.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;
  late DictionaryManager _dictionaryManager;
  Timer? _timer;
  String lastSearchWord = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _dictionaryManager = DictionaryManager();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void _search() {
    print('in _search()');
    lastSearchWord = _textEditingController.text;
    _dictionaryManager.search(_textEditingController.text);
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
      title: Text('Dictionary'),
      centerTitle: true,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (String input) {
                    print('User input: $input');
                    if (input.trim().isEmpty) return;
                    if (_timer?.isActive ?? false) _timer!.cancel();
                    _timer = Timer(Duration(seconds: 1), _search);
                  },
                  onSubmitted: (String input) {
                    print('User submitted with $input');
                    if (input != lastSearchWord) _search();
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.book),
                    hintText: '어떤 단어가 궁금하세요?',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    isCollapsed: true,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _search,
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderBody() {
    return Container(
      padding: EdgeInsets.all(8),
      child: StreamBuilder(
        stream: _dictionaryManager.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: Text('궁금한 단어를 입력해보세요\nOwl은 어떠세요?', textAlign: TextAlign.center));
            case ConnectionState.active:
              SearchResult result = snapshot.data;
              if (result.status == SearchStatus.error) {
                return Center(
                    child: Text(result.errorMessage,
                        style: TextStyle(color: Colors.deepPurple, fontStyle: FontStyle.italic)));
              } else if (result.status == SearchStatus.inSearching) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.separated(
                  itemCount: result.definitions!.length,
                  separatorBuilder: (ctx, idx) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    Definition definition = result.definitions![index];
                    return ListTile(
                      title: Text(definition.type,
                          style: TextStyle(fontSize: 16, color: Colors.black26, fontStyle: FontStyle.italic)),
                      subtitle: Text(definition.definition, style: TextStyle(fontSize: 16, color: Colors.black87)),
                      trailing: definition.imageUrl.isNotEmpty
                          ? Image.network(definition.imageUrl, fit: BoxFit.contain)
                          : null,
                    );
                  },
                );
              }
            case ConnectionState.done:
              return Center(child: Text('ConnectionState.done'));
          }
        },
      ),
    );
  }
}
