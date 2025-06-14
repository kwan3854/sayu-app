import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../domain/entities/prediction_challenge.dart';
import '../../data/repositories/prediction_repository_mock.dart';

@RoutePage()
class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PredictionChallenge>? _predictions;
  bool _isLoading = true;
  final Map<String, String> _selectedOptions = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPredictions();
  }

  Future<void> _loadPredictions() async {
    try {
      final predictions = await PredictionRepositoryMock.getTodaysPredictions();
      setState(() {
        _predictions = predictions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('사유의 통찰'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Navigate to prediction history
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '오늘의 마이크로 예측'),
            Tab(text: '주간/월간 예측'),
            Tab(text: '전략적 예측'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            )
          : _predictions == null || _predictions!.isEmpty
              ? const Center(
                  child: Text('예측 챌린지를 불러올 수 없습니다'),
                )
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMicroPrediction(),
                    _buildMacroPrediction(),
                    _buildStrategicPrediction(),
                  ],
                ),
    );
  }

  Widget _buildMicroPrediction() {
    final microPredictions = _predictions!.where((p) => p.type == 'micro').toList();
    if (microPredictions.isEmpty) {
      return const Center(child: Text('오늘의 마이크로 예측이 없습니다'));
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: microPredictions.map((prediction) => 
          _buildPredictionCard(prediction, showDeadline: true)
        ).toList(),
      ),
    );
  }

  Widget _buildMacroPrediction() {
    final macroPredictions = _predictions!.where((p) => p.type == 'macro').toList();
    if (macroPredictions.isEmpty) {
      return const Center(child: Text('주간/월간 예측이 없습니다'));
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: macroPredictions.map((prediction) => 
          _buildPredictionCard(prediction, showExpertConsensus: true)
        ).toList(),
      ),
    );
  }

  Widget _buildStrategicPrediction() {
    final strategicPredictions = _predictions!.where((p) => p.type == 'strategic').toList();
    if (strategicPredictions.isEmpty) {
      return const Center(child: Text('전략적 예측이 없습니다'));
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: strategicPredictions.map((prediction) => 
          _buildPredictionCard(prediction, showExpertConsensus: true)
        ).toList(),
      ),
    );
  }

  Widget _buildPredictionCard(
    PredictionChallenge prediction, {
    bool showDeadline = false,
    bool showExpertConsensus = false,
  }) {
    final selectedOption = _selectedOptions[prediction.id];
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: PremiumGlassContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 질문
            Text(
              prediction.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
            ),
            const SizedBox(height: 16),
            
            // 컨텍스트
            if (prediction.context != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.gray800,
                    width: 1,
                  ),
                ),
                child: Text(
                  prediction.context!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // 전문가 의견
            if (showExpertConsensus && prediction.expertConsensus != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.group_outlined,
                    size: 20,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '전문가 의견',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                prediction.expertConsensus!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 16),
            ],
            
            // 선택지
            ...prediction.options.map((option) {
              final isSelected = selectedOption == option;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOptions[prediction.id] = option;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.primary
                            : AppColors.gray800,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected 
                                  ? AppColors.primary
                                  : AppColors.textTertiary,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: isSelected 
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            
            const SizedBox(height: 20),
            
            // 마감 시간 또는 제출 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showDeadline) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '마감: ${_formatDeadline(prediction.deadline)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                            ),
                      ),
                    ],
                  ),
                ],
                if (selectedOption != null)
                  ElevatedButton(
                    onPressed: () => _submitPrediction(prediction.id, selectedOption),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('예측 제출'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);
    
    if (difference.inHours < 24) {
      return '${difference.inHours}시간 후';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 후';
    } else {
      return DateFormat('M월 d일').format(deadline);
    }
  }

  Future<void> _submitPrediction(String challengeId, String selectedOption) async {
    await PredictionRepositoryMock.submitPrediction(challengeId, selectedOption);
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('예측이 제출되었습니다'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}