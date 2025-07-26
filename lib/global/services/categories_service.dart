import 'dart:developer';
import 'package:dio/dio.dart';

class CategoriesService {

  final Dio dio = Dio();
  
  static const Map<String, String> _subCategoryToBigCategoryMap = {
    "mens-shirts": "men's-fashion",
    "mens-shoes": "men's-fashion",
    "mens-watches": "men's-fashion",

    "womens-bags": "women's-fashion",
    "womens-dresses": "women's-fashion",
    "womens-jewellery": "women's-fashion",
    "womens-shoes": "women's-fashion",
    "womens-watches": "women's-fashion",
    "tops": "women's-fashion",

    "smartphones": "electronics",
    "laptops": "electronics",
    "mobile-accessories": "electronics",
    "tablets": "electronics",

    "furniture": "home & living",
    "home-decoration": "home & living",
    "kitchen-accessories": "home & living",
  };

  static const Set<String> _generalCategoriesSet = {
    "beauty",
    "fragrances",
    "groceries",
    "motorcycle",
    "skin-care",
    "sports-accessories",
    "sunglasses",
    "vehicle",
  };

  Future<List<String>?> getAllCategoriesFiltered() async {
    try {
      Response response = await dio.get(
        'https://dummyjson.com/products/category-list',
      );
      List<String> apiCategories = List<String>.from(response.data);

      List<String> filteredCategories = _filterAndGroupCategories(
        apiCategories,
      );
      return filteredCategories;
    } on DioException catch (e) {
      log('Error fetching categories: ${e.message}', name: "Debug Error");
      return [];
    } catch (e) {
      log('An unexpected error occurred: $e', name: "Debug Error");
      return [];
    }
  }

  List<String> _filterAndGroupCategories(List<String> apiCategories) {
    Set<String> uniqueFilteredCategories = {};
    for (String category in apiCategories) {
      if (_subCategoryToBigCategoryMap.containsKey(category)) {
        uniqueFilteredCategories.add(_subCategoryToBigCategoryMap[category]!);
      } else if (_generalCategoriesSet.contains(category)) {
        uniqueFilteredCategories.add(category);
      }
    }
    List<String> result = uniqueFilteredCategories.toList();
    result.sort();
    return result;
  }
}
