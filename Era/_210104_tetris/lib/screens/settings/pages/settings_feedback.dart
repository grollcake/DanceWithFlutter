import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tetris/constants/app_style.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/screens/settings/widgets/subtitle.dart';

class SettingsDetailFeedback extends StatefulWidget {
  const SettingsDetailFeedback({Key? key}) : super(key: key);

  @override
  _SettingsDetailFeedbackState createState() => _SettingsDetailFeedbackState();
}

class _SettingsDetailFeedbackState extends State<SettingsDetailFeedback> {
  final TextEditingController controller = TextEditingController();
  bool hasMessage = false;
  String thanks = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSubtitle(title: 'Feedback'),
        Text('Do you enjoy the game?\nSend me of your feeling or something',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppStyle.bgColorWeak,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppStyle.bgColorAccent,
              width: 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              setState(() {
                hasMessage = value.trim().length > 0;
              });
            },
            minLines: 5,
            maxLines: 20,
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontSize: 16, color: AppStyle.lightTextColor),
            decoration: InputDecoration(
              isDense: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: thanks.isNotEmpty ? AppStyle.accentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              thanks,
              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(flex: 1),
        Center(
          child: ElevatedButton.icon(
            icon: Icon(Icons.mail, color: AppStyle.darkTextColor, size: 18),
            onPressed: hasMessage
                ? () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    sendFeedback(controller.text);
                    setState(() {
                      controller.text = '';
                      hasMessage = false;
                      thanks = 'Thank you for feedback!';
                    });
                    Timer(Duration(seconds: 2), () {
                      setState(() {
                        thanks = '';
                      });
                    });
                  }
                : null,
            label: Text('S E N D', style: TextStyle(fontSize: 16, color: AppStyle.darkTextColor)),
            style: ElevatedButton.styleFrom(
              primary: AppStyle.accentColor,
              minimumSize: Size(160, 34),
            ),
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }

  Future<void> sendFeedback(String message) async {
    final feedbackDoc = FirebaseFirestore.instance.collection('feedbacks').doc();

    final feedback = <String, dynamic>{
      'userId': AppSettings.userId,
      'username': AppSettings.username,
      'message': message,
      'dateTime': DateTime.now(),
      'platform': defaultTargetPlatform.toString(),
    };

    await feedbackDoc.set(feedback);
    return;
  }
}
