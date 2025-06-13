import '../../domain/entities/reflection.dart';

class ReflectionRepositoryMock {
  static final List<Reflection> _reflections = [];
  
  static Future<List<Reflection>> getReflections() async {
    await Future.delayed(const Duration(seconds: 1));
    return _reflections;
  }
  
  static Future<void> saveReflection(Reflection reflection) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _reflections.insert(0, reflection);
  }
  
  static Future<List<Reflection>> getReflectionsByIssue(String issueId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _reflections.where((r) => r.issueId == issueId).toList();
  }
  
  static Future<Map<String, int>> getReflectionStats() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thisWeek = now.subtract(const Duration(days: 7));
    final thisMonth = DateTime(now.year, now.month, 1);
    
    final todayCount = _reflections.where((r) => r.createdAt.isAfter(today)).length;
    final weekCount = _reflections.where((r) => r.createdAt.isAfter(thisWeek)).length;
    final monthCount = _reflections.where((r) => r.createdAt.isAfter(thisMonth)).length;
    final totalCount = _reflections.length;
    
    return {
      'today': todayCount,
      'week': weekCount,
      'month': monthCount,
      'total': totalCount,
    };
  }
}