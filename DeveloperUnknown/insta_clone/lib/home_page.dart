import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'feed_widget.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Clone", style: GoogleFonts.pacifico(),)
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: _buildNoPostBody(),
    );
  }

  Widget _buildNoPostBody() {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Instagram에 오신 것을 환영합니다.', style: TextStyle(fontSize: 24),),
              SizedBox(height: 16,),
              Text('사진과 동영상을 보려면 팔로우하세요'),
              SizedBox(height: 32,),
              SizedBox(
                width: 260,
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2017/09/21/19/12/france-2773030_1280.jpg'),
                          ),
                        ),
                        SizedBox(height:16),
                        Text(
                          'test@test.com',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('test 유저'),
                        SizedBox(height:16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2017/09/21/19/12/france-2773030_1280.jpg',
                                  fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.0),
                            ),
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2017/06/21/05/42/fog-2426131_1280.jpg',
                                  fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.0),
                            ),
                            SizedBox(
                              width: 70.0,
                              height: 70.0,
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2019/02/04/20/07/flowers-3975556_1280.jpg',
                                  fit: BoxFit.cover),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Facebook 친구'),
                        SizedBox(height: 8),
                        RaisedButton(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          child: Text('팔로우'),
                          onPressed: () => print('팔로우 클릭'),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHasPostBody() {
    return Container();
  }
}