import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../../../shared/widgets/zen_container.dart';
import '../../domain/entities/issue_detail.dart';
import '../../domain/entities/perspective.dart';
import '../../data/repositories/issue_repository_mock.dart';

@RoutePage()
class IssueDetailScreen extends StatefulWidget {
  final String issueId;
  
  const IssueDetailScreen({
    super.key,
    @PathParam('issueId') required this.issueId,
  });

  @override
  State<IssueDetailScreen> createState() => _IssueDetailScreenState();
}

class _IssueDetailScreenState extends State<IssueDetailScreen> {
  IssueDetail? _issueDetail;
  bool _isLoading = true;
  int _currentPerspectiveIndex = 0;
  final PageController _pageController = PageController();
  final Set<String> _seenPerspectives = {};

  @override
  void initState() {
    super.initState();
    _loadIssueDetail();
  }

  Future<void> _loadIssueDetail() async {
    try {
      final detail = await IssueRepositoryMock.getIssueDetail(widget.issueId);
      setState(() {
        _issueDetail = detail;
        _isLoading = false;
        // Mark the first perspective as seen
        if (detail.perspectives.isNotEmpty) {
          _seenPerspectives.add(detail.perspectives[0].id);
        }
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            )
          : _issueDetail == null
              ? const Center(
                  child: Text('이슈 정보를 불러올 수 없습니다'),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 200,
                      floating: false,
                      pinned: true,
                      backgroundColor: AppColors.background,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          _issueDetail!.issue.categories.join(' · '),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              _issueDetail!.issue.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: AppColors.gray800,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.background.withValues(alpha: 0.7),
                                    AppColors.background,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeadline(),
                            const SizedBox(height: 32),
                            _buildDetailedSummary(),
                            if (_issueDetail!.keyTerms.isNotEmpty) ...[
                              const SizedBox(height: 32),
                              _buildKeyTerms(),
                            ],
                            const SizedBox(height: 32),
                            _buildBackgroundKnowledge(),
                            const SizedBox(height: 32),
                            _buildFactChecks(),
                            const SizedBox(height: 32),
                            _buildSources(),
                            const SizedBox(height: 40),
                            _buildPerspectivesSection(),
                            const SizedBox(height: 32),
                            _buildActionButtons(),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildHeadline() {
    return Text(
      _issueDetail!.issue.headline,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
    );
  }

  Widget _buildDetailedSummary() {
    return ZenContainer(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.article_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '핵심 요약',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _issueDetail!.detailedSummary,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '핵심 용어',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _issueDetail!.keyTerms.map((term) {
            final definition = _issueDetail!.termDefinitions[term];
            return GestureDetector(
              onTap: definition != null
                  ? () => _showTermDefinition(term, definition)
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      term,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (definition != null) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  Widget _buildBackgroundKnowledge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.auto_stories_outlined,
              color: AppColors.secondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '배경 지식',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._issueDetail!.backgroundKnowledge.map((knowledge) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ExpandableKnowledgeCard(knowledge: knowledge),
          );
        }),
      ],
    );
  }
  
  Widget _buildSources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.source_outlined,
              color: AppColors.accent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '참고 자료',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ZenContainer(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _issueDetail!.sources.asMap().entries.map((entry) {
                final index = entry.key;
                final source = entry.value;
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final uri = Uri.parse(source.url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('링크를 열 수 없습니다'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ',
                              style: TextStyle(
                                color: AppColors.textTertiary,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    source.title,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        source.publisher,
                                        style: TextStyle(
                                          color: AppColors.textTertiary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '·',
                                        style: TextStyle(
                                          color: AppColors.textTertiary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _formatSourceDate(source.publishedAt),
                                        style: TextStyle(
                                          color: AppColors.textTertiary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.open_in_new,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index < _issueDetail!.sources.length - 1)
                      Divider(
                        color: AppColors.gray800,
                        height: 1,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
  
  String _formatSourceDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${date.month}월 ${date.day}일';
    }
  }

  Widget _buildPerspectivesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '다각적 관점',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${_currentPerspectiveIndex + 1} / ${_issueDetail!.perspectives.length}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 500, // Fixed height for perspective cards
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPerspectiveIndex = index;
                // Mark perspective as seen
                _seenPerspectives.add(_issueDetail!.perspectives[index].id);
              });
            },
            itemCount: _issueDetail!.perspectives.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildPerspectiveCard(_issueDetail!.perspectives[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildPerspectiveIndicator(),
      ],
    );
  }

  Widget _buildPerspectiveCard(Perspective perspective) {
    return PremiumGlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 전문가 프로필
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                child: Text(
                  perspective.expertName[0],
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      perspective.expertName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      perspective.expertTitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              _buildPerspectiveTypeChip(perspective.perspectiveType, perspective.perspectiveDetail),
            ],
          ),
          const SizedBox(height: 20),
          // 제목
          Text(
            perspective.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 16),
          // 내용
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    perspective.content,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.8,
                        ),
                  ),
                  const SizedBox(height: 24),
                  // 인터랙티브 질문
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.3),
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
                              color: AppColors.accent,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '생각해보기',
                              style: TextStyle(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...perspective.interactiveQuestions.map((question) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '•',
                                    style: TextStyle(
                                      color: AppColors.accent,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      question,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            height: 1.5,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
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

  Widget _buildPerspectiveTypeChip(String type, String detail) {
    Color color;
    
    switch (type) {
      case '이해관계자':
        color = AppColors.primary;
        break;
      case '시간적 관점':
        color = AppColors.secondary;
        break;
      case '전문 분야':
        color = AppColors.accent;
        break;
      case '지역별':
        color = Colors.orange;
        break;
      case '철학적':
        color = Colors.purple;
        break;
      default:
        color = AppColors.textSecondary;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            type,
            style: TextStyle(
              fontSize: 11,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            detail,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerspectiveIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _issueDetail!.perspectives.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPerspectiveIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPerspectiveIndex == index
                ? AppColors.primary
                : AppColors.textTertiary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ZenContainer(
            child: InkWell(
              onTap: () {
                context.router.push(
                  WriteReflectionRoute(
                    issueId: widget.issueId,
                    issueTitle: _issueDetail!.issue.headline,
                    perspectivesSeen: _seenPerspectives.toList(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '이 이슈 성찰하기',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ZenContainer(
            child: InkWell(
              onTap: () {
                context.router.push(const PredictionRoute());
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insights_outlined,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '예측 참여하기',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showTermDefinition(String term, String definition) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.book_outlined,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  term,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              definition,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFactChecks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.fact_check_outlined,
              color: AppColors.accent,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '팩트 체크',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._issueDetail!.factChecks.map((factCheck) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PremiumGlassContainer(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '"${factCheck.claim}"',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildVerdictChip(factCheck.verdict),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    factCheck.explanation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                        ),
                  ),
                  if (factCheck.sources.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.source_outlined,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            factCheck.sources.join(', '),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textTertiary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
  
  Widget _buildVerdictChip(String verdict) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    
    switch (verdict) {
      case '사실':
        backgroundColor = AppColors.success.withValues(alpha: 0.1);
        textColor = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
      case '대체로 사실':
        backgroundColor = AppColors.success.withValues(alpha: 0.05);
        textColor = AppColors.success.withValues(alpha: 0.8);
        icon = Icons.check_circle_outline;
        break;
      case '논란의 여지':
        backgroundColor = AppColors.warning.withValues(alpha: 0.1);
        textColor = AppColors.warning;
        icon = Icons.help_outline;
        break;
      case '오해의 소지':
        backgroundColor = AppColors.warning.withValues(alpha: 0.1);
        textColor = AppColors.warning;
        icon = Icons.warning_amber_outlined;
        break;
      case '거짓':
        backgroundColor = AppColors.error.withValues(alpha: 0.1);
        textColor = AppColors.error;
        icon = Icons.cancel_outlined;
        break;
      default:
        backgroundColor = AppColors.gray800;
        textColor = AppColors.textSecondary;
        icon = Icons.info_outline;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: textColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            verdict,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// 확장 가능한 배경 지식 카드 위젯
class _ExpandableKnowledgeCard extends StatefulWidget {
  final BackgroundKnowledge knowledge;
  
  const _ExpandableKnowledgeCard({
    required this.knowledge,
  });
  
  @override
  State<_ExpandableKnowledgeCard> createState() => _ExpandableKnowledgeCardState();
}

class _ExpandableKnowledgeCardState extends State<_ExpandableKnowledgeCard> {
  bool _isExpanded = false;
  
  @override
  Widget build(BuildContext context) {
    return ZenContainer(
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.secondary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.knowledge.category,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.knowledge.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  widget.knowledge.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}