import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final descStyle = TextStyle(fontSize: 16, color: Colors.black54, height: 1.8);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ChatGPT demo', style: TextStyle(fontSize: 36, color: Colors.black54, fontWeight: FontWeight.bold)),
        SizedBox(height: 32),
        Text('S-Talk에 ChatGPT를 적용한다면 어떤 모습일까요?', style: descStyle),
        Text('신한의 챗봇 Shinny는 우리의 업무를 어떻게 도와줄까요?', style: descStyle),
        Text('※ Shinny는 이해를 돕기 위해 임시로 제작한 캐릭터입니다.', style: descStyle.copyWith(fontSize: 14)),
        SizedBox(height: 32),
        Text('기능', style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text('✅ OpenAI의 gpt-3.5-turbo 모델 사용', style: descStyle),
        Text('✅ 대화 맥락 유지 (최근 20개 대화까지)', style: descStyle),
        Text('✅ 재응답 요청 시 창작, 균형, 정확 중 선택 가능', style: descStyle),
        Text('✅ 질의어에 주민등록번호 감지 시 경고 노출', style: descStyle),
        Text('✅ [비용보기]를 눌러 예상 비용 계산 (1,000 토큰당 \$0.002)', style: descStyle),
        Text('       - 맥락 유지를 위해 최근 20개 대화를 전송하므로 이용할 수록 토큰 사용량 증가', style: descStyle),
        Text('✅ API Key를 앱에 내장하여 서비스 직접 호출 (백엔드 서버 X)', style: descStyle),
        SizedBox(height: 32),
        Text('제약', style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text('❌ 반응형 UI가 적용되지 않아 PC에서만 정상 이용 가능', style: descStyle),
        Text('❌ 대화 이력을 유지하지 못함 (접속할 때마다 초기화)', style: descStyle),
      ],
    );
  }
}
