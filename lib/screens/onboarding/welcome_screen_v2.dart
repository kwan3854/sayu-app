import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../../theme/app_colors.dart';
import '../../widgets/enso_circle.dart';
import '../../widgets/zen_button.dart';

class WelcomeScreenV2 extends StatefulWidget {
  const WelcomeScreenV2({super.key});

  @override
  State<WelcomeScreenV2> createState() => _WelcomeScreenV2State();
}

class _WelcomeScreenV2State extends State<WelcomeScreenV2>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _fadeController;
  late Animation<double> _breathingAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // 숨쉬는 애니메이션
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _breathingAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));
    
    _breathingController.repeat(reverse: true);
    
    // 페이드 인 애니메이션
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 - 미묘한 그라데이션과 패턴
          _buildBackground(),
          
          // 메인 콘텐츠
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Skip button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                        ),
                        child: const Text('건너뛰기'),
                      ),
                    ),
                  ),
                  
                  // 중앙 콘텐츠
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 애니메이션 로고
                          AnimatedBuilder(
                            animation: _breathingAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _breathingAnimation.value,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // 배경 광선 효과
                                    Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.primary.withOpacity(0.1),
                                            Colors.transparent,
                                          ],
                                          stops: const [0.5, 1.0],
                                        ),
                                      ),
                                    ),
                                    // Enso Circle
                                    EnsoCircle(
                                      size: 150,
                                      strokeWidth: 3,
                                      animate: true,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '思',
                                            style: TextStyle(
                                              fontSize: 56,
                                              fontWeight: FontWeight.w200,
                                              color: AppColors.primary,
                                              height: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Sāyu',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.textSecondary,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // 타이틀
                          Text(
                            '고요함 속의 깊은 생각',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // 서브타이틀
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Text(
                              '알고리즘의 소음을 벗어나\n나만의 사유 공간으로',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.8,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 48),
                          
                          // 특징 아이콘들
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildFeatureIcon(
                                icon: Icons.remove_red_eye_outlined,
                                label: '다각적 시선',
                              ),
                              const SizedBox(width: 40),
                              _buildFeatureIcon(
                                icon: Icons.insights_outlined,
                                label: '깊은 통찰',
                              ),
                              const SizedBox(width: 40),
                              _buildFeatureIcon(
                                icon: Icons.spa_outlined,
                                label: '성장하는 사유',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // 하단 버튼
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ZenButton(
                      text: '사유 여정 시작하기',
                      onPressed: () => Navigator.pop(context),
                      isLarge: true,
                      width: double.infinity,
                      icon: Icons.arrow_forward,
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

  Widget _buildBackground() {
    return Stack(
      children: [
        // 기본 배경
        Container(
          color: AppColors.background,
        ),
        
        // 대나무 잎 패턴 (상단)
        Positioned(
          top: -50,
          right: -100,
          child: Transform.rotate(
            angle: math.pi / 6,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  center: Alignment.center,
                  colors: [
                    AppColors.primary.withOpacity(0.02),
                    Colors.transparent,
                    AppColors.primary.withOpacity(0.02),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.25, 0.5, 0.75],
                ),
              ),
            ),
          ),
        ),
        
        // 물결 패턴 (하단)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomPaint(
            size: const Size(double.infinity, 200),
            painter: WavePainter(),
          ),
        ),
        
        // 노이즈 텍스처 오버레이
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background.withOpacity(0.8),
                  AppColors.background.withOpacity(0.95),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcon({
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// 물결 페인터
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    
    // 베지어 곡선으로 물결 표현
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.6,
      size.width * 0.5,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.7,
    );
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
    
    // 두 번째 물결
    paint.color = AppColors.secondary.withOpacity(0.02);
    final path2 = Path();
    path2.moveTo(0, size.height * 0.8);
    
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.75,
      size.width * 0.6,
      size.height * 0.8,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.85,
      size.width,
      size.height * 0.8,
    );
    
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}