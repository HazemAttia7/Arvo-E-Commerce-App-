import 'dart:ui';

import 'package:e_commerce_app/Home%20Page/views/card_details_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Browse%20Products/products_grid_view.dart';
import 'package:e_commerce_app/Home%20Page/widgets/Home%20View/custom_latest_product_card.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/models/product_model.dart';
import 'package:e_commerce_app/global/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LatestProductsGridView extends StatefulWidget {
  const LatestProductsGridView({super.key});

  @override
  State<LatestProductsGridView> createState() => _LatestProductsGridViewState();
}

class _LatestProductsGridViewState extends State<LatestProductsGridView>
    implements WidgetsBindingObserver {
  late Future<List<ProductModel>?> _initLatestProductsList;
  @override
  void initState() {
    super.initState();
    _initLatestProductsList = ProductsService().getLatestProducts();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // User is now browsing the app
      _refreshData();
    }
  }

  void _refreshData() {
    setState(() {
      _initLatestProductsList = ProductsService().getLatestProducts();
    });
  }

  Future<void> getFavorites() async {
    currentUser?.favList = await ProductsService().getFavList(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>?>(
      future: _initLatestProductsList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        } else if (snapshot.hasData) {
          List<ProductModel> latestProductsList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ProductsGridView(
              itemBuilder: (BuildContext context, int index) {
                return CustomLatestProductCard(
                  product: latestProductsList[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CardDetailsView(
                              product: latestProductsList[index],
                            ),
                      ),
                    );
                  },
                );
              },
              itemCount: 4,
            ),
          );
        } else {
          return const SizedBox(
            height: 250,
            child: Center(child: Text('No products found.')),
          );
        }
      },
    );
  }

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    // TODO: implement didChangeLocales
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didChangeViewFocus(ViewFocusEvent event) {
    // TODO: implement didChangeViewFocus
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    // TODO: implement didPushRouteInformation
    throw UnimplementedError();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() {
    // TODO: implement didRequestAppExit
    throw UnimplementedError();
  }

  @override
  void handleCancelBackGesture() {
    // TODO: implement handleCancelBackGesture
  }

  @override
  void handleCommitBackGesture() {
    // TODO: implement handleCommitBackGesture
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    // TODO: implement handleStartBackGesture
    throw UnimplementedError();
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    // TODO: implement handleUpdateBackGestureProgress
  }
}
