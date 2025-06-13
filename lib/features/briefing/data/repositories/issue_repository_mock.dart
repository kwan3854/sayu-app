import 'dart:math';
import '../../domain/entities/issue.dart';
import '../../domain/entities/issue_detail.dart';
import '../../domain/entities/perspective.dart';

class IssueRepositoryMock {
  static final _random = Random();
  
  static final List<Map<String, dynamic>> _mockIssues = [
    {
      'id': '1',
      'headline': 'AI 규제법안 국회 통과, 산업계 우려 vs 시민단체 환영',
      'summary': '인공지능 개발과 활용에 대한 포괄적 규제를 담은 법안이 국회를 통과했다. 산업계는 혁신 저해를 우려하는 반면, 시민단체는 AI 윤리 확립의 첫걸음이라 평가한다.',
      'imageUrl': 'https://example.com/ai-regulation.jpg',
      'categories': ['기술', '정책', '사회'],
      'importance': 5,
      'detailedSummary': '''
오늘 국회 본회의에서 '인공지능 산업 육성 및 신뢰 기반 조성에 관한 법률안'이 가결되었습니다. 
이 법안은 AI 개발 시 준수해야 할 윤리 원칙, 고위험 AI 시스템의 사전 영향평가 의무화, 
AI 피해 구제 방안 등을 담고 있습니다.

주요 내용:
- 고위험 AI(의료, 금융, 채용 등) 개발 시 사전 영향평가 의무화
- AI 윤리위원회 설치 및 가이드라인 제정
- AI 사고 발생 시 개발사의 설명 의무 부과
- 중소기업 AI 개발 지원 조항 포함
      ''',
      'keyTerms': ['고위험 AI', '영향평가', 'AI 윤리위원회'],
      'termDefinitions': {
        '고위험 AI': '의료 진단, 금융 신용평가, 채용 심사 등 개인의 권리와 안전에 중대한 영향을 미칠 수 있는 AI 시스템',
        '영향평가': 'AI 시스템이 사회, 경제, 윤리적으로 미칠 영향을 사전에 분석하고 평가하는 절차',
        'AI 윤리위원회': 'AI 개발과 활용에 관한 윤리 원칙을 수립하고 감독하는 정부 산하 위원회'
      },
    },
    {
      'id': '2',
      'headline': '한국은행 기준금리 동결, 물가 안정세 속 경기 둔화 우려',
      'summary': '한국은행이 기준금리를 3.50%로 동결했다. 물가는 안정세를 보이고 있으나, 경기 둔화 우려가 커지면서 향후 통화정책 방향에 관심이 집중되고 있다.',
      'imageUrl': 'https://example.com/interest-rate.jpg',
      'categories': ['경제', '금융', '정책'],
      'importance': 4,
      'detailedSummary': '''
한국은행 금융통화위원회는 오늘 기준금리를 현 수준인 연 3.50%로 유지하기로 결정했습니다.
이는 5개월 연속 동결로, 물가 안정과 경기 둔화 사이에서 균형을 찾으려는 시도로 해석됩니다.

주요 배경:
- 소비자물가 상승률 2.3%로 목표치(2%) 근접
- GDP 성장률 전망치 하향 조정 (2.1% → 1.8%)
- 가계부채 증가세 둔화
- 글로벌 경기 불확실성 지속
      ''',
      'keyTerms': ['기준금리', '물가안정목표제', '경기둔화'],
      'termDefinitions': {
        '기준금리': '중앙은행이 금융기관과 거래할 때 기준이 되는 금리로, 시중 금리에 직접적인 영향을 미침',
        '물가안정목표제': '중앙은행이 중장기 물가상승률 목표를 설정하고 이를 달성하기 위해 통화정책을 운용하는 제도',
        '경기둔화': '경제성장률이 잠재성장률을 하회하며 경제활동이 위축되는 상태'
      },
    },
    {
      'id': '3',
      'headline': '청년 주거 안정 종합대책 발표, 실효성 논란',
      'summary': '정부가 청년층을 위한 공공임대주택 10만호 공급 등을 포함한 주거 안정 대책을 발표했다. 하지만 전문가들은 공급 시기와 입지 문제로 실효성에 의문을 제기하고 있다.',
      'imageUrl': 'https://example.com/youth-housing.jpg',
      'categories': ['부동산', '정책', '사회'],
      'importance': 3,
      'detailedSummary': '''
정부는 오늘 '청년 주거 안정 종합대책'을 발표했습니다. 
2030년까지 청년 전용 공공임대주택 10만호를 공급하고, 청년 전세대출 한도를 확대하는 것이 주요 내용입니다.

주요 정책:
- 청년 공공임대 10만호 공급 (역세권 중심)
- 청년 전세대출 한도 2억원 → 3억원 확대
- 월세 지원금 월 20만원 (소득 하위 30%)
- 청년 주거 상담센터 전국 확대
      ''',
      'keyTerms': ['공공임대주택', '전세대출', '역세권'],
      'termDefinitions': {
        '공공임대주택': '정부나 지방자치단체가 저소득층의 주거 안정을 위해 시세보다 저렴하게 임대하는 주택',
        '전세대출': '전세 보증금 마련을 위해 금융기관에서 받는 대출',
        '역세권': '지하철역을 중심으로 도보 10분 이내의 지역으로, 교통 접근성이 좋은 지역'
      },
    }
  ];

  static final List<Map<String, dynamic>> _perspectives = {
    '1': [
      {
        'title': '혁신과 규제의 균형점을 찾아야',
        'expertName': '김민수',
        'expertTitle': 'KAIST AI대학원 교수',
        'stance': 'neutral',
        'content': '''
이번 AI 규제법은 필요했던 첫걸음입니다. 그러나 규제의 구체적인 실행 방안이 중요합니다. 
너무 엄격한 규제는 국내 AI 산업의 경쟁력을 약화시킬 수 있고, 너무 느슨한 규제는 
시민들의 권익을 보호하지 못할 수 있습니다. 특히 '고위험 AI'의 정의와 범위를 명확히 하고, 
중소기업들이 규제를 준수하면서도 혁신할 수 있는 지원책이 함께 마련되어야 합니다.
        ''',
        'questions': [
          'AI 규제와 혁신 사이의 균형점은 어디라고 생각하시나요?',
          '중소기업이 규제를 준수하면서도 경쟁력을 유지하려면 어떤 지원이 필요할까요?'
        ]
      },
      {
        'title': '글로벌 경쟁력 약화 우려',
        'expertName': '이정희',
        'expertTitle': '벤처기업협회 AI분과 위원장',
        'stance': 'negative',
        'content': '''
미국과 중국이 AI 개발에 전력투구하는 상황에서 우리만 규제의 족쇄를 채우는 것은 자충수입니다. 
특히 사전 영향평가 의무화는 스타트업들에게 큰 부담이 될 것입니다. 개발 속도가 생명인 
AI 산업에서 행정 절차가 늘어나면 혁신이 늦어질 수밖에 없습니다. EU의 AI Act처럼 
과도한 규제가 되지 않도록 시행령 제정 과정에서 산업계 의견을 충분히 반영해야 합니다.
        ''',
        'questions': [
          '글로벌 AI 경쟁에서 규제가 미칠 영향을 어떻게 평가하시나요?',
          '스타트업의 혁신을 저해하지 않으면서도 필요한 규제를 하는 방법은 무엇일까요?'
        ]
      },
      {
        'title': '시민 보호를 위한 필수적 조치',
        'expertName': '박선영',
        'expertTitle': '시민단체 AI감시네트워크 대표',
        'stance': 'positive',
        'content': '''
AI가 채용, 대출 심사, 의료 진단 등 우리 삶의 중요한 결정에 관여하는 시대입니다. 
이런 상황에서 최소한의 안전장치도 없이 기업의 자율에만 맡기는 것은 무책임합니다. 
이번 법안은 AI 개발자들에게 책임감을 부여하고, 시민들이 AI의 결정에 대해 설명을 
요구할 권리를 보장한다는 점에서 의미가 큽니다. 오히려 이런 신뢰 기반이 장기적으로 
AI 산업 발전에도 도움이 될 것입니다.
        ''',
        'questions': [
          'AI의 결정에 대한 설명 요구권이 왜 중요하다고 생각하시나요?',
          '기업의 자율성과 시민 보호 사이에서 어떤 기준으로 균형을 맞춰야 할까요?'
        ]
      }
    ],
    '2': [
      {
        'title': '금리 동결은 적절한 선택',
        'expertName': '최윤경',
        'expertTitle': '한국금융연구원 선임연구위원',
        'stance': 'positive',
        'content': '''
현재 물가가 안정세를 보이고 있지만 여전히 목표치를 상회하고 있습니다. 성급한 금리 인하는 
물가 불안을 재점화시킬 수 있습니다. 특히 환율 변동성이 큰 상황에서 금리 인하는 
자본 유출을 촉발할 위험이 있습니다. 경기 둔화 우려가 있지만, 재정정책으로 대응하면서 
통화정책은 물가 안정에 집중하는 것이 바람직합니다.
        ''',
        'questions': [
          '물가 안정과 경기 부양 중 현 시점에서 무엇이 더 중요하다고 보시나요?',
          '환율 안정을 위해 금리 정책이 어떤 역할을 해야 할까요?'
        ]
      },
      {
        'title': '경기 부양을 위한 금리 인하 필요',
        'expertName': '정상훈',
        'expertTitle': '경제정책연구소 소장',
        'stance': 'negative',
        'content': '''
물가는 이미 안정 궤도에 진입했고, 오히려 디플레이션 우려가 커지고 있습니다. 
높은 금리가 기업 투자와 가계 소비를 억제하면서 경기 둔화를 가속화하고 있습니다. 
미국 연준도 금리 인하를 시사하는 상황에서 우리만 고금리를 유지할 이유가 없습니다. 
최소한 0.25%p라도 인하해 경기에 숨통을 틔워줘야 합니다.
        ''',
        'questions': [
          '현재의 경기 둔화가 일시적인지 구조적인지 어떻게 판단하시나요?',
          '금리 인하가 가계부채에 미칠 영향을 어떻게 관리해야 할까요?'
        ]
      },
      {
        'title': '글로벌 불확실성 속 신중한 접근 필요',
        'expertName': '한지원',
        'expertTitle': '국제경제연구원 연구위원',
        'stance': 'neutral',
        'content': '''
미중 무역갈등, 중동 정세 불안 등 글로벌 불확실성이 여전히 높습니다. 이런 상황에서 
섣부른 정책 변경은 오히려 시장 혼란을 가중시킬 수 있습니다. 당분간 금리를 동결하면서 
글로벌 경제 상황을 지켜보는 것이 현명합니다. 다만 국내 경기 지표를 면밀히 모니터링하면서 
필요시 신속하게 대응할 준비는 해야 합니다.
        ''',
        'questions': [
          '글로벌 경제 상황이 국내 통화정책에 미치는 영향을 어떻게 보시나요?',
          '불확실성이 높을 때 중앙은행의 커뮤니케이션은 어떠해야 할까요?'
        ]
      }
    ],
    '3': [
      {
        'title': '공급 확대는 긍정적, 실행력이 관건',
        'expertName': '임동민',
        'expertTitle': '주택산업연구원 연구위원',
        'stance': 'neutral',
        'content': '''
청년 주거 문제 해결을 위한 정부의 의지는 평가할 만합니다. 특히 역세권 중심의 공급은 
청년들의 수요를 잘 반영한 것입니다. 하지만 10만호라는 목표가 실제로 달성 가능한지, 
공급 시기가 수요와 맞아떨어질지는 의문입니다. 과거 공공임대 사업들이 계획대로 
진행되지 못한 사례들을 볼 때, 실행력 확보가 무엇보다 중요합니다.
        ''',
        'questions': [
          '공공임대주택 공급에서 가장 중요한 성공 요인은 무엇이라고 보시나요?',
          '청년들이 원하는 주거 조건과 정부 정책 사이의 간극을 어떻게 좁힐 수 있을까요?'
        ]
      },
      {
        'title': '근본적 해결책과는 거리가 멀어',
        'expertName': '김수진',
        'expertTitle': '청년주거포럼 대표',
        'stance': 'negative',
        'content': '''
청년 주거 문제의 본질은 높은 집값과 불안정한 일자리입니다. 공공임대 공급이나 대출 확대는 
임시방편에 불과합니다. 오히려 대출 한도 확대는 전세가 상승을 부추길 수 있습니다. 
청년들에게 필요한 것은 안정적인 일자리와 소득, 그리고 집값 안정입니다. 
부동산 투기를 억제하고 청년 고용의 질을 높이는 근본적인 대책이 필요합니다.
        ''',
        'questions': [
          '청년 주거 문제의 근본 원인을 무엇이라고 보시나요?',
          '공급 확대가 아닌 다른 해결 방안은 무엇이 있을까요?'
        ]
      },
      {
        'title': '청년 맞춤형 정책으로 진일보',
        'expertName': '정혜린',
        'expertTitle': '도시계획학과 교수',
        'stance': 'positive',
        'content': '''
이번 대책은 청년층의 특성을 고려한 맞춤형 접근이라는 점에서 의미가 있습니다. 
역세권 공급, 월세 지원, 주거 상담 등 다각도의 지원책을 마련한 것도 긍정적입니다. 
특히 소득 하위 30% 청년에 대한 월세 지원은 실질적인 도움이 될 것입니다. 
다만 중산층 청년들을 위한 정책도 보완되어야 정책의 사각지대를 줄일 수 있을 것입니다.
        ''',
        'questions': [
          '청년 주거 정책에서 소득별 차별화가 필요한 이유는 무엇인가요?',
          '공공과 민간의 협력을 통한 청년 주거 해결 방안은 무엇이 있을까요?'
        ]
      }
    ]
  };

  static Future<List<Issue>> getTodaysIssues() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // 랜덤하게 2-3개의 이슈를 선택
    final shuffled = List<Map<String, dynamic>>.from(_mockIssues)..shuffle(_random);
    final selectedCount = _random.nextInt(2) + 2; // 2 or 3
    final selected = shuffled.take(selectedCount).toList();
    
    return selected.map((data) => Issue(
      id: data['id'],
      headline: data['headline'],
      summary: data['summary'],
      imageUrl: data['imageUrl'],
      publishedAt: DateTime.now().subtract(Duration(hours: _random.nextInt(24))),
      categories: List<String>.from(data['categories']),
      importance: data['importance'],
      metadata: {
        'source': 'Mock Data',
        'readTime': '${_random.nextInt(5) + 3}분'
      },
    )).toList()..sort((a, b) => b.importance.compareTo(a.importance)); // 중요도 순으로 정렬
  }

  static Future<IssueDetail> getIssueDetail(String issueId) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final issueData = _mockIssues.firstWhere((issue) => issue['id'] == issueId);
    final issue = Issue(
      id: issueData['id'],
      headline: issueData['headline'],
      summary: issueData['summary'],
      imageUrl: issueData['imageUrl'],
      publishedAt: DateTime.now().subtract(Duration(hours: _random.nextInt(24))),
      categories: List<String>.from(issueData['categories']),
      importance: issueData['importance'],
    );
    
    final perspectivesData = _perspectives[issueId] ?? [];
    final perspectives = perspectivesData.map((data) => Perspective(
      id: '${issueId}_${perspectivesData.indexOf(data)}',
      issueId: issueId,
      title: data['title'],
      content: data['content'],
      expertName: data['expertName'],
      expertTitle: data['expertTitle'],
      expertImageUrl: null,
      stance: data['stance'],
      interactiveQuestions: List<String>.from(data['questions']),
      createdAt: DateTime.now(),
    )).toList();
    
    return IssueDetail(
      issue: issue,
      detailedSummary: issueData['detailedSummary'] ?? issueData['summary'],
      keyTerms: List<String>.from(issueData['keyTerms'] ?? []),
      termDefinitions: Map<String, String>.from(issueData['termDefinitions'] ?? {}),
      dataVisualizations: [], // TODO: Add mock chart data
      perspectives: perspectives,
      sourcesUrls: [
        'https://example.com/source1',
        'https://example.com/source2',
      ],
    );
  }
}