import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class MorningSayuScreen extends StatelessWidget {
  const MorningSayuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '사유의 아침',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '2025년 1월 6일',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {},
              ),
            ],
          ),
          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Headline Card
                  _buildMainHeadlineCard(context),
                  const SizedBox(height: 24),
                  // Other Issues
                  Text(
                    '오늘의 다른 이슈',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildIssueCard(
                    context,
                    title: 'AI 규제 법안, 글로벌 표준 논의 본격화',
                    summary: '주요국 정부와 빅테크 기업들이 AI 안전성과 윤리적 사용에 대한 국제 표준 마련을 위한 협의에 돌입했습니다.',
                    category: '기술',
                    readingTime: '3분',
                  ),
                  const SizedBox(height: 12),
                  _buildIssueCard(
                    context,
                    title: '탄소중립 목표 달성을 위한 새로운 접근법',
                    summary: '전문가들은 기존 방식의 한계를 지적하며 혁신적인 탄소 포집 기술과 순환경제 모델의 필요성을 강조합니다.',
                    category: '환경',
                    readingTime: '4분',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating Action Button for Prediction
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.trending_up),
        label: const Text('오늘의 예측 참여하기'),
      ),
    );
  }

  Widget _buildMainHeadlineCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.surface.withOpacity(0.8),
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
          // Image placeholder with zen pattern
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              color: AppColors.gray900,
            ),
            child: Stack(
              children: [
                // Zen circle pattern
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                // Category badge
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '경제',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.primaryLight,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '글로벌 경제 불확실성 속,\n새로운 균형점을 찾아가는 시장',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  '미국 연준의 통화정책 변화와 중국의 경제 회복세가 맞물리며 글로벌 시장에 새로운 변수로 작용하고 있습니다. 전문가들은 이러한 변화가 향후 투자 전략에 중요한 영향을 미칠 것으로 전망합니다.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '5분 읽기',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.auto_stories),
                      label: const Text('자세히 사유하기'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
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

  Widget _buildIssueCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String category,
    required String readingTime,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.gray800,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gray800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              const Spacer(),
              Text(
                readingTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}