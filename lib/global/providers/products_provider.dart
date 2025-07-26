import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/global/models/product_model.dart';

final productsServiceProvider = Provider((ref) => ProductsService());

final selectedSubcategoryProvider = StateProvider<String>((ref) => "All");

final filteredProductsProvider = FutureProvider.family<
  List<ProductModel>?,
  String?
>((ref , currentBigCategory) async {
  final productsService = ref.watch(
    productsServiceProvider,
  ); 
  final selectedSubcategory = ref.watch(
    selectedSubcategoryProvider,
  ); 

  if (currentBigCategory == null) {
    return [];
  }

  if (selectedSubcategory == "All") {
    return productsService.getProductsByCategory(
      categoryName: currentBigCategory,
    );
  } else {
    return productsService.getProductsByCategory(
      categoryName: selectedSubcategory,
    );
  }
});
