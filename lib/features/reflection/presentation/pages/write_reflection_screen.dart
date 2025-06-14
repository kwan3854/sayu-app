import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../domain/entities/reflection.dart';
import '../../data/repositories/reflection_repository_mock.dart';

@RoutePage()
class WriteReflectionScreen extends StatefulWidget {
  final String issueId;
  final String issueTitle;
  final List<String> perspectivesSeen;
  final String? predictionMade;
  
  const WriteReflectionScreen({
    super.key,
    required this.issueId,
    required this.issueTitle,
    required this.perspectivesSeen,
    this.predictionMade,
  });

  @override
  State<WriteReflectionScreen> createState() => _WriteReflectionScreenState();
}

class _WriteReflectionScreenState extends State<WriteReflectionScreen> {
  final _contentController = TextEditingController();
  final _contentFocusNode = FocusNode();
  bool _isSaving = false;
  int _wordCount = 0;
  
  final List<String> _prompts = [
    '이 이슈에 대한 나의 생각은...',
    '가장 설득력 있었던 관점은...',
    '예상과 달랐던 부분은...',
    '더 알아보고 싶은 점은...',
    '이 이슈가 나에게 미치는 영향은...',
  ];
  
  @override
  void initState() {
    super.initState();
    _contentController.addListener(_updateWordCount);
  }
  
  void _updateWordCount() {
    final text = _contentController.text;
    final wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    setState(() {
      _wordCount = wordCount;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('성찰 기록'),
        actions: [
          TextButton(
            onPressed: _contentController.text.trim().isEmpty || _isSaving
                ? null
                : _saveReflection,
            child: Text(
              '저장',
              style: TextStyle(
                color: _contentController.text.trim().isEmpty || _isSaving
                    ? AppColors.textTertiary
                    : AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이슈 정보
            PremiumGlassContainer(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 20,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '성찰하는 이슈',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.issueTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.visibility_outlined,
                        label: '${widget.perspectivesSeen.length}개 관점 읽음',
                      ),
                      if (widget.predictionMade != null) ...[
                        const SizedBox(width: 12),
                        _buildInfoChip(
                          icon: Icons.psychology_outlined,
                          label: '예측 참여함',
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 프롬프트
            Text(
              '생각 정리하기',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _prompts.map((prompt) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        if (_contentController.text.isNotEmpty) {
                          _contentController.text += '\n\n$prompt\n';
                        } else {
                          _contentController.text = '$prompt\n';
                        }
                        _contentController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _contentController.text.length),
                        );
                        _contentFocusNode.requestFocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.gray800,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          prompt,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 작성 영역
            PremiumGlassContainer(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _contentController,
                    focusNode: _contentFocusNode,
                    maxLines: null,
                    minLines: 10,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                    decoration: InputDecoration(
                      hintText: '이 이슈에 대한 나의 생각을 자유롭게 기록해보세요...',
                      hintStyle: TextStyle(
                        color: AppColors.textTertiary,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$_wordCount 단어',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
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
  
  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gray800,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _saveReflection() async {
    if (_contentController.text.trim().isEmpty || _isSaving) return;
    
    setState(() {
      _isSaving = true;
    });
    
    final reflection = Reflection(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      issueId: widget.issueId,
      issueTitle: widget.issueTitle,
      content: _contentController.text.trim(),
      perspectivesSeen: widget.perspectivesSeen,
      predictionMade: widget.predictionMade,
      createdAt: DateTime.now(),
      tags: _extractTags(_contentController.text),
      wordCount: _wordCount,
    );
    
    await ReflectionRepositoryMock.saveReflection(reflection);
    
    if (mounted) {
      // AI 피드백을 보여주는 다이얼로그
      _showAIFeedback(reflection);
    }
  }
  
  void _showAIFeedback(Reflection reflection) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                '성찰이 저장되었습니다',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
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
                        Icon(
                          Icons.psychology_outlined,
                          size: 20,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI 사고 분석',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _generateAIFeedback(reflection),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.router.maybePop();
                      },
                      child: Text(
                        '닫기',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: Navigate to reflection history
                        context.router.maybePop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('내 성찰 보기'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _generateAIFeedback(Reflection reflection) {
    // Mock AI 피드백 생성
    final feedbacks = [
      '${reflection.perspectivesSeen.length}개의 다양한 관점을 검토하신 점이 인상적입니다. 특히 경제적 측면과 사회적 영향을 균형있게 고려하셨네요. 다음번엔 장기적 관점에서의 영향도 생각해보시면 좋겠습니다.',
      '논리적이고 체계적인 사고 과정을 보여주셨습니다. 근거를 제시하며 주장을 전개한 점이 좋았습니다. 반대 의견에 대한 반박도 추가하면 더욱 설득력 있는 논증이 될 것 같습니다.',
      '개인적 경험과 객관적 사실을 잘 연결하여 서술하셨습니다. 감정과 이성의 균형이 잘 잡혀있네요. 구체적인 실행 방안까지 제시했다면 더 완성도 높은 성찰이 되었을 것입니다.',
    ];
    
    return feedbacks[DateTime.now().millisecond % feedbacks.length];
  }
  
  List<String> _extractTags(String content) {
    // 간단한 태그 추출 로직 (향후 AI로 개선 가능)
    final tags = <String>[];
    if (content.contains('경제')) tags.add('경제');
    if (content.contains('정치')) tags.add('정치');
    if (content.contains('기술')) tags.add('기술');
    if (content.contains('사회')) tags.add('사회');
    if (content.contains('환경')) tags.add('환경');
    return tags;
  }
  
  @override
  void dispose() {
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }
}