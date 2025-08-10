import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class CartNotifier {
  static final ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  static Future<void> updateCartCount(BuildContext context) async {
    final count = await ProductsService().getTotalCartQuantityFromDatabaseFold(
      context,
    );
    cartCount.value = count;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> updateCartCountGlobal() async {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final count = await ProductsService()
          .getTotalCartQuantityFromDatabaseFold(context);
      cartCount.value = count;
    }
  }
}