import 'dart:math';
import '../../domain/entities/prediction_challenge.dart';

class PredictionRepositoryMock {
  static final _random = Random();
  
  static final List<Map<String, dynamic>> _microPredictions = [
    {
      'id': 'micro_1',
      'question': '오늘 코스피 지수는 어떻게 마감할까요?',
      'options': ['상승 (전일 대비 +)', '하락 (전일 대비 -)', '보합 (±0.3% 이내)'],
      'context': '어제 코스피는 2,501.23으로 마감했습니다. 미국 증시는 혼조세를 보였고, 원/달러 환율은 소폭 상승했습니다.',
    },
    {
      'id': 'micro_2',
      'question': '오늘 발표될 소비자물가지수(CPI)는 예상치를 상회할까요?',
      'options': ['예상치 상회', '예상치 하회', '예상치 부합'],
      'context': '시장 예상치는 전년 동월 대비 2.3% 상승입니다. 지난달은 2.5%를 기록했습니다.',
    },
    {
      'id': 'micro_3',
      'question': '내일 서울 날씨는 어떨까요?',
      'options': ['맑음', '흐림', '비/눈'],
      'context': '현재 고기압의 영향권에 있으며, 서쪽에서 저기압이 접근 중입니다.',
    },
  ];
  
  static final List<Map<String, dynamic>> _macroPredictions = [
    {
      'id': 'macro_1',
      'question': '다음 주 한국은행 금융통화위원회의 기준금리 결정은?',
      'options': ['인상 (+0.25%p)', '동결 (3.50% 유지)', '인하 (-0.25%p)'],
      'context': '현재 기준금리는 3.50%입니다. 물가는 안정세를 보이고 있으나 경기 둔화 우려가 커지고 있습니다.',
      'expertConsensus': '시장 전문가 70%가 동결을 예상하고 있으며, 25%는 인하, 5%는 인상을 전망합니다.',
    },
    {
      'id': 'macro_2',
      'question': '이번 달 삼성전자 영업이익은 시장 컨센서스를 상회할까요?',
      'options': ['상회 (컨센서스 대비 +5% 이상)', '부합 (±5% 이내)', '하회 (컨센서스 대비 -5% 이하)'],
      'context': '시장 컨센서스는 10.3조원입니다. 메모리 반도체 가격 회복세와 AI 칩 수요 증가가 긍정적 요인입니다.',
      'expertConsensus': '증권사 리포트 분석 결과, 평균 전망치는 10.5조원이며, 최고 11.2조원, 최저 9.8조원입니다.',
    },
  ];
  
  static final List<Map<String, dynamic>> _strategicPredictions = [
    {
      'id': 'strategic_1',
      'question': '2025년 말 전기차가 국내 신차 판매에서 차지하는 비중은?',
      'options': ['10% 미만', '10-15%', '15-20%', '20% 이상'],
      'context': '2024년 현재 전기차 비중은 약 8%입니다. 정부는 전기차 보조금을 단계적으로 축소하고 있으나, 충전 인프라는 지속 확대 중입니다.',
      'expertConsensus': '업계 전문가들은 충전 인프라 확충과 가격 경쟁력 개선을 주요 변수로 보고 있습니다.',
    },
    {
      'id': 'strategic_2',
      'question': '1년 후 AI가 가장 큰 영향을 미칠 산업 분야는?',
      'options': ['금융/보험', '의료/헬스케어', '제조/물류', '교육/콘텐츠'],
      'context': '생성형 AI의 급속한 발전으로 다양한 산업에서 혁신이 일어나고 있습니다.',
      'expertConsensus': '각 분야별로 AI 도입 속도와 규제 환경이 다르게 전개되고 있습니다.',
    },
  ];

  static Future<List<PredictionChallenge>> getTodaysPredictions() async {
    await Future.delayed(const Duration(seconds: 1));
    
    final List<PredictionChallenge> predictions = [];
    
    // 마이크로 예측 1개
    final microIndex = _random.nextInt(_microPredictions.length);
    final micro = _microPredictions[microIndex];
    predictions.add(PredictionChallenge(
      id: micro['id'],
      type: 'micro',
      question: micro['question'],
      context: micro['context'],
      options: List<String>.from(micro['options']),
      deadline: DateTime.now().add(const Duration(hours: 6)),
      isActive: true,
    ));
    
    // 매크로 예측 1개
    final macroIndex = _random.nextInt(_macroPredictions.length);
    final macro = _macroPredictions[macroIndex];
    predictions.add(PredictionChallenge(
      id: macro['id'],
      type: 'macro',
      question: macro['question'],
      context: macro['context'],
      options: List<String>.from(macro['options']),
      deadline: DateTime.now().add(const Duration(days: 7)),
      expertConsensus: macro['expertConsensus'],
      isActive: true,
    ));
    
    // 전략적 예측 1개
    final strategicIndex = _random.nextInt(_strategicPredictions.length);
    final strategic = _strategicPredictions[strategicIndex];
    predictions.add(PredictionChallenge(
      id: strategic['id'],
      type: 'strategic',
      question: strategic['question'],
      context: strategic['context'],
      options: List<String>.from(strategic['options']),
      deadline: DateTime.now().add(const Duration(days: 365)),
      expertConsensus: strategic['expertConsensus'],
      isActive: true,
    ));
    
    return predictions;
  }
  
  static Future<void> submitPrediction(String challengeId, String selectedOption) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Save prediction to local storage
  }
}