import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/services/perplexity/perplexity_api_service.dart';
import '../../domain/entities/issue.dart';
import '../../domain/entities/issue_detail.dart';
import '../../domain/entities/perspective.dart';
import '../../domain/repositories/issue_repository.dart';
import 'issue_repository_mock.dart';

@LazySingleton(as: IssueRepository)
class IssueRepositoryImpl implements IssueRepository {
  final PerplexityApiService _perplexityService;
  final AppConfig _appConfig;
  final SupabaseClient _supabase;
  
  IssueRepositoryImpl(
    this._perplexityService,
    this._appConfig,
  ) : _supabase = Supabase.instance.client;
  
  @override
  Future<Either<Exception, List<Issue>>> getTodaysIssues() async {
    try {
      if (_appConfig.useMockData) {
        // 개발 중에는 mock 데이터 사용
        final issues = await IssueRepositoryMock.getTodaysIssues();
        return Right(issues);
      }
      
      // Production: Supabase에서 데이터 가져오기
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      final response = await _supabase
          .from('issues')
          .select()
          .eq('status', 'published')
          .gte('published_at', startOfDay.toIso8601String())
          .lt('published_at', endOfDay.toIso8601String())
          .order('importance', ascending: false)
          .limit(3);
      
      final issues = (response as List)
          .map((json) => _issueFromJson(json))
          .toList();
          
      return Right(issues);
    } catch (e) {
      return Left(Exception('Failed to fetch today\'s issues: $e'));
    }
  }
  
  @override
  Future<Either<Exception, IssueDetail>> getIssueDetail(String issueId) async {
    try {
      if (_appConfig.useMockData) {
        final detail = await IssueRepositoryMock.getIssueDetail(issueId);
        return Right(detail);
      }
      
      // Production: Supabase에서 데이터 가져오기
      // Get issue basic info
      final issueResponse = await _supabase
          .from('issues')
          .select()
          .eq('id', issueId)
          .single();
      
      final issue = _issueFromJson(issueResponse);
      
      // Get issue details
      final detailsResponse = await _supabase
          .from('issue_details')
          .select()
          .eq('issue_id', issueId)
          .maybeSingle();
      
      // Get perspectives
      final perspectivesResponse = await _supabase
          .from('perspectives')
          .select()
          .eq('issue_id', issueId)
          .order('display_order');
      
      final perspectives = (perspectivesResponse as List)
          .map((json) => _perspectiveFromJson(json))
          .toList();
      
      // Get background knowledge
      final backgroundResponse = await _supabase
          .from('background_knowledge')
          .select()
          .eq('issue_id', issueId)
          .order('display_order');
      
      final backgroundKnowledge = (backgroundResponse as List)
          .map((json) => BackgroundKnowledge(
                id: json['id'],
                title: json['title'],
                content: json['content'],
                category: json['category'],
              ))
          .toList();
      
      // Get fact checks
      final factChecksResponse = await _supabase
          .from('fact_checks')
          .select()
          .eq('issue_id', issueId)
          .order('display_order');
      
      final factChecks = (factChecksResponse as List)
          .map((json) => FactCheck(
                id: json['id'],
                claim: json['claim'],
                verdict: json['verdict'],
                explanation: json['explanation'],
                sources: List<String>.from(json['sources'] ?? []),
              ))
          .toList();
      
      // Get news sources
      final sourcesResponse = await _supabase
          .from('news_sources')
          .select()
          .eq('issue_id', issueId)
          .order('published_at', ascending: false);
      
      final sources = (sourcesResponse as List)
          .map((json) => NewsSource(
                title: json['title'],
                publisher: json['publisher'],
                url: json['url'],
                publishedAt: DateTime.parse(json['published_at']),
              ))
          .toList();
      
      return Right(IssueDetail(
        issue: issue,
        detailedSummary: detailsResponse?['detailed_summary'] ?? issue.summary,
        keyTerms: List<String>.from(detailsResponse?['key_terms'] ?? []),
        termDefinitions: Map<String, String>.from(detailsResponse?['term_definitions'] ?? {}),
        backgroundKnowledge: backgroundKnowledge,
        dataVisualizations: [],
        perspectives: perspectives,
        sources: sources,
        factChecks: factChecks,
      ));
    } catch (e) {
      return Left(Exception('Failed to fetch issue detail: $e'));
    }
  }
  
  @override
  Future<Either<Exception, List<Perspective>>> generatePerspectives(Issue issue) async {
    try {
      if (_appConfig.useMockData) {
        // Mock 데이터에서 관점 가져오기
        final detail = await IssueRepositoryMock.getIssueDetail(issue.id);
        return Right(detail.perspectives);
      }
      
      // Production: Perplexity API 사용
      final perspectivesData = await _perplexityService.generatePerspectives(
        issueTitle: issue.headline,
        issueSummary: issue.summary,
      );
      
      final perspectives = _parsePerspectivesFromResponse(perspectivesData);
      return Right(perspectives);
    } catch (e) {
      return Left(Exception('Failed to generate perspectives: $e'));
    }
  }
  
  Issue _issueFromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'],
      headline: json['headline'],
      summary: json['summary'],
      imageUrl: json['image_url'] ?? '',
      publishedAt: DateTime.parse(json['published_at']),
      categories: List<String>.from(json['categories'] ?? []),
      importance: json['importance'] ?? 3,
      metadata: json['metadata'] ?? {},
    );
  }
  
  Perspective _perspectiveFromJson(Map<String, dynamic> json) {
    return Perspective(
      id: json['id'],
      issueId: json['issue_id'],
      title: json['title'],
      content: json['content'],
      expertName: json['expert_name'],
      expertTitle: json['expert_title'],
      expertImageUrl: json['expert_image_url'],
      stance: json['stance'] ?? 'neutral', // deprecated field
      perspectiveType: json['perspective_type'],
      perspectiveDetail: json['perspective_detail'],
      interactiveQuestions: List<String>.from(json['interactive_questions'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  List<Perspective> _parsePerspectivesFromResponse(List<Map<String, dynamic>> response) {
    // TODO: 실제 응답 파싱 구현
    return [];
  }
}