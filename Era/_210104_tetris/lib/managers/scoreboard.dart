import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tetris/managers/app_settings.dart';
import 'package:tetris/models/score.dart';

class ScoreBoard {
  int _rank = 0;
  int get rank => _rank;

  // 점수 등록
  Future<void> updateScore({required int score, required int level}) async {
    // Firestore에 이미 등록된 정보가 있는지 확인한다. (userId, username은 AppSettings에서 가져온다)
    Score? remoteScore = await _firestoreFetch();
    if (remoteScore != null) {
      remoteScore.score = max(score, remoteScore.score ?? 0);
      remoteScore.level = max(level, remoteScore.level ?? 1);
      remoteScore.username = AppSettings.username;
      remoteScore.playCount = (remoteScore.playCount ?? 0) + 1;
      remoteScore.dateTime = DateTime.now();

      final DocumentReference docRef = FirebaseFirestore.instance.collection('scoreboards').doc(remoteScore.userId);
      await docRef.update(remoteScore.toJson());
      return;
    }

    // Firestore에 정보가 없다면 신규로 생성한다.
    final scoreDoc = FirebaseFirestore.instance.collection('scoreboards').doc();
    AppSettings.userId = scoreDoc.id;
    print('New userId is generated: ${AppSettings.userId}');

    Score newScore = Score(
        userId: scoreDoc.id,
        username: AppSettings.username,
        score: score,
        level: level,
        dateTime: DateTime.now(),
        playCount: 1,
        deviceUUID: 'unknown',
        platform: 'unknown');

    await scoreDoc.set(newScore.toJson());
    return;
  }

  // 모든 유저의 점수 조회
  Future<List<Score>> fetchAllScores() async {
    final allScores = await FirebaseFirestore.instance
        .collection('scoreboards')
        .orderBy('score', descending: true)
        .orderBy('level', descending: true)
        .get();
    if (allScores.docs.isNotEmpty) {
      List<Score> results = allScores.docs.map((e) => Score.fromJson(e.data())).toList();

      _rank = results.indexWhere((element) => element.userId == AppSettings.userId) + 1;

      return results;
    } else {
      return [];
    }
  }

  // 파이어스토어에서 사용자의 데이터를 가져온다.
  Future<Score?> _firestoreFetch() async {
    if (AppSettings.userId == null || AppSettings.userId!.isEmpty) {
      return null;
    }
    final scoreSnapshot = await FirebaseFirestore.instance.collection('scoreboards').doc(AppSettings.userId).get();
    if (!scoreSnapshot.exists) {
      return null;
    }
    return Score.fromJson(scoreSnapshot.data() as Map<String, dynamic>);
  }
}
