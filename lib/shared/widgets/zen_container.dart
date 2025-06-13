import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ZenContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final List<Color>? gradientColors;
  final bool hasGlassEffect;
  final bool hasInkEffect;
  final double borderRadius;
  final double blurAmount;
  final VoidCallback? onTap;

  const ZenContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.gradientColors,
    this.hasGlassEffect = true,
    this.hasInkEffect = false,
    this.borderRadius = 16,
    this.blurAmount = 10,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      child: Stack(
        children: [
          // 배경 레이어 - 그라데이션과 노이즈 텍스처
          if (hasGlassEffect)
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors ?? [
                        AppColors.surface.withValues(alpha: 0.8),
                        AppColors.surface.withValues(alpha: 0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          
          // 잉크 효과 레이어
          if (hasInkEffect)
            Positioned.fill(
              child: CustomPaint(
                painter: InkEffectPainter(),
              ),
            ),
          
          // 테두리와 내부 광택
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: AppColors.gray800.withValues(alpha: 0.3),
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5, 1.0],
                colors: [
                  Colors.white.withValues(alpha: 0.05),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
          
          // 콘텐츠
          if (padding != null)
            Padding(
              padding: padding!,
              child: child,
            )
          else
            child,
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: container,
        ),
      );
    }

    return container;
  }
}

// 먹의 번짐 효과를 표현하는 페인터
class InkEffectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gray900.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    // 불규칙한 원형 패턴
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      size.width * 0.15,
      paint,
    );
    
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.6),
      size.width * 0.12,
      paint,
    );
    
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.2),
      size.width * 0.08,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}