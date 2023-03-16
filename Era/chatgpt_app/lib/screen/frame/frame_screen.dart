import 'package:chatgpt_app/screen/main/main_screen.dart';
import 'package:flutter/material.dart';

class FrameScreen extends StatelessWidget {
  const FrameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    final descStyle = TextStyle(fontSize: 16, color: Colors.black54, height: 1.8);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB86BF8).withOpacity(.2), Color(0xFF6BB5F8).withOpacity(.2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ChatGPT demo', style: TextStyle(fontSize: 36, color: Colors.black54, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('✅ S-Talk에 ChatGPT를 적용하면 어떤 모습일지 미리 확인하기 위한 데모', style: descStyle),
                Text('✅ Shinny는 이해를 돕기 위해 임의로 제작한 챗봇 캐릭터', style: descStyle),
                Text('✅ ChatGPT API Key를 앱에 내장하여 서비스 직접 호출 (백엔드 서버 불필요)', style: descStyle),
                Text('✅ 주민등록번호 입력 시 패턴을 감지하여 전송 차단', style: descStyle),
              ],
            ),
          ),
          SizedBox(width: 40),
          Container(
            constraints: BoxConstraints(
              maxWidth: 500,
              maxHeight: 1200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 2,
                color: Colors.black54,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(10, 10),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MainScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
