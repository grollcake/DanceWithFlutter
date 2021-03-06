import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comment_page.dart';

class FeedWidget extends StatefulWidget {
  final FirebaseUser user;
  final DocumentSnapshot document;

  FeedWidget(this.document, this.user);

  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commentCount = widget.document['commentCount'] ?? 0;
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.document['userPhotoUrl']),
          ),
          title: Text(
            widget.document['email'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.more_vert),
        ),
        Image.network(
          widget.document['photoUrl'],
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.document['likedUsers']?.contains(widget.user.email) ?? false ?
                GestureDetector(
                  child: Icon(Icons.favorite, color: Colors.red,),
                  onTap: _unlike,
                ) :
                GestureDetector(
                  child: Icon(Icons.favorite_border),
                  onTap: _like,
                ),
              SizedBox(
                width: 8.0,
              ),
              Icon(Icons.comment),
              SizedBox(
                width: 8.0,
              ),
              Icon(Icons.send),
            ],
          ),
          trailing: Icon(Icons.bookmark_border),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            Text(
              '좋아요 ${widget.document['likedUsers']?.length ?? 0}개',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            Text(
              widget.document['email'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(widget.document['contents']),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        if(commentCount > 0)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentPage(widget.document),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '댓글 $commentCount개 모두 보기',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Text(widget.document['lastComment'] ?? "lastComment"),
                ],
              ),
            ),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: _commentController,
                  onSubmitted: (text) {
                    _writeComment(text);
                    _commentController.text = '';
                  },
                  decoration: InputDecoration(
                    hintText: '댓글 달기',
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  // 좋아요
  void _like() {
    final List likedUsers = List<String>.from(widget.document['likedUsers'] ?? []);
    likedUsers.add(widget.user.email);

    final updateData = {
      'likedUsers' : likedUsers,
    };

    Firestore.instance.collection('post').document(widget.document.documentID).updateData(updateData);
  }

  // 좋아요 취소
  void _unlike() {
    final List likedUsers = List<String>.from(widget.document['likedUsers'] ?? []);
    likedUsers.remove(widget.user.email);

    final updateData = {
      'likedUsers' : likedUsers,
    };

    Firestore.instance.collection('post').document(widget.document.documentID).updateData(updateData);
  }

  // 댓글 작성
  void _writeComment(String text) {
    final data = {
      'writer' : widget.user.email,
      'comment' : text,
    };

    Firestore.instance.collection('post').document(widget.document.documentID).collection('comment').add(data);

    final updateData = {
      'lastComment' : text,
      'commentCount' : (widget.document['commentCount'] ?? 0) + 1,
    };

    Firestore.instance.collection('post').document(widget.document.documentID).updateData(updateData);
  }
}
