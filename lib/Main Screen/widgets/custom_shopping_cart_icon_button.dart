import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

// Singleton key manager
class CartIconKeyManager {
  static final CartIconKeyManager _instance = CartIconKeyManager._internal();
  factory CartIconKeyManager() => _instance;
  CartIconKeyManager._internal();

  final Map<String, GlobalKey<_CustomShoppingCartIconButtonState>> _keys = {};

  GlobalKey<_CustomShoppingCartIconButtonState> getKey(String id) {
    _keys[id] ??= GlobalKey<_CustomShoppingCartIconButtonState>(
      debugLabel: 'cart_$id',
    );
    return _keys[id]!;
  }

  void refreshCart(String id) {
    _keys[id]?.currentState?.refreshCart();
  }

  void refreshAllCarts() {
    for (var key in _keys.values) {
      key.currentState?.refreshCart();
    }
  }
}

// Global access to the main cart key
final GlobalKey<_CustomShoppingCartIconButtonState> cartIconKey =
    CartIconKeyManager().getKey('main');

class CustomShoppingCartIconButton extends StatefulWidget {
  CustomShoppingCartIconButton({
    Key? key,
    required this.onTap,
    String? keyId, // Identifier for this specific instance
  }) : super(key: key ?? CartIconKeyManager().getKey(keyId ?? 'main'));

  final VoidCallback onTap;

  @override
  State<CustomShoppingCartIconButton> createState() =>
      _CustomShoppingCartIconButtonState();
}

class _CustomShoppingCartIconButtonState
    extends State<CustomShoppingCartIconButton> {
  void refreshCart() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: FutureBuilder<int>(
        future: ProductsService().getTotalCartQuantityFromDatabaseFold(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset("assets/images/cart icon.png", width: 25),
                if (snapshot.data! > 0)
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
                          snapshot.data!.toString(),
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
          } else {
            return Image.asset("assets/images/cart icon.png", width: 25);
          }
        },
      ),
    );
  }
}
