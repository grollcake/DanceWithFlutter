// start at 21:49 ~ 22:18 (29분 소요)

import 'package:flutter/material.dart';

import 'models/user.dart';

void main() => runApp(MaterialApp(
      title: 'Searchable list',
      debugShowCheckedModeBanner: false,
      home: SearchableListView(),
    ));

class SearchableListView extends StatefulWidget {
  const SearchableListView({Key? key}) : super(key: key);

  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SearchableListView> {
  List<User> _allUsers = [
    User(
        'Elliana Palacios',
        '@elliana',
        'https://images.unsplash.com/photo-1504735217152-b768bcab5ebc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=0ec8291c3fd2f774a365c8651210a18b',
        false),
    User(
        'Kayley Dwyer',
        '@kayley',
        'https://images.unsplash.com/photo-1503467913725-8484b65b0715?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=cf7f82093012c4789841f570933f88e3',
        false),
    User(
        'Kathleen Mcdonough',
        '@kathleen',
        'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
        false),
    User(
        'Kathleen Dyer',
        '@kathleen',
        'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
        false),
    User(
        'Mikayla Marquez',
        '@mikayla',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Kiersten Lange',
        '@kiersten',
        'https://images.unsplash.com/photo-1542534759-05f6c34a9e63?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Carys Metz',
        '@metz',
        'https://images.unsplash.com/photo-1516239482977-b550ba7253f2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Ignacio Schmidt',
        '@schmidt',
        'https://images.unsplash.com/photo-1542973748-658653fb3d12?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Clyde Lucas',
        '@clyde',
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Mikayla Marquez',
        '@mikayla',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false)
  ];
  List<User> _searchedUsers = [];

  @override
  void initState() {
    _searchedUsers = _allUsers;
  }

  onSearch(String keyword) {
    setState(() {
      _searchedUsers = _allUsers.where((user) => user.name.toLowerCase().contains(keyword.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          elevation: 0,
          title: Container(
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade700,
            ),
            child: TextField(
              onChanged: onSearch,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search user',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
              ),
            ),
          ),
        ),
        body: _searchedUsers.length > 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: ListView.builder(
                  itemCount: _searchedUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserTile(
                      user: _searchedUsers[index].name,
                      username: _searchedUsers[index].username,
                      image: _searchedUsers[index].image,
                      isFollowedByMe: _searchedUsers[index].isFollowedByMe,
                      onPressed: () {
                        setState(() {
                          _searchedUsers[index].isFollowedByMe = !_searchedUsers[index].isFollowedByMe;
                        });
                      },
                    );
                  },
                ),
              )
            : Center(child: Text('Matched nothing', style: TextStyle(fontSize: 14, color: Colors.grey.shade500))));
  }
}

class UserTile extends StatelessWidget {
  const UserTile(
      {Key? key,
      required this.user,
      required this.username,
      required this.image,
      required this.isFollowedByMe,
      required this.onPressed})
      : super(key: key);
  final String user;
  final String username;
  final String image;
  final bool isFollowedByMe;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: NetworkImage(image),
      ),
      title: Text(user, style: TextStyle(color: Colors.white)),
      subtitle: Text(username, style: TextStyle(color: Colors.grey.shade500)),
      trailing: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 100,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isFollowedByMe ? Colors.transparent : Colors.grey.shade500),
            color: isFollowedByMe ? Colors.blue : Colors.transparent,
          ),
          child: Center(
            child: Text(
              isFollowedByMe ? 'Unfollow' : 'Follow',
              style: TextStyle(
                fontSize: 14,
                color: isFollowedByMe ? Colors.white : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
