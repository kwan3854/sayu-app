import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/daily_briefing_model.dart';

abstract class BriefingRemoteDataSource {
  Future<DailyBriefingModel?> getTodaysBriefing(String countryCode, String? region);
  Future<void> generateDailyBriefing(String countryCode, String? region);
}

@LazySingleton(as: BriefingRemoteDataSource)
class BriefingRemoteDataSourceImpl implements BriefingRemoteDataSource {
  final SupabaseClient _supabase;

  BriefingRemoteDataSourceImpl(this._supabase);

  @override
  Future<DailyBriefingModel?> getTodaysBriefing(String countryCode, String? region) async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      
      var query = _supabase
          .from('daily_briefings')
          .select('''
            *,
            news_items (*)
          ''')
          .eq('country_code', countryCode)
          .eq('briefing_date', today);

      if (region != null) {
        query = query.eq('region', region);
      }

      final data = await query.maybeSingle();

      if (data == null) {
        return null;
      }

      // Parse the response
      final topics = (data['topics'] as List<dynamic>)
          .map((t) => BriefingTopicModel.fromJson(t as Map<String, dynamic>))
          .toList();

      final newsItems = (data['news_items'] as List<dynamic>? ?? [])
          .map((item) => NewsItemModel(
                id: item['id'],
                briefingId: item['briefing_id'],
                position: item['position'],
                title: item['title'],
                summary: item['summary'],
                mainContent: item['main_content'],
                keyTerms: (item['key_terms'] as List<dynamic>? ?? [])
                    .map((kt) => KeyTermModel.fromJson(kt as Map<String, dynamic>))
                    .toList(),
                backgroundContext: item['background_context'],
                factCheck: item['fact_check'] != null
                    ? FactCheckModel.fromJson(item['fact_check'] as Map<String, dynamic>)
                    : const FactCheckModel(status: 'unverified', details: ''),
                sources: (item['sources'] as List<dynamic>? ?? [])
                    .map((s) => SourceModel.fromJson(s as Map<String, dynamic>))
                    .toList(),
                perspectives: (item['perspectives'] as List<dynamic>? ?? [])
                    .map((p) => PerspectiveModel.fromJson(p as Map<String, dynamic>))
                    .toList(),
                perplexitySearchId: item['perplexity_search_id'],
                createdAt: DateTime.parse(item['created_at']),
              ))
          .toList();

      return DailyBriefingModel(
        id: data['id'],
        countryCode: data['country_code'],
        region: data['region'],
        briefingDate: DateTime.parse(data['briefing_date']),
        topics: topics,
        newsItems: newsItems,
        createdAt: DateTime.parse(data['created_at']),
      );
    } catch (e) {
      if (e is PostgrestException && e.code == 'PGRST116') {
        // No briefing found for today
        return null;
      }
      throw Exception('Failed to fetch daily briefing: $e');
    }
  }

  @override
  Future<void> generateDailyBriefing(String countryCode, String? region) async {
    try {
      final response = await _supabase.functions.invoke(
        'generate-daily-briefing',
        body: {
          'country_code': countryCode,
          'region': region,
        },
      );

      if (response.data['error'] != null) {
        throw Exception(response.data['error']);
      }
    } catch (e) {
      throw Exception('Failed to generate daily briefing: $e');
    }
  }
}