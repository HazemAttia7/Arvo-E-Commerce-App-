import 'package:e_commerce_app/Main%20Screen/widgets/bottom_nav_bar_item.dart';
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

class CustomShoppingCartIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;
  const CustomShoppingCartIconButton({super.key, required this.onTap, required this.isSelected});

  @override
  State<CustomShoppingCartIconButton> createState() =>
      _CustomShoppingCartIconButtonState();
}

class _CustomShoppingCartIconButtonState
    extends State<CustomShoppingCartIconButton> {
  @override
  void initState() {
    super.initState();
    // Load initial cart count
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CartNotifier.updateCartCount(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ValueListenableBuilder<int>(
        valueListenable: CartNotifier.cartCount,
        builder: (context, count, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              BottomNavBarItem(
                image: "assets/images/cart icon.png",
                onTap: widget.onTap,
                isSelected: widget.isSelected,
              ),
              if (count > 0)
                Positioned(
                  top: -10,
                  right: -14,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
