import 'dart:ui';
import 'package:e_commerce_app/Cart%20Sheet/widgets/shopping_cart_product_card.dart';
import 'package:e_commerce_app/Checkout/views/checkout_view.dart';
import 'package:e_commerce_app/Home%20Page/views/card_details_view.dart';
import 'package:e_commerce_app/global/widgets/little_grabber_handle.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class CustomCartDraggablleScrollableSheet extends StatefulWidget {
  const CustomCartDraggablleScrollableSheet({super.key});

  @override
  State<CustomCartDraggablleScrollableSheet> createState() =>
      _CustomDraggablleScrollableSheetState();
}

class _CustomDraggablleScrollableSheetState
    extends State<CustomCartDraggablleScrollableSheet> {
  late Future<Map<ProductModel, int>?> _initPerformServce;
  bool isEmptyList = true;
  @override
  void initState() {
    super.initState();
    _initPerformServce = ProductsService().getShoppingCartList(context);
  }

  void refreshCart() {
    setState(() {
      _initPerformServce = ProductsService().getShoppingCartList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.715,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.white54,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: [
                    const LittleGrabberHandle(),
                    const SizedBox(height: 15),
                    Expanded(
                      child: FutureBuilder<Map<ProductModel, int>?>(
                        future: _initPerformServce,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              isEmptyList = true;
                              return const Center(
                                child: Text(
                                  "No items here yet. Start browsing to add some!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24),
                                ),
                              );
                            }
                            isEmptyList = false;
                            Map<ProductModel, int> productsMap = snapshot.data!;

                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: productsMap.length,
                              itemBuilder: (context, index) {
                                ProductModel product = productsMap.keys
                                    .elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ShoppingCartProductCard(
                                    cartProduct: product,
                                    onQuantityChanged: refreshCart,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => CardDetailsView(
                                                product: product,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                "Oops! , please try again later",
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    decideBuildButtonOrNor(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  FutureBuilder<Map<ProductModel, int>?> decideBuildButtonOrNor() {
    return FutureBuilder<Map<ProductModel, int>?>(
      future: _initPerformServce,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: CustomButton(
              borderRadius: 0,
              text: "PROCEED TO BUY",
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CheckoutView(productsMap: snapshot.data!),
                  ),
                );
                refreshCart();
              },
              fontWeight: FontWeight.w500,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
