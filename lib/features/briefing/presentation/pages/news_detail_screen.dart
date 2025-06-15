import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/premium_glass_container.dart';
import '../../../../shared/widgets/zen_container.dart';
import '../../domain/entities/daily_briefing.dart';

@RoutePage()
class NewsDetailScreen extends StatefulWidget {
  final NewsItem newsItem;

  const NewsDetailScreen({
    super.key,
    required this.newsItem,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  int _currentPerspectiveIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '뉴스 ${widget.newsItem.position}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
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
                  if (widget.newsItem.keyTerms.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _buildKeyTerms(),
                  ],
                  if (widget.newsItem.backgroundContext != null) ...[
                    const SizedBox(height: 32),
                    _buildBackgroundKnowledge(),
                  ],
                  const SizedBox(height: 32),
                  _buildFactCheck(),
                  if (widget.newsItem.sources.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _buildSources(),
                  ],
                  if (widget.newsItem.perspectives.isNotEmpty) ...[
                    const SizedBox(height: 40),
                    _buildPerspectivesSection(),
                  ],
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
      widget.newsItem.title,
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
            // 요약 내용을 문단별로 처리
            ..._formatSummary(widget.newsItem.summary).map((paragraph) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  paragraph,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 상세 내용
            Text(
              '상세 내용',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            ..._formatContent(widget.newsItem.mainContent).map((paragraph) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  paragraph,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                      ),
                  textAlign: TextAlign.justify,
                ),
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
          children: widget.newsItem.keyTerms.map((term) {
            return GestureDetector(
              onTap: () => _showTermDefinition(term.term, term.definition),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      term.term,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.primary.withOpacity(0.7),
                    ),
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
    // 배경 지식을 구조화된 형태로 파싱
    final backgroundItems = _parseBackgroundKnowledge(widget.newsItem.backgroundContext!);
    
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
        ...backgroundItems.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ExpandableKnowledgeCard(
              title: item['title']!,
              content: item['content']!,
              category: item['category']!,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFactCheck() {
    // 팩트체크를 구조화된 형태로 파싱
    final factItems = _parseFactCheck(widget.newsItem.factCheck);
    
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
        ...factItems.map((fact) {
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
                          '"${fact['claim']}"',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildVerdictChip(fact['verdict']!),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    fact['explanation']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                        ),
                  ),
                ],
              ),
            ),
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
              children: widget.newsItem.sources.asMap().entries.map((entry) {
                final index = entry.key;
                final source = entry.value;
                return Column(
                  children: [
                    InkWell(
                      onTap: () => _launchUrl(source.url),
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
                              child: Text(
                                source.title,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                    ),
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
                    if (index < widget.newsItem.sources.length - 1)
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
              '${_currentPerspectiveIndex + 1} / ${widget.newsItem.perspectives.length}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 450,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPerspectiveIndex = index;
              });
            },
            itemCount: widget.newsItem.perspectives.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildPerspectiveCard(widget.newsItem.perspectives[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildPerspectiveIndicator(),
      ],
    );
  }

  Widget _buildPerspectiveCard(NewsPerspective perspective) {
    // 전문가 정보 파싱
    final expertInfo = _parseExpertInfo(perspective.expert);
    
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
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: Text(
                  expertInfo['name']![0],
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
                      expertInfo['name']!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      expertInfo['title']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              if (expertInfo['type'] != null)
                _buildPerspectiveTypeChip(expertInfo['type']!, expertInfo['detail'] ?? ''),
            ],
          ),
          const SizedBox(height: 20),
          // 내용
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                perspective.viewpoint,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                    ),
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
      case '정부':
      case '정책':
        color = AppColors.primary;
        break;
      case '경제':
      case '산업':
        color = AppColors.secondary;
        break;
      case '학계':
      case '전문가':
        color = AppColors.accent;
        break;
      case '시민':
      case '사회':
        color = Colors.orange;
        break;
      default:
        color = AppColors.textSecondary;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPerspectiveIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.newsItem.perspectives.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPerspectiveIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPerspectiveIndex == index
                ? AppColors.primary
                : AppColors.textTertiary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildVerdictChip(String verdict) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    
    switch (verdict) {
      case 'verified':
      case '사실':
        backgroundColor = AppColors.success.withOpacity(0.1);
        textColor = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
      case 'partially_verified':
      case '대체로 사실':
        backgroundColor = AppColors.success.withOpacity(0.05);
        textColor = AppColors.success.withOpacity(0.8);
        icon = Icons.check_circle_outline;
        break;
      case 'disputed':
      case '논란의 여지':
        backgroundColor = AppColors.warning.withOpacity(0.1);
        textColor = AppColors.warning;
        icon = Icons.help_outline;
        break;
      case 'false':
      case '거짓':
        backgroundColor = AppColors.error.withOpacity(0.1);
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
          color: textColor.withOpacity(0.3),
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

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Helper 함수들
  List<String> _formatSummary(String summary) {
    // 불릿포인트가 있으면 구분하고, 없으면 문장별로 구분
    if (summary.contains('•') || summary.contains('-')) {
      return summary.split(RegExp(r'[•\-]'))
          .where((s) => s.trim().isNotEmpty)
          .map((s) => '• ${s.trim()}')
          .toList();
    }
    // 마침표로 문장 구분
    return summary.split('.')
        .where((s) => s.trim().isNotEmpty)
        .map((s) => '${s.trim()}.')
        .toList();
  }

  List<String> _formatContent(String content) {
    // 문단 구분 (2개 이상의 줄바꿈 또는 들여쓰기)
    return content.split(RegExp(r'\n\n+'))
        .where((s) => s.trim().isNotEmpty)
        .map((s) => s.trim())
        .toList();
  }

  List<Map<String, String>> _parseBackgroundKnowledge(String context) {
    // 배경 지식을 카테고리별로 파싱
    final items = <Map<String, String>>[];
    final sections = context.split(RegExp(r'\n(?=[가-힣]+:)'));
    
    for (final section in sections) {
      if (section.contains(':')) {
        final parts = section.split(':');
        final title = parts[0].trim();
        final content = parts.sublist(1).join(':').trim();
        
        // 카테고리 추측
        String category = '배경';
        if (title.contains('역사') || title.contains('과거')) {
          category = '역사적 맥락';
        } else if (title.contains('경제') || title.contains('시장')) {
          category = '경제적 배경';
        } else if (title.contains('정치') || title.contains('정책')) {
          category = '정치적 배경';
        } else if (title.contains('사회') || title.contains('문화')) {
          category = '사회적 맥락';
        }
        
        items.add({
          'title': title,
          'content': content,
          'category': category,
        });
      }
    }
    
    // 파싱이 안 되면 전체를 하나의 항목으로
    if (items.isEmpty) {
      items.add({
        'title': '배경 설명',
        'content': context,
        'category': '종합',
      });
    }
    
    return items;
  }

  List<Map<String, String>> _parseFactCheck(FactCheck factCheck) {
    // 팩트체크 상세 내용을 파싱
    final items = <Map<String, String>>[];
    
    // 기본 팩트체크 항목 추가
    items.add({
      'claim': '주요 주장',
      'verdict': factCheck.status,
      'explanation': factCheck.details,
    });
    
    // 상세 내용에서 추가 주장들을 파싱
    if (factCheck.details.contains('주장:') || factCheck.details.contains('사실:')) {
      final lines = factCheck.details.split('\n');
      String currentClaim = '';
      String currentExplanation = '';
      
      for (final line in lines) {
        if (line.startsWith('주장:') || line.startsWith('사실:')) {
          if (currentClaim.isNotEmpty) {
            items.add({
              'claim': currentClaim,
              'verdict': _determineVerdict(currentExplanation),
              'explanation': currentExplanation,
            });
          }
          currentClaim = line.replaceAll(RegExp(r'^(주장|사실):'), '').trim();
          currentExplanation = '';
        } else {
          currentExplanation += ' $line';
        }
      }
    }
    
    return items;
  }

  Map<String, String> _parseExpertInfo(String expert) {
    // "홍길동 (한국경제연구원 연구위원)" 형태를 파싱
    final match = RegExp(r'(.+?)\s*\((.+?)\)').firstMatch(expert);
    if (match != null) {
      final name = match.group(1)!;
      final title = match.group(2)!;
      
      // 소속 기관에서 타입 추측
      String type = '전문가';
      if (title.contains('정부') || title.contains('부') || title.contains('청')) {
        type = '정부';
      } else if (title.contains('대학') || title.contains('연구')) {
        type = '학계';
      } else if (title.contains('기업') || title.contains('산업')) {
        type = '산업';
      } else if (title.contains('시민') || title.contains('협회')) {
        type = '시민';
      }
      
      return {
        'name': name,
        'title': title,
        'type': type,
      };
    }
    
    return {
      'name': expert,
      'title': '전문가',
      'type': '전문가',
    };
  }

  String _determineVerdict(String explanation) {
    if (explanation.contains('확인') || explanation.contains('사실')) {
      return '사실';
    } else if (explanation.contains('부분') || explanation.contains('일부')) {
      return '대체로 사실';
    } else if (explanation.contains('논란') || explanation.contains('의견')) {
      return '논란의 여지';
    } else if (explanation.contains('거짓') || explanation.contains('오류')) {
      return '거짓';
    }
    return '미확인';
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// 확장 가능한 배경 지식 카드 위젯
class _ExpandableKnowledgeCard extends StatefulWidget {
  final String title;
  final String content;
  final String category;
  
  const _ExpandableKnowledgeCard({
    required this.title,
    required this.content,
    required this.category,
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
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.category,
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
                      widget.title,
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
                  widget.content,
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