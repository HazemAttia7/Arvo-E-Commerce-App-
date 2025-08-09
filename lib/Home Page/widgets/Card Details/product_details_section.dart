import 'package:e_commerce_app/Checkout/views/checkout_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Card%20Details/buy_now_button.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_image_with_indicator_while_loading.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_playfair_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/clickable_modern_underlined_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/price_text.dart';
import 'package:e_commerce_app/Main%20Screen/widgets/custom_shopping_cart_icon_button.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class ProductDetailsSection extends StatefulWidget {
  const ProductDetailsSection({
    super.key,
    required this.product,
    this.isPrevScreenCheckout = false,
  });
  final bool isPrevScreenCheckout;
  final ProductModel product;

  @override
  State<ProductDetailsSection> createState() => _ProductDetailsSectionState();
}

class _ProductDetailsSectionState extends State<ProductDetailsSection> {
  late bool isFavorite;
  @override
  void initState() {
    isFavorite = currentUser?.favList.contains(widget.product) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomImageWithIndicatorWhileLoading(
                    image: widget.product.images[1] ?? widget.product.images[0],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      if (!isFavorite) {
                        ProductsService().removeProductFromFavList(
                          context,
                          widget.product,
                        );
                      } else {
                        ProductsService().addProductToFavList(
                          context,
                          widget.product,
                        );
                      }
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorite
                              ? const Color.fromARGB(255, 255, 118, 108)
                              : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.product.brand != null)
                CustomPlayFairText(fontSize: 22, text: widget.product.brand!),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.product.category.replaceAll("-", " ").toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff848484),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              PriceText(
                price: widget.product.price,
                discountPercentage: widget.product.discountPercentage,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 95),
                child: BuyNowButton(
                  onTap: () async {
                    await ProductsService().addProductToShoppingCart(
                      context,
                      widget.product,
                    );
                    final productsMap = await ProductsService()
                        .getShoppingCartMap(context);

                    if (widget.isPrevScreenCheckout) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  CheckoutView(productsMap: productsMap),
                          settings: const RouteSettings(name: 'checkout'),
                        ),
                      );
                    }
                    CartNotifier.updateCartCount(context);
                  },
                ),
              ),
              const SizedBox(height: 15),
              ClickableModernUnderlinedText(
                text: "add to cart",
                underlineWidth: 110,
                onTap: () async {
                  await ProductsService().addProductToShoppingCart(
                    context,
                    widget.product,
                  );
                  CartNotifier.updateCartCount(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
