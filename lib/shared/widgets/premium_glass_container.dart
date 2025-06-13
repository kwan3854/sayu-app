import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PremiumGlassContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool hasShimmer;
  final bool hasGlow;

  const PremiumGlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius = 20,
    this.onTap,
    this.hasShimmer = true,
    this.hasGlow = true,
  });

  @override
  State<PremiumGlassContainer> createState() => _PremiumGlassContainerState();
}

class _PremiumGlassContainerState extends State<PremiumGlassContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    if (widget.hasShimmer) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: Stack(
        children: [
          // 배경 글로우 효과
          if (widget.hasGlow)
            Positioned(
              top: -20,
              left: -20,
              right: -20,
              bottom: -20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius + 20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      color: AppColors.secondary.withValues(alpha: 0.05),
                      blurRadius: 60,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          
          // 메인 글래스 컨테이너
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surfaceLight.withValues(alpha: 0.6),
                      AppColors.surface.withValues(alpha: 0.4),
                      AppColors.surfaceVariant.withValues(alpha: 0.3),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                  border: Border.all(
                    width: 1.5,
                    color: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.3),
                        AppColors.accent.withValues(alpha: 0.2),
                        AppColors.secondary.withValues(alpha: 0.1),
                      ],
                    ).colors.first,
                  ),
                ),
                child: Stack(
                  children: [
                    // 노이즈 텍스처
                    Positioned.fill(
                      child: CustomPaint(
                        painter: NoisePainter(),
                      ),
                    ),
                    
                    // 무지개빛 광택 효과
                    Positioned.fill(
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                              Colors.white.withValues(alpha: 0.0),
                            ],
                          ).createShader(bounds);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.borderRadius),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
                    // 쉬머 효과
                    if (widget.hasShimmer)
                      AnimatedBuilder(
                        animation: _shimmerAnimation,
                        builder: (context, child) {
                          return Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(widget.borderRadius),
                              child: Stack(
                                children: [
                                  Transform.translate(
                                    offset: Offset(_shimmerAnimation.value * 200, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            AppColors.primary.withValues(alpha: 0.1),
                                            Colors.transparent,
                                          ],
                                          stops: const [0.0, 0.5, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    
                    // 컨텐츠
                    if (widget.padding != null)
                      Padding(
                        padding: widget.padding!,
                        child: widget.child,
                      )
                    else
                      widget.child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (widget.onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          splashColor: AppColors.primary.withValues(alpha: 0.1),
          highlightColor: AppColors.primary.withValues(alpha: 0.05),
          child: container,
        ),
      );
    }

    return container;
  }
}

// 화선지 느낌의 노이즈 텍스처
class NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;

    // 랜덤한 점들로 텍스처 생성
    for (int i = 0; i < 100; i++) {
      final x = (i * 17) % size.width;
      final y = (i * 23) % size.height;
      final radius = ((i * 7) % 3).toDouble();
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}