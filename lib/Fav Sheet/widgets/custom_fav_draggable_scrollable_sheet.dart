import 'dart:ui';
import 'package:e_commerce_app/Fav%20Sheet/widgets/fav_product_card.dart';
import 'package:e_commerce_app/global/widgets/little_grabber_handle.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';

class CustomFavDraggablleScrollableSheet extends StatefulWidget {
  const CustomFavDraggablleScrollableSheet({super.key});

  @override
  State<CustomFavDraggablleScrollableSheet> createState() =>
      _CustomFavDraggablleScrollableSheetState();
}

class _CustomFavDraggablleScrollableSheetState
    extends State<CustomFavDraggablleScrollableSheet> {
  late Future<List<ProductModel>?> _initPerformServce;
  bool isEmptyList = true;
  @override
  void initState() {
    super.initState();
    _initPerformServce = ProductsService().getFavList(context);
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
                      child: FutureBuilder<List<ProductModel>?>(
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
                            List<ProductModel> poductsList = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: poductsList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: FavProductCard(
                                    favProduct: poductsList[index],
                                    onRemoveClicked: () async {
                                      await ProductsService()
                                          .removeProductFromFavList(
                                            context,
                                            poductsList[index],
                                          );
                                      setState(() {
                                        _initPerformServce = ProductsService()
                                            .getFavList(context);
                                      });
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

  FutureBuilder<List<ProductModel>?> decideBuildButtonOrNor() {
    return FutureBuilder<List<ProductModel>?>(
      future: _initPerformServce,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: CustomButton(
              borderRadius: 0,
              text: "ADD ALL TO CART",
              onTap: () {},
              fontWeight: FontWeight.w500,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
