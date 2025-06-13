import 'dart:math';
import '../../domain/entities/daily_briefing.dart';

class BriefingRepositoryMock {
  static final _random = Random();
  
  static final List<Map<String, dynamic>> _quotes = [
    {
      'quote': '일상의 작은 순간에서 큰 깨달음을 발견하라',
      'author': '선 마스터',
    },
    {
      'quote': '마음이 고요할 때 진정한 지혜가 드러난다',
      'author': '달라이 라마',
    },
    {
      'quote': '매일 조금씩 나아가는 것이 큰 변화의 시작이다',
      'author': '노자',
    },
    {
      'quote': '현재에 집중하라. 과거는 지나갔고 미래는 아직 오지 않았다',
      'author': '틱낫한',
    },
    {
      'quote': '작은 물방울이 바위를 뚫는다',
      'author': '한국 속담',
    },
  ];

  static final List<String> _greetings = [
    '오늘도 평온한 하루를 시작하세요',
    '새로운 하루, 새로운 가능성이 열립니다',
    '고요한 아침, 마음을 정돈하는 시간입니다',
    '오늘 하루도 작은 깨달음을 발견하시길',
    '평화로운 아침입니다. 오늘의 여정을 시작해보세요',
  ];

  static final List<List<String>> _focusItems = [
    ['호흡에 집중하기', '감사 일기 쓰기', '10분 명상하기'],
    ['오늘의 우선순위 정하기', '중요한 일 먼저 처리하기', '집중 시간 확보하기'],
    ['주변 사람에게 친절 베풀기', '긍정적인 말 사용하기', '경청 연습하기'],
    ['몸의 신호 알아차리기', '충분한 물 마시기', '스트레칭하기'],
    ['디지털 디톡스 시간 갖기', '자연과 함께하기', '독서 시간 갖기'],
  ];

  static final List<String> _microPredictions = [
    '오늘 예상치 못한 좋은 소식을 들을 것 같나요?',
    '오늘 누군가에게 도움을 줄 기회가 생길까요?',
    '오늘 새로운 아이디어가 떠오를 것 같나요?',
    '오늘 작은 성취감을 느낄 순간이 있을까요?',
    '오늘 마음이 평온해지는 순간을 경험할까요?',
  ];

  static final List<String> _reflectionPrompts = [
    '오늘 가장 감사했던 순간은 무엇이었나요?',
    '오늘 배운 가장 중요한 교훈은 무엇인가요?',
    '오늘 나를 미소짓게 한 것은 무엇이었나요?',
    '오늘 가장 집중했던 순간을 떠올려보세요',
    '오늘 하루를 한 단어로 표현한다면?',
  ];

  static final List<String> _weatherSummaries = [
    '맑고 화창한 날씨',
    '구름이 있지만 포근한 날씨',
    '선선하고 상쾌한 날씨',
    '잔잔한 바람이 부는 날씨',
    '고요하고 평온한 날씨',
  ];

  static Future<DailyBriefing> getTodaysBriefing() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final now = DateTime.now();
    final quote = _quotes[_random.nextInt(_quotes.length)];
    
    return DailyBriefing(
      id: 'briefing_${now.millisecondsSinceEpoch}',
      date: now,
      greeting: _greetings[_random.nextInt(_greetings.length)],
      weatherSummary: _weatherSummaries[_random.nextInt(_weatherSummaries.length)],
      dailyQuote: quote['quote']!,
      quoteAuthor: quote['author']!,
      todaysFocus: _focusItems[_random.nextInt(_focusItems.length)],
      microPredictionPrompt: _microPredictions[_random.nextInt(_microPredictions.length)],
      reflectionPrompt: _reflectionPrompts[_random.nextInt(_reflectionPrompts.length)],
      metadata: {
        'generated_at': now.toIso8601String(),
        'version': '1.0.0',
      },
    );
  }
}