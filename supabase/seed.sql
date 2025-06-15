-- 샘플 데이터 시드

-- 1. 샘플 이슈 데이터 삽입
INSERT INTO issues (id, headline, summary, detailed_summary, image_url, categories, importance, status, published_at)
VALUES 
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    'AI 규제법안 국회 통과, 산업계 우려 vs 시민단체 환영',
    '인공지능 개발과 활용에 대한 포괄적 규제를 담은 법안이 국회를 통과했다. 산업계는 혁신 저해를 우려하는 반면, 시민단체는 AI 윤리 확립의 첫걸음이라 평가한다.',
    '오늘 국회 본회의에서 ''인공지능 산업 육성 및 신뢰 기반 조성에 관한 법률안''이 가결되었습니다. 이 법안은 AI 개발 시 준수해야 할 윤리 원칙, 고위험 AI 시스템의 사전 영향평가 의무화, AI 피해 구제 방안 등을 담고 있습니다.',
    'https://images.unsplash.com/photo-1677442136019-21780ecad995',
    ARRAY['기술', '정책', '사회'],
    5,
    'published',
    NOW() - INTERVAL '2 hours'
  ),
  (
    'b2c3d4e5-f6a7-8901-bcde-f12345678901',
    '한국은행 기준금리 동결, 물가 안정세 속 경기 둔화 우려',
    '한국은행이 기준금리를 3.50%로 동결했다. 물가는 안정세를 보이고 있으나, 경기 둔화 우려가 커지면서 향후 통화정책 방향에 관심이 집중되고 있다.',
    '한국은행 금융통화위원회는 오늘 기준금리를 현 수준인 연 3.50%로 유지하기로 결정했습니다. 이는 5개월 연속 동결로, 물가 안정과 경기 둔화 사이에서 균형을 찾으려는 시도로 해석됩니다.',
    'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3',
    ARRAY['경제', '금융', '정책'],
    4,
    'published',
    NOW() - INTERVAL '4 hours'
  );

-- 2. 이슈 상세 정보 삽입
INSERT INTO issue_details (issue_id, key_terms, term_definitions)
VALUES 
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    ARRAY['고위험 AI', '영향평가', 'AI 윤리위원회'],
    '{"고위험 AI": "의료 진단, 금융 신용평가, 채용 심사 등 개인의 권리와 안전에 중대한 영향을 미칠 수 있는 AI 시스템", "영향평가": "AI 시스템이 사회, 경제, 윤리적으로 미칠 영향을 사전에 분석하고 평가하는 절차", "AI 윤리위원회": "AI 개발과 활용에 관한 윤리 원칙을 수립하고 감독하는 정부 산하 위원회"}'::jsonb
  ),
  (
    'b2c3d4e5-f6a7-8901-bcde-f12345678901',
    ARRAY['기준금리', '물가안정목표제', '경기둔화'],
    '{"기준금리": "중앙은행이 금융기관과 거래할 때 기준이 되는 금리로, 시중 금리에 직접적인 영향을 미침", "물가안정목표제": "중앙은행이 중장기 물가상승률 목표를 설정하고 이를 달성하기 위해 통화정책을 운용하는 제도", "경기둔화": "경제성장률이 잠재성장률을 하회하며 경제활동이 위축되는 상태"}'::jsonb
  );

-- 3. 배경 지식 삽입
INSERT INTO background_knowledge (issue_id, title, content, category, display_order)
VALUES 
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    'EU AI Act와의 비교',
    'EU는 2024년 3월 AI Act를 최종 승인했습니다. 한국의 AI 규제법은 EU보다 상대적으로 유연한 접근을 취하고 있으며, 산업 육성과 규제의 균형을 강조합니다.',
    '관련 법규',
    1
  ),
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    'AI 발전의 역사',
    '2016년 알파고 이후 AI 기술이 급속도로 발전하면서 규제 필요성이 대두되었습니다. 특히 2022년 ChatGPT 출시 이후 AI의 사회적 영향력이 커지면서 각국이 규제 마련에 나서고 있습니다.',
    '역사적 맥락',
    2
  );

-- 4. 팩트 체크 삽입
INSERT INTO fact_checks (issue_id, claim, verdict, explanation, sources, display_order)
VALUES 
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    'EU의 AI Act가 과도한 규제로 혁신을 저해하고 있다',
    '논란의 여지',
    'EU AI Act 시행 이후 일부 기업들이 규제 준수 비용 증가를 호소하고 있으나, 동시에 AI 신뢰성 향상으로 시장 확대 효과도 나타나고 있습니다.',
    ARRAY['Stanford AI Index Report 2024', 'EU Commission AI Act Impact Assessment'],
    1
  ),
  (
    'b2c3d4e5-f6a7-8901-bcde-f12345678901',
    '현재 물가상승률이 한국은행 목표치(2%)에 근접했다',
    '사실',
    '2024년 11월 소비자물가상승률은 2.3%로 한국은행의 중기 물가안정목표 2%에 근접했습니다.',
    ARRAY['통계청 소비자물가동향', '한국은행 물가안정목표 운영상황 점검'],
    1
  );

-- 5. 뉴스 출처 삽입
INSERT INTO news_sources (issue_id, title, publisher, url, published_at)
VALUES 
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    'AI 규제법 국회 통과…"혁신과 규제의 균형 찾아야"',
    '조선일보',
    'https://www.chosun.com/example',
    NOW() - INTERVAL '3 hours'
  ),
  (
    'b2c3d4e5-f6a7-8901-bcde-f12345678901',
    '한국은행, 기준금리 동결…"물가·경기 불확실성"',
    '한국경제신문',
    'https://www.hankyung.com/example',
    NOW() - INTERVAL '5 hours'
  );

-- 6. 다각적 관점 삽입
INSERT INTO perspectives (issue_id, title, content, expert_name, expert_title, perspective_type, perspective_detail, interactive_questions, display_order)
VALUES 
  (
    'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    '혁신과 규제의 균형점을 찾아야',
    '이번 AI 규제법은 필요했던 첫걸음입니다. 그러나 규제의 구체적인 실행 방안이 중요합니다.',
    '김민수',
    'KAIST AI대학원 교수',
    '전문 분야',
    'AI 학계 전문가 관점',
    ARRAY['AI 규제와 혁신 사이의 균형점은 어디라고 생각하시나요?', '중소기업이 규제를 준수하면서도 경쟁력을 유지하려면 어떤 지원이 필요할까요?'],
    1
  ),
  (
    'b2c3d4e5-f6a7-8901-bcde-f12345678901',
    '금리 동결은 적절한 선택',
    '현재 물가가 안정세를 보이고 있지만 여전히 목표치를 상회하고 있습니다. 성급한 금리 인하는 물가 불안을 재점화시킬 수 있습니다.',
    '최윤경',
    '한국금융연구원 선임연구위원',
    '전문 분야',
    '금융 전문가 관점',
    ARRAY['물가 안정과 경기 부양 중 현 시점에서 무엇이 더 중요하다고 보시나요?', '환율 안정을 위해 금리 정책이 어떤 역할을 해야 할까요?'],
    1
  );

-- 7. 예측 챌린지 샘플
INSERT INTO prediction_challenges (title, description, category, options, resolution_date)
VALUES 
  (
    '다음 달 한국은행 금리 결정',
    '12월 금융통화위원회에서 한국은행이 어떤 결정을 내릴까요?',
    '경제',
    '{"options": ["금리 인상 (0.25%p)", "금리 동결", "금리 인하 (0.25%p)"]}'::jsonb,
    CURRENT_DATE + INTERVAL '30 days'
  ),
  (
    'AI 규제법 시행령 수준',
    '내년 상반기 발표될 AI 규제법 시행령의 규제 수준은?',
    '정책',
    '{"options": ["당초 법안보다 완화", "법안 수준 유지", "당초 법안보다 강화"]}'::jsonb,
    CURRENT_DATE + INTERVAL '180 days'
  );