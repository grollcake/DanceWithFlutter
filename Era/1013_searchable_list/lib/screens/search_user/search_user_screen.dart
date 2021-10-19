import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:searchable_list/models/user.dart';
import 'package:searchable_list/models/user_data.dart';
import 'package:searchable_list/screens/search_user/widgets/user_tile.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  List<User> _searched = [];

  onSearch(String keyword) {
    setState(() {
      _searched = AllUsers.where((element) => element.name.toLowerCase().contains(keyword.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searched = AllUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Column(
          children: [
            buildSearchBox(),
            Expanded(child: buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget buildUserList() {
    return Container(
      child: _searched.length > 0
          ? ListView.builder(
              itemCount: _searched.length,
              itemBuilder: (context, idx) => UserTile(
                name: _searched[idx].name,
                username: _searched[idx].username,
                image: _searched[idx].image,
                isFollowedByMe: _searched[idx].isFollowedByMe,
                onPressed: () => setState(() {
                  _searched[idx].isFollowedByMe = !_searched[idx].isFollowedByMe;
                }),
              ),
            )
          : Center(
              child: Text('No matched user', style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
            ),
    );
  }

  Widget buildSearchBox() {
    return Container(
      margin: EdgeInsets.all(12),
      height: 34,
      child: TextField(
        onChanged: onSearch,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
          hintText: 'Search user',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          fillColor: Colors.grey.shade700,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
