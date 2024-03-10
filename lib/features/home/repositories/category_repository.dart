import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/models/scrap_category/scrap_category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseCategoryRepository {
  Future<void> addCategory(ScrapCategoryModel category);
  Future<List<ScrapCategoryModel>> getCategories();
  Future<void> updateCategory(ScrapCategoryModel category);
  Future<void> deleteCategory(String categoryId);
}

class FakeCategoryRepository implements BaseCategoryRepository {
  FakeCategoryRepository() {
    for (var element in _categoryData) {
      _categories.add(ScrapCategoryModel.fromJson(element));
    }
  }

  final _categoryData = [
    {
      "id": '1',
      "name": "Category 1",
      "photoUrl": "https://picsum.photos/80/80?random=1"
    },
    {
      "id": "2",
      "name": "Category 2",
      "photoUrl": "https://picsum.photos/80/80?random=2"
    },
    {
      "id": "3",
      "name": "Category 3",
      "photoUrl": "https://picsum.photos/80/80?random=3"
    },
    {
      "id": "4",
      "name": "Category 4",
      "photoUrl": "https://picsum.photos/80/80?random=4"
    },
    {
      "id": "5",
      "name": "Category 5",
      "photoUrl": "https://picsum.photos/80/80?random=5"
    },
    {
      "id": "6",
      "name": "Category 6",
      "photoUrl": "https://picsum.photos/80/80?random=6"
    },
    {
      "id": "7",
      "name": "Category 7",
      "photoUrl": "https://picsum.photos/80/80?random=7"
    },
    {
      "id": "8",
      "name": "Category 8",
      "photoUrl": "https://picsum.photos/80/80?random=8"
    },
    {
      "id": "9",
      "name": "Category 9",
      "photoUrl": "https://picsum.photos/80/80?random=9"
    },
    {
      "id": "10",
      "name": "Category 10",
      "photoUrl": "https://picsum.photos/80/80?random=10"
    }
  ];

  final List<ScrapCategoryModel> _categories = [];

  @override
  Future<void> addCategory(ScrapCategoryModel category) async {
    _categories.add(category);
  }

  @override
  Future<List<ScrapCategoryModel>> getCategories() async {
    return await Future.delayed(const Duration(seconds: 4), () {
      return _categories;
    });
  }

  @override
  Future<void> updateCategory(ScrapCategoryModel category) async {
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    _categories.removeWhere((c) => c.id == categoryId);
  }
}

class SupabaseCategoryRepository implements BaseCategoryRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<void> addCategory(ScrapCategoryModel category) async {
    try {
      await _supabaseClient.from('categories').insert(category.toJson());
    } catch (error) {
      throw SkException('Failed to add category: $error');
    }
  }

  @override
  Future<List<ScrapCategoryModel>> getCategories() async {
    try {
      final data = await _supabaseClient.from('categories').select();
      return data.map((item) => ScrapCategoryModel.fromJson(item)).toList();
    } catch (error) {
      throw SkException('Failed to fetch categories: $error');
    }
  }

  @override
  Future<void> updateCategory(ScrapCategoryModel category) async {
    try {
      await _supabaseClient
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id);
    } catch (error) {
      throw SkException('Failed to update category: $error');
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _supabaseClient.from('categories').delete().eq('id', categoryId);
    } catch (error) {
      throw SkException('Failed to delete category: $error');
    }
  }
}
