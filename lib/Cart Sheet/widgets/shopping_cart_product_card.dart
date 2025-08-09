import 'package:e_commerce_app/Cart%20Sheet/widgets/quantity_widget.dart';
import 'package:e_commerce_app/Home%20Page/widgets/clickable_modern_underlined_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_playfair_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/price_text.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class ShoppingCartProductCard extends StatefulWidget {
  const ShoppingCartProductCard({
    super.key,
    required this.cartProduct,
    required this.onQuantityChanged,
    required this.onTap,
  });
  final ProductModel cartProduct;
  final VoidCallback onQuantityChanged;
  final VoidCallback onTap;
  @override
  State<ShoppingCartProductCard> createState() =>
      _ShoppingCartProductCardState();
}

class _ShoppingCartProductCardState extends State<ShoppingCartProductCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: CustomImageWithIndicatorWhileLoading(
                  image:
                      widget.cartProduct.images[0] ??
                      "assets/images/image placeholder.png",
                  height: 130,
                  boxFit: BoxFit.contain,
                ),
              ),
              Column(
                children: [
                  QuantityWidget(
                    subOnTap: () async {
                      await ProductsService().removeProductFromShoppingCart(
                        context,
                        widget.cartProduct,
                      );
                      final currentQuantity =
                          currentUser?.shoppingCart[widget.cartProduct] ?? 0;
                      if (currentQuantity <= 0) {
                        // Notify parent to refresh and remove this product
                        widget.onQuantityChanged();
                      } else {
                        setState(() {});
                      }
                    },
                    addOnTap: () async {
                      await ProductsService().addProductToShoppingCart(
                        context,
                        widget.cartProduct,
                        showMessage: false,
                      );
                      setState(() {});
                    },
                    quantity:
                        currentUser?.shoppingCart[widget.cartProduct] ?? 0,
                  ),
                  const SizedBox(height: 5),
                  ClickableModernUnderlinedText(
                    text: "Remove All",
                    onTap: () async {
                      // Remove all quantities of this specific product from cart
                      await ProductsService()
                          .removeProductEntirelyFromShoppingCart(
                            context,
                            widget.cartProduct,
                          );
                      // Notify parent to refresh the cart UI
                      widget.onQuantityChanged();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.cartProduct.brand != null)
                CustomPlayFairText(
                  fontSize: 22,
                  text: widget.cartProduct.brand!,
                ),
              const SizedBox(height: 10),

              Text(
                widget.cartProduct.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff848484),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              PriceText(
                price: widget.cartProduct.price,
                discountPercentage: widget.cartProduct.discountPercentage,
                mul: currentUser?.shoppingCart[widget.cartProduct] ?? 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
