import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../../../shared/widgets/zen_container.dart';
import '../../domain/entities/daily_briefing.dart';
import '../../data/repositories/briefing_repository_mock.dart';

@RoutePage()
class BriefingScreen extends StatefulWidget {
  const BriefingScreen({super.key});

  @override
  State<BriefingScreen> createState() => _BriefingScreenState();
}

class _BriefingScreenState extends State<BriefingScreen> {
  DailyBriefing? _briefing;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBriefing();
  }

  Future<void> _loadBriefing() async {
    try {
      final briefing = await BriefingRepositoryMock.getTodaysBriefing();
      setState(() {
        _briefing = briefing;
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
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              )
            : _briefing == null
                ? const Center(
                    child: Text('브리핑을 불러올 수 없습니다'),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 32),
                        _buildGreeting(),
                        const SizedBox(height: 24),
                        _buildWeather(),
                        const SizedBox(height: 32),
                        _buildDailyQuote(),
                        const SizedBox(height: 32),
                        _buildTodaysFocus(),
                        const SizedBox(height: 32),
                        _buildActionPrompts(),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildHeader() {
    final dateFormat = DateFormat('M월 d일 EEEE', 'ko_KR');
    return Column(
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
          dateFormat.format(_briefing!.date),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return ZenContainer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              Icons.wb_sunny_outlined,
              color: AppColors.accent,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _briefing!.greeting,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.6,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeather() {
    return Row(
      children: [
        Icon(
          Icons.cloud_outlined,
          color: AppColors.textTertiary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          _briefing!.weatherSummary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildDailyQuote() {
    return PremiumGlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote,
            color: AppColors.primary,
            size: 32,
          ),
          const SizedBox(height: 16),
          Text(
            _briefing!.dailyQuote,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  height: 1.6,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            '- ${_briefing!.quoteAuthor}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysFocus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘의 집중',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 16),
        ...(_briefing!.todaysFocus.map((focus) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ZenContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          focus,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))),
      ],
    );
  }

  Widget _buildActionPrompts() {
    return Column(
      children: [
        _buildPromptCard(
          icon: Icons.insights_outlined,
          title: '오늘의 예측',
          prompt: _briefing!.microPredictionPrompt,
          color: AppColors.secondary,
          onTap: () {
            // TODO: Navigate to prediction screen
          },
        ),
        const SizedBox(height: 16),
        _buildPromptCard(
          icon: Icons.edit_note_outlined,
          title: '저녁 성찰',
          prompt: _briefing!.reflectionPrompt,
          color: AppColors.accent,
          onTap: () {
            // TODO: Navigate to reflection screen
          },
        ),
      ],
    );
  }

  Widget _buildPromptCard({
    required IconData icon,
    required String title,
    required String prompt,
    required Color color,
    required VoidCallback onTap,
  }) {
    return PremiumGlassContainer(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prompt,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}