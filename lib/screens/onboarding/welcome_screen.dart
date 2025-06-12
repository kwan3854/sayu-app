import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../../theme/app_colors.dart';
import '../../widgets/enso_circle.dart';
import '../../widgets/zen_button.dart';
import '../../widgets/zen_container.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      icon: '👁️',
      title: '다양한 관점으로\n세상을 읽는 눈',
      description: '하나의 이슈를 여러 각도에서 바라보며\n균형잡힌 시각을 기르세요',
    ),
    OnboardingItem(
      icon: '🧩',
      title: '예측과 검증으로\n통찰력을 기르는 즐거움',
      description: '실제 결과와 비교하며\n나만의 통찰력을 성장시키세요',
    ),
    OnboardingItem(
      icon: '🌱',
      title: '매일 기록하고 성장하는\n나만의 사유 여정',
      description: '꾸준한 성찰과 기록으로\n생각의 깊이를 더해가세요',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('건너뛰기'),
              ),
            ),
            // Logo
            const SizedBox(height: 40),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
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
            const SizedBox(height: 24),
            Text(
              '사유',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '알고리즘의 소음 속, 고요히 사유할 시간',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '편향 없는 정보, 깊이 있는 통찰,\n스스로 생각하는 힘을 기르세요.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 48),
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildPageItem(_items[index]);
                },
              ),
            ),
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => Container(
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index
                        ? AppColors.primary
                        : AppColors.gray700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // CTA Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('사유 여정 시작하기'),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.icon,
            style: const TextStyle(fontSize: 64),
          ),
          const SizedBox(height: 24),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String icon;
  final String title;
  final String description;

  OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}