import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseScrapRepository {
  Future<void> addScrap(ScrapModel scrap);
  Future<List<ScrapModel>> getScraps();
  Future<void> updateScrap(ScrapModel scrap);
  Future<void> deleteScrap(String scrapId);
}

class FakeScrapRepository implements BaseScrapRepository {
  final List<ScrapModel> _scraps = [
    const ScrapModel(
        id: "i1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Glossy Papers"),
    const ScrapModel(
        id: "i1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers"),  const ScrapModel(
        id: "i1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers"),  const ScrapModel(
        id: "i1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers"),  const ScrapModel(
        id: "i1",
        description:
            "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
        price: 23,
        photoUrl: 'https://picsum.photos/100/100?random=9',
        name: "Coated Papers")
  ];

  @override
  Future<void> addScrap(ScrapModel scrap) async {
    _scraps.add(scrap);
  }

  @override
  Future<List<ScrapModel>> getScraps() async {
    await Future.delayed(
        const Duration(seconds: 5)); // Add a delay of 5 seconds
    return _scraps;
  }

  @override
  Future<void> updateScrap(ScrapModel scrap) async {
    final index = _scraps.indexWhere((s) => s.name == scrap.name);
    if (index != -1) {
      _scraps[index] = scrap;
    }
  }

  @override
  Future<void> deleteScrap(String scrapId) async {
    _scraps.removeWhere((s) => s.name == scrapId);
  }
}

class SupabaseScrapRepository implements BaseScrapRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<void> addScrap(ScrapModel scrap) async {
    try {
      await _supabaseClient.from('scraps').insert(scrap.toJson());
    } catch (error) {
      throw SkException('Failed to add scrap: $error');
    }
  }

  @override
  Future<List<ScrapModel>> getScraps() async {
    try {
      final data = await _supabaseClient.from('scraps').select();
      return data.map((item) => ScrapModel.fromJson(item)).toList();
    } catch (error) {
      throw SkException('Failed to fetch scraps: $error');
    }
  }

  @override
  Future<void> updateScrap(ScrapModel scrap) async {
    try {
      await _supabaseClient
          .from('scraps')
          .update(scrap.toJson())
          .eq('id', scrap.id);
    } catch (error) {
      throw SkException('Failed to update scrap: $error');
    }
  }

  @override
  Future<void> deleteScrap(String scrapId) async {
    try {
      await _supabaseClient.from('scraps').delete().eq('id', scrapId);
    } catch (error) {
      throw SkException('Failed to delete scrap: $error');
    }
  }
}
