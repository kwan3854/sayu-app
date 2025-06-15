import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/router/app_router.dart';
import '../../../../injection.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../domain/entities/daily_briefing.dart';
import '../bloc/morning_briefing_bloc.dart';

@RoutePage()
class DailyBriefingScreen extends StatelessWidget {
  const DailyBriefingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MorningBriefingBloc>()
        ..add(const MorningBriefingEvent.loadBriefing(
          countryCode: 'KR',
          region: 'Seoul',
        )),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<MorningBriefingBloc, MorningBriefingState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                ),
                loaded: (briefing) => _buildBriefingContent(context, briefing),
                noBriefing: () => _buildNoBriefing(context),
                error: (message) => _buildError(context, message),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBriefingContent(BuildContext context, DailyBriefing briefing) {
    final dateFormat = DateFormat('M월 d일 EEEE', 'ko_KR');
    
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MorningBriefingBloc>().add(
          const MorningBriefingEvent.refreshBriefing(
            countryCode: 'KR',
            region: 'Seoul',
          ),
        );
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '사유의 아침',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dateFormat.format(briefing.briefingDate),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  color: AppColors.textSecondary,
                  onPressed: () {
                    // TODO: Navigate to settings
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // News Items or Topics
            ...briefing.topics.asMap().entries.map((entry) {
              final index = entry.key;
              final topic = entry.value;
              final position = index + 1;
              
              // Check if we have a news item for this position
              final newsItem = briefing.newsItems
                  .where((item) => item.position == position)
                  .firstOrNull;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: newsItem != null 
                    ? _buildNewsItemCard(context, newsItem)
                    : _buildTopicCard(context, topic, index, isProcessing: true),
              );
            }),
            
            // Processing indicator if not all items are ready
            if (briefing.newsItems.length < briefing.topics.length) ...[
              const SizedBox(height: 16),
              _buildProcessingIndicator(context, briefing.newsItems.length, briefing.topics.length),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, BriefingTopic topic, int index, {bool isProcessing = false}) {
    return PremiumGlassContainer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                topic.category,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Title
            Text(
              topic.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
            ),
            const SizedBox(height: 8),
            
            // Keywords
            Wrap(
              spacing: 8,
              children: topic.keywords.map((keyword) => Text(
                '#$keyword',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textTertiary,
                ),
              )).toList(),
            ),
            if (isProcessing) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '리서치 진행중...',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItemCard(BuildContext context, NewsItem item) {
    return PremiumGlassContainer(
      onTap: () {
        context.router.push(NewsDetailRoute(newsItem: item));
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '뉴스 ${item.position}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Title
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            
            // Summary (간단히)
            Text(
              item.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            
            // CTA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.sources.length}개 출처',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      '자세히 보기',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoBriefing(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper_outlined,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            '오늘의 브리핑이 아직 준비되지 않았습니다',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '잠시 후 다시 확인해주세요',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingIndicator(BuildContext context, int completed, int total) {
    return PremiumGlassContainer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '뉴스 리서치 진행중',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: completed / total,
              backgroundColor: AppColors.gray800,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              '$completed / $total 완료',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            '브리핑을 불러올 수 없습니다',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textTertiary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<MorningBriefingBloc>().add(
                const MorningBriefingEvent.loadBriefing(
                  countryCode: 'KR',
                  region: 'Seoul',
                ),
              );
            },
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }

  Color _getFactCheckColor(String status) {
    switch (status) {
      case 'verified':
        return Colors.green;
      case 'partially_verified':
        return Colors.orange;
      case 'disputed':
        return Colors.red;
      default:
        return AppColors.textTertiary;
    }
  }

  IconData _getFactCheckIcon(String status) {
    switch (status) {
      case 'verified':
        return Icons.check_circle;
      case 'partially_verified':
        return Icons.help;
      case 'disputed':
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  String _getFactCheckLabel(String status) {
    switch (status) {
      case 'verified':
        return '사실 확인됨';
      case 'partially_verified':
        return '부분적으로 확인됨';
      case 'disputed':
        return '논란 있음';
      default:
        return '미확인';
    }
  }
}