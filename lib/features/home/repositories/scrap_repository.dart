import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseScrapRepository {
  Future<List<ScrapModel>> getScraps();
  Future<List<ScrapModel>> searchScraps(String key);
}

class FakeScrapRepository implements BaseScrapRepository {
  final List<ScrapModel> _scraps = [
    const ScrapModel(
        id: "1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Glossy Papers"),
    const ScrapModel(
        id: "1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers"),
    const ScrapModel(
        id: "3",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers"),
    const ScrapModel(
        id: "4",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers"),
    const ScrapModel(
        id: "5",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers")
  ];

  @override
  Future<List<ScrapModel>> getScraps() async {
    await Future.delayed(
        const Duration(seconds: 5)); // Add a delay of 5 seconds
    return _scraps;
  }

  @override
  Future<List<ScrapModel>> searchScraps(String key) async {
    return _scraps;
  }
}

class SupabaseScrapRepository implements BaseScrapRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<List<ScrapModel>> getScraps() async {
    try {
      final data = await _supabaseClient.from('scraps').select();
      return data.map((item) => ScrapModel.fromJson(item)).toList();
    } catch (error) {
      throw errorHandler(error);
    }
  }

  @override
  Future<List<ScrapModel>> searchScraps(String key,
      {String? categoryId}) async {
    if (categoryId.isNotNull) {
      try {
        final data = (await _supabaseClient.rpc(
            'search_scraps_with_key_with_category_id',
            params: {'key': key, 'category': categoryId}));
        final list = (data as List).map((e) => ScrapModel.fromJson(e)).toList();
        return list;
      } catch (error) {
        throw SkException('Failed to fetch scraps: $error');
      }
    } else {
      try {
        final data = (await _supabaseClient
            .rpc('search_scraps_with_key', params: {'key': key}));
        final list = (data as List).map((e) => ScrapModel.fromJson(e)).toList();
        return list;
      } catch (error) {
        throw SkException('Failed to fetch scraps: $error');
      }
    }
  }
}
