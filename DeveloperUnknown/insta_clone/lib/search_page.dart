import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/create_page.dart';
import 'package:insta_clone/detail_post_page.dart';

class SearchPage extends StatelessWidget {
  final FirebaseUser user;

  SearchPage(this.user);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Instagram Clone',
        style: GoogleFonts.pacifico(),
      ),
    );
  }

  Widget _buildBody(context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(context, snapshot.data.documents[index]);
              },
            );
          }
        }
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child:  Icon(Icons.create),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CreatePage(user)
          ));
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    print(document['email']);
    return Hero(
      tag: document.documentID,
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder:(context) => DetailPostPage(document, user)),
            );
          },
          child: Image.network(
            document["photoUrl"],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}