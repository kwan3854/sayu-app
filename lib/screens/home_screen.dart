import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../theme/app_colors.dart';
import '../widgets/enso_circle.dart';
import '../widgets/zen_container.dart';
import '../widgets/premium_glass_container.dart';
import 'onboarding/welcome_screen_v2.dart';
import 'onboarding/thought_habit_screen.dart';
import 'main/morning_sayu_screen.dart';
import 'main/insight_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 패턴
          _buildBackgroundPattern(),
          // 메인 콘텐츠
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        // Enso Circle 로고
                        EnsoCircle(
                          size: 120,
                          strokeWidth: 4,
                          animate: true,
                          child: const Center(
                            child: Text(
                              '思',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w300,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(height: 16),
                    Text(
                      '사유',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sāyu',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '알고리즘의 소음 속,\n고요히 사유할 시간',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.8,
                          ),
                    ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
              Text(
                '화면 목록',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildSectionHeader(context, '온보딩'),
                    _buildMenuItem(
                      context,
                      '1. 환영 화면',
                      '/welcome',
                      Icons.spa_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '2. 생각 습관 진단',
                      '/thought-habit',
                      Icons.psychology_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '3. 정보 필터링 설정',
                      '/filtering',
                      Icons.filter_alt_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '4. 알림 설정',
                      '/notification',
                      Icons.notifications_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '5. 온보딩 완료',
                      '/onboarding-complete',
                      Icons.check_circle_outline,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionHeader(context, '메인 화면'),
                    _buildMenuItem(
                      context,
                      '6. 사유의 아침',
                      '/morning-sayu',
                      Icons.wb_sunny_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '7. 이슈 상세 브리핑',
                      '/issue-detail',
                      Icons.article_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '8. 사유의 통찰',
                      '/insight',
                      Icons.lightbulb_outline,
                    ),
                    _buildMenuItem(
                      context,
                      '9. 예측 검증 및 분석',
                      '/prediction-verify',
                      Icons.analytics_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '10. 나의 예측 히스토리',
                      '/prediction-history',
                      Icons.history,
                    ),
                    _buildMenuItem(
                      context,
                      '11. 사유의 시간',
                      '/reflection',
                      Icons.edit_note,
                    ),
                    _buildMenuItem(
                      context,
                      '12. 마이 성찰 노트',
                      '/reflection-notes',
                      Icons.book_outlined,
                    ),
                    _buildMenuItem(
                      context,
                      '13. 나의 사유 여정',
                      '/journey',
                      Icons.trending_up,
                    ),
                    _buildMenuItem(
                      context,
                      '14. 설정',
                      '/settings',
                      Icons.settings_outlined,
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
      child: Row(
        children: [
          // 장식 선
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.accent,
                  AppColors.primary,
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.5,
                ),
          ),
          const SizedBox(width: 16),
          // 장식 점선
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.textTertiary.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: PremiumGlassContainer(
        onTap: () {
          _navigateToScreen(context, route);
        },
        padding: const EdgeInsets.all(20),
        hasShimmer: true,
        hasGlow: false,
        borderRadius: 16,
        child: Row(
          children: [
            // 아이콘 컨테이너 - 그라데이션 배경
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    AppColors.accent.withOpacity(0.1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: AppColors.primaryLight,
                size: 24,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    height: 1,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 화살표 아이콘 - 부드러운 애니메이션
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryLight,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: Stack(
        children: [
          // 기본 그라데이션 배경
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.background,
                  AppColors.background.withOpacity(0.95),
                  AppColors.surface.withOpacity(0.3),
                ],
              ),
            ),
          ),
          
          // 오로라 효과
          Positioned(
            top: -200,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.08),
                    AppColors.accent.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // 일본식 파문 효과
          Positioned(
            bottom: -150,
            left: -150,
            child: CustomPaint(
              size: const Size(400, 400),
              painter: RipplePainter(),
            ),
          ),
          
          // 금가루 효과
          Positioned.fill(
            child: CustomPaint(
              painter: GoldDustPainter(),
            ),
          ),
          
          // 부드러운 빛 효과
          Positioned(
            top: 100,
            left: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.15),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String route) {
    Widget? screen;
    
    switch (route) {
      case '/welcome':
        screen = const WelcomeScreenV2();
        break;
      case '/thought-habit':
        screen = const ThoughtHabitScreen();
        break;
      case '/morning-sayu':
        screen = const MorningSayuScreen();
        break;
      case '/insight':
        screen = const InsightScreen();
        break;
      // TODO: Add more screens
    }
    
    if (screen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen!),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$route 화면은 아직 준비 중입니다'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}

// 일본식 파문 효과 페인터
class RipplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // 여러 겹의 파문
    for (int i = 0; i < 5; i++) {
      paint.color = AppColors.secondary.withOpacity(0.05 - (i * 0.01));
      canvas.drawCircle(center, 50.0 + (i * 40), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 금가루 효과 페인터
class GoldDustPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // 랜덤한 금가루 입자들
    final random = math.Random(42);
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 0.5;
      
      paint.color = AppColors.accentLight.withOpacity(random.nextDouble() * 0.3);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}