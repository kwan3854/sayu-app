import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ThoughtHabitScreen extends StatefulWidget {
  const ThoughtHabitScreen({super.key});

  @override
  State<ThoughtHabitScreen> createState() => _ThoughtHabitScreenState();
}

class _ThoughtHabitScreenState extends State<ThoughtHabitScreen> {
  int _currentStep = 0;
  
  // 선택된 옵션들
  final Set<String> _selectedSources = {};
  final Set<String> _selectedImportance = {};
  final Set<String> _selectedFields = {};
  String _insightType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('생각 습관 진단'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentStep + 1) / 4,
              backgroundColor: AppColors.gray800,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildCurrentStep(),
              ),
            ),
            // Bottom Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _currentStep--;
                          });
                        },
                        child: const Text('이전'),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _canProceed() ? () {
                        if (_currentStep < 3) {
                          setState(() {
                            _currentStep++;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      } : null,
                      child: Text(_currentStep == 3 ? '완료' : '다음'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedSources.isNotEmpty;
      case 1:
        return _selectedImportance.isNotEmpty;
      case 2:
        return _selectedFields.isNotEmpty;
      case 3:
        return _insightType.isNotEmpty;
      default:
        return false;
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildSourcesStep();
      case 1:
        return _buildImportanceStep();
      case 2:
        return _buildFieldsStep();
      case 3:
        return _buildInsightStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildSourcesStep() {
    final sources = [
      '유튜브',
      '뉴스 앱',
      'SNS',
      '전문가 블로그',
      '팟캐스트',
      '책/논문',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '평소 정보를 어디서 얻으시나요?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '여러 개를 선택할 수 있습니다',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        ...sources.map((source) => _buildCheckboxTile(
          title: source,
          isSelected: _selectedSources.contains(source),
          onTap: () {
            setState(() {
              if (_selectedSources.contains(source)) {
                _selectedSources.remove(source);
              } else {
                _selectedSources.add(source);
              }
            });
          },
        )),
      ],
    );
  }

  Widget _buildImportanceStep() {
    final factors = [
      '속보성',
      '심층 분석',
      '다양한 관점',
      '신뢰성',
      '실용성',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '정보를 소비할 때\n가장 중요하게 생각하는 것은?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '최대 2개까지 선택 가능합니다',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        ...factors.map((factor) => _buildCheckboxTile(
          title: factor,
          isSelected: _selectedImportance.contains(factor),
          onTap: () {
            setState(() {
              if (_selectedImportance.contains(factor)) {
                _selectedImportance.remove(factor);
              } else if (_selectedImportance.length < 2) {
                _selectedImportance.add(factor);
              }
            });
          },
        )),
      ],
    );
  }

  Widget _buildFieldsStep() {
    final fields = [
      '경제',
      '기술',
      '정치',
      '사회',
      '문화',
      '과학',
      '예술',
      '환경',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '어떤 분야의 비판적 사고력을\n기르고 싶으신가요?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '관심 있는 분야를 모두 선택해주세요',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: fields.map((field) => _buildChipButton(
            label: field,
            isSelected: _selectedFields.contains(field),
            onTap: () {
              setState(() {
                if (_selectedFields.contains(field)) {
                  _selectedFields.remove(field);
                } else {
                  _selectedFields.add(field);
                }
              });
            },
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildInsightStep() {
    final insights = [
      '투자 전략',
      '미래 기술 트렌드',
      '사회 현상 분석',
      '정책 영향',
      '문화 흐름 이해',
      '기타',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '선택한 분야에서\n어떤 종류의 통찰을 얻고 싶으신가요?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '가장 관심 있는 것을 선택해주세요',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        ...insights.map((insight) => _buildRadioTile(
          title: insight,
          value: insight,
          groupValue: _insightType,
          onChanged: (value) {
            setState(() {
              _insightType = value ?? '';
            });
          },
        )),
      ],
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.gray800,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.gray600,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : null,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.background,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChipButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.gray700,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24),
            color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile({
    required String title,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChanged(value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: value == groupValue ? AppColors.primary : AppColors.gray800,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
              color: value == groupValue ? AppColors.primary.withOpacity(0.1) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: value == groupValue ? AppColors.primary : AppColors.gray600,
                      width: 2,
                    ),
                  ),
                  child: value == groupValue
                      ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}