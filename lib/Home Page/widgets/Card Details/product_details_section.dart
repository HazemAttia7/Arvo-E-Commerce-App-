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
  const ProductDetailsSection({super.key, required this.product});

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
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomImageWithIndicatorWhileLoading(
                image: widget.product.images[1] ?? widget.product.images[0],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.product.brand != null)
                    CustomPlayFairText(
                      fontSize: 22,
                      text: widget.product.brand!,
                    ),
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
                            .getShoppingCartList(context);
                        // Check if we can pop (meaning there's a previous screen)
                        if (Navigator.canPop(context)) {
                          // Pop to see what's behind, but we'll need to be smart about this
                          Navigator.pop(context);

                          // After popping, check if current screen is checkout
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            final newCurrentRoute = ModalRoute.of(context);

                            // If the route we just revealed has checkout settings, don't push again
                            if (newCurrentRoute?.settings.name == 'checkout' ||
                                newCurrentRoute?.settings.arguments
                                    is Map<ProductModel, int>) {
                              // Previous was checkout, so we're good - just stay here
                              return;
                            } else {
                              // Previous wasn't checkout, so push checkout
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => CheckoutView(
                                        productsMap: productsMap,
                                      ),
                                  settings: const RouteSettings(
                                    name: 'checkout',
                                  ),
                                ),
                              );
                            }
                          });
                        } else {
                          // No previous screen, so just push checkout
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
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        cartIconKey.currentState?.refreshCart();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
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
                ProductsService().addProductToFavList(context, widget.product);
              }
            },
            child:
                isFavorite
                    ? const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 255, 118, 108),
                    )
                    : const Icon(Icons.favorite_border),
          ),
        ),
      ],
    );
  }
}
