import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/perplexity/perplexity_api_service.dart';
import '../../domain/entities/issue.dart';
import '../../domain/entities/issue_detail.dart';
import '../../domain/entities/perspective.dart';
import '../../domain/repositories/issue_repository.dart';
import 'issue_repository_mock.dart';

@LazySingleton(as: IssueRepository)
class IssueRepositoryImpl implements IssueRepository {
  final PerplexityApiService _perplexityService;
  final bool _useMockData = true; // 개발 중에는 mock 데이터 사용
  
  IssueRepositoryImpl(this._perplexityService);
  
  @override
  Future<Either<Exception, List<Issue>>> getTodaysIssues() async {
    try {
      if (_useMockData) {
        // 개발 중에는 mock 데이터 사용
        final issues = await IssueRepositoryMock.getTodaysIssues();
        return Right(issues);
      }
      
      // Production: Perplexity API 사용
      final briefingData = await _perplexityService.generateDailyBriefing(
        interests: ['경제', '정치', '기술', '사회'], // TODO: 사용자 설정에서 가져오기
        region: '대한민국',
      );
      
      final issues = _parseIssuesFromResponse(briefingData);
      return Right(issues);
    } catch (e) {
      return Left(Exception('Failed to fetch today\'s issues: $e'));
    }
  }
  
  @override
  Future<Either<Exception, IssueDetail>> getIssueDetail(String issueId) async {
    try {
      if (_useMockData) {
        final detail = await IssueRepositoryMock.getIssueDetail(issueId);
        return Right(detail);
      }
      
      // Production: 실제 구현 필요
      throw UnimplementedError('Production implementation pending');
    } catch (e) {
      return Left(Exception('Failed to fetch issue detail: $e'));
    }
  }
  
  @override
  Future<Either<Exception, List<Perspective>>> generatePerspectives(Issue issue) async {
    try {
      if (_useMockData) {
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
  
  List<Issue> _parseIssuesFromResponse(Map<String, dynamic> response) {
    // TODO: 실제 응답 파싱 구현
    return [];
  }
  
  List<Perspective> _parsePerspectivesFromResponse(List<Map<String, dynamic>> response) {
    // TODO: 실제 응답 파싱 구현
    return [];
  }
}