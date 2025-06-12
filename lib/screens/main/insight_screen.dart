import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedMicroPrediction = -1;
  int _selectedMacroPrediction = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사유의 통찰'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
            tooltip: '나의 예측 히스토리',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '마이크로 예측'),
            Tab(text: '매크로 예측'),
            Tab(text: '전략적 예측'),
          ],
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMicroPredictionTab(),
          _buildMacroPredictionTab(),
          _buildStrategicPredictionTab(),
        ],
      ),
    );
  }

  Widget _buildMicroPredictionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPredictionHeader(
            title: '오늘의 마이크로 예측',
            subtitle: '24시간 내 결과가 나오는 단기 예측',
            icon: Icons.bolt,
          ),
          const SizedBox(height: 24),
          _buildMicroPredictionCard(
            question: '오늘 코스피 지수는 어떻게 마감될까요?',
            options: ['상승 (↑)', '하락 (↓)', '보합 (→)'],
            deadline: '오전 11:00 마감',
            participants: '1,234명 참여 중',
          ),
          const SizedBox(height: 16),
          _buildMicroPredictionCard(
            question: '오늘 발표될 미국 CPI는 예상치를 상회할까요?',
            options: ['상회', '하회', '부합'],
            deadline: '오후 2:00 마감',
            participants: '892명 참여 중',
          ),
        ],
      ),
    );
  }

  Widget _buildMacroPredictionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPredictionHeader(
            title: '주간/월간 매크로 예측',
            subtitle: '1주일~1개월 내 결과가 나오는 중기 예측',
            icon: Icons.timeline,
          ),
          const SizedBox(height: 24),
          _buildMacroPredictionCard(
            title: '다음 주 한국은행 금리 결정',
            contextText: '현재 기준금리 3.25%인 상황에서 한국은행의 통화정책 방향은?',
            expertOpinion: '전문가 컨센서스: 동결 65%, 인하 30%, 인상 5%',
            options: ['동결', '25bp 인하', '25bp 인상'],
            deadline: '1월 10일까지',
          ),
        ],
      ),
    );
  }

  Widget _buildStrategicPredictionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPredictionHeader(
            title: '전략적 장기 예측',
            subtitle: '3개월 이상의 장기적 통찰력을 시험하는 예측',
            icon: Icons.insights,
          ),
          const SizedBox(height: 24),
          _buildStrategicPredictionCard(
            title: '2025년 하반기 AI 산업 전망',
            description: 'ChatGPT 출시 3년, AI 산업의 다음 단계는 무엇일까요? 기술적 발전과 규제 환경, 시장 수요를 종합적으로 고려한 당신의 예측을 들려주세요.',
            guidingQuestions: [
              '현재 AI 기술의 한계점은 무엇인가?',
              '규제가 산업에 미칠 영향은?',
              '어떤 분야에서 혁신이 일어날까?',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primaryVariant.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicroPredictionCard({
    required String question,
    required List<String> options,
    required String deadline,
    required String participants,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gray800,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 20),
          ...options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = _selectedMicroPrediction == index;
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedMicroPrediction = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.gray700,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isSelected ? AppColors.primary : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: 16,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    deadline,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              Text(
                participants,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedMicroPrediction != -1 ? () {} : null,
              child: const Text('예측하기'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroPredictionCard({
    required String title,
    required String contextText,
    required String expertOpinion,
    required List<String> options,
    required String deadline,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gray800,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  contextText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          // Expert Opinion
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people_outline,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    expertOpinion,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
          // Options
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                ...options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final isSelected = _selectedMacroPrediction == index;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedMacroPrediction = index;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.gray700,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
                          ),
                          child: Center(
                            child: Text(
                              option,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      deadline,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _selectedMacroPrediction != -1 ? () {} : null,
                      child: const Text('예측 제출하기'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategicPredictionCard({
    required String title,
    required String description,
    required List<String> guidingQuestions,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.surfaceVariant,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gray800,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.psychology,
                    color: AppColors.secondary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 24),
                Text(
                  '사고를 돕는 가이드 질문',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                ...guidingQuestions.map((question) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.gray900,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.gray800,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: AppColors.textTertiary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('전략적 예측 작성하기'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}