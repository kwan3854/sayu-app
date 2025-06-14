import 'package:dartz/dartz.dart';
import '../entities/issue.dart';
import '../entities/issue_detail.dart';
import '../entities/perspective.dart';

abstract class IssueRepository {
  Future<Either<Exception, List<Issue>>> getTodaysIssues();
  Future<Either<Exception, IssueDetail>> getIssueDetail(String issueId);
  Future<Either<Exception, List<Perspective>>> generatePerspectives(Issue issue);
}