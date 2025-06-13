import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_colors.dart';

class EnsoCircle extends StatefulWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final Widget? child;
  final bool animate;

  const EnsoCircle({
    super.key,
    this.size = 100,
    this.color,
    this.strokeWidth = 3,
    this.child,
    this.animate = true,
  });

  @override
  State<EnsoCircle> createState() => _EnsoCircleState();
}

class _EnsoCircleState extends State<EnsoCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: EnsoPainter(
                  color: widget.color ?? AppColors.primary.withValues(alpha: 0.6),
                  strokeWidth: widget.strokeWidth,
                  rotation: widget.animate ? _animation.value : 0,
                ),
              ),
              if (widget.child != null) widget.child!,
            ],
          ),
        );
      },
    );
  }
}

class EnsoPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double rotation;

  EnsoPainter({
    required this.color,
    required this.strokeWidth,
    this.rotation = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;

    // 회전 적용
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // 불완전한 원을 그리기 위한 경로
    final path = Path();
    const startAngle = -math.pi / 2;
    const sweepAngle = math.pi * 1.85; // 완전한 원이 아닌 약간 열린 원

    // 베지어 곡선으로 자연스러운 브러시 효과
    final rect = Rect.fromCircle(center: center, radius: radius);
    path.addArc(rect, startAngle, sweepAngle);

    // 그라데이션 효과를 위한 쉐이더
    final gradient = SweepGradient(
      center: Alignment.center,
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [
        color.withValues(alpha: 0.3),
        color.withValues(alpha: 0.8),
        color.withValues(alpha: 1.0),
        color.withValues(alpha: 0.8),
        color.withValues(alpha: 0.3),
      ],
      stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
    );

    paint.shader = gradient.createShader(rect);

    // 붓의 강약을 표현하기 위한 여러 레이어
    for (int i = 0; i < 3; i++) {
      final layerPaint = Paint()
        ..color = color.withValues(alpha: 0.1 * (3 - i))
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + (i * 2)
        ..strokeCap = StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, i.toDouble());
      
      canvas.drawPath(path, layerPaint);
    }

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(EnsoPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}