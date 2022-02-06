import 'package:cloud_firestore/cloud_firestore.dart';

class Score {
  String? userId;
  String? username;
  int? score;
  int? level;
  DateTime? dateTime;
  int? playCount;
  String? deviceUUID;
  String? platform;

  Score({
    this.userId,
    this.username,
    this.score,
    this.level,
    this.dateTime,
    this.playCount,
    this.deviceUUID,
    this.platform,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'score': score,
        'datetime': dateTime,
        'level': level,
        'playCount': playCount,
        'deviceUUID': deviceUUID,
        'platform': platform,
      };

  static Score fromJson(Map<String, dynamic> json) => Score(
        userId: json['userId'],
        username: json['username'],
        score: json['score'],
        dateTime: ((json['datetime'] ?? Timestamp.now()) as Timestamp).toDate(),
        level: json['level'],
        playCount: json['playCount'],
        deviceUUID: json['deviceUUID'],
        platform: json['platform'],
      );
}
